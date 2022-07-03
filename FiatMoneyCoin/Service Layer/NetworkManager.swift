//
//  NetworkManager.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

protocol NetworkManagerProtocol: Codable {
    static func getSymbols() -> [String]
    static func getConvert(amount: Float, from: String, to: String)
}

final class NetworkManager: NetworkManagerProtocol {
    static func getSymbols() -> [String] {
        let semaphore = DispatchSemaphore (value: 0)
        
        var fiatsList: [String] = []
        
        let url = "https://api.apilayer.com/fixer/symbols"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("3a11lBtAQyGHH4mlHEUiMhPOGMYmOb3r", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
//            print(String(data: data, encoding: .utf8)!)
            let json = String(data: data, encoding: .utf8)!.data(using: .utf8)!
            fiatsList = JSONParser.parseJSONCurrencyList(json: json)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return fiatsList
    }
    
    static func getConvert(amount: Float, from: String, to: String) {
        let semaphore = DispatchSemaphore (value: 0)
        
        let url = "https://api.apilayer.com/fixer/convert?to=\(to)&from=\(from)&amount=\(amount)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("3a11lBtAQyGHH4mlHEUiMhPOGMYmOb3r", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            let json = String(data: data, encoding: .utf8)!.data(using: .utf8)!
            JSONParser.parseJSONConvertedCurrency(json: json)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    //    static func getLatest(base: String, symbols: String) {
    //        let semaphore = DispatchSemaphore (value: 0)
    //
    //        let url = "https://api.apilayer.com/fixer/latest?symbols=\(symbols)&base=\(base)"
    //        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    //        request.httpMethod = HTTPMethod.get.rawValue
    //        request.addValue("3a11lBtAQyGHH4mlHEUiMhPOGMYmOb3r", forHTTPHeaderField: "apikey")
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            guard let data = data else {
    //                print(String(describing: error))
    //                return
    //            }
    //            print(String(data: data, encoding: .utf8)!)
    //            let json = String(data: data, encoding: .utf8)!.data(using: .utf8)!
    //            JSONParser.parseJSON(json: json)
    //            semaphore.signal()
    //        }
    //
    //        task.resume()
    //        semaphore.wait()
    //    }
}
