//
//  NetworkManager.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol NetworkServiceProtocol: Codable {
//    static func getSymbols() -> [String]
    func getCurrencyList(completion: @escaping (Result<[Symbol]?, Error>) -> Void)
}

final class NewtworlService: NetworkServiceProtocol {
    func getCurrencyList(completion: @escaping (Result<[Symbol]?, Error>) -> Void) {
        let urlString = "https://api.exchangerate.host/symbols"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let object = try JSONDecoder().decode([Symbol].self, from: data!)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

final class NetworkManager {
    static func getSymbols() -> [String] {
        let semaphore = DispatchSemaphore (value: 0)
        
        var fiatsList: [String] = []
        
        let url = "https://api.exchangerate.host/symbols"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            let json = String(data: data, encoding: .utf8)!.data(using: .utf8)!
            fiatsList = JSONParser.parseJSONCurrencyList(json: json)
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        return fiatsList
    }
}
