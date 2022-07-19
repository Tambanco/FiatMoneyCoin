//
//  NewtworkService.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol NetworkServiceProtocol: Codable {
    func getCurrencyList(completion: @escaping (Result<[String]?, Error>) -> Void)
}

final class NewtworkService: NetworkServiceProtocol {
    func getCurrencyList(completion: @escaping (Result<[String]?, Error>) -> Void) {
        
        let urlString = "https://api.exchangerate.host/symbols"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            let json = String(data: data, encoding: .utf8)!.data(using: .utf8)!
            var fiatList: [String] = []
            fiatList = JSONParser.parseJSONCurrencyList(json: json)
            completion(.success(fiatList))
        }
        task.resume()
    }
}
