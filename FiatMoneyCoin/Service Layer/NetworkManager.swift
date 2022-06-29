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

final class NetworkManager {
    static func getLatest(base: String, symbols: String) {
        let semaphore = DispatchSemaphore (value: 0)
        
        let url = "https://api.apilayer.com/fixer/latest?symbols=\(symbols)&base=\(base)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("3a11lBtAQyGHH4mlHEUiMhPOGMYmOb3r", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            JSONParser.parseJSON(json: data)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}
