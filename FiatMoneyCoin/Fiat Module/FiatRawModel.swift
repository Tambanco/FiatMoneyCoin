//
//  FiatModel.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 28.06.2022.
//
//  Template generated by Tambanco
//

import Foundation

struct FiatRawModel: Decodable {
    
    let success: Bool
    let timestamp: String?
    let base: String?
    let date: String?
    let rates: [String?]
}
