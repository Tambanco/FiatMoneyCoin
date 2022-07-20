//
//  ConvertedModel.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 19.07.2022.
//

import Foundation

struct ConvertedModel: Codable {
    let motd: MOTDConverted
    let success: Bool
    let query: Query
    let info: Info
    let historical: Bool
    let date: String
    let result: Double
}

struct Info: Codable {
    let rate: Double
}

struct MOTDConverted: Codable {
    let msg: String
    let url: String
}

struct Query: Codable {
    let from, to: String
    let amount: Int
}
