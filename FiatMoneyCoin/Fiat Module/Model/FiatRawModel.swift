//
//  FiatRawModel.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 28.06.2022.
//
//  Template generated by Tambanco
//

import Foundation

struct FiatRawModel: Codable {
    let motd: MOTDFiat
    let success: Bool
    let symbols: [String: Symbol]
}

struct MOTDFiat: Codable {
    let msg: String
    let url: String
}

struct Symbol: Codable {
    let symbolDescription: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case symbolDescription = "description"
        case code
    }
}
