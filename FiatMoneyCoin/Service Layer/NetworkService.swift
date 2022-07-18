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
    func getCurrencyList(completion: @escaping (Result<[Symbol]?, Error>) -> Void)
}

final class NewtworkService: NetworkServiceProtocol {
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
