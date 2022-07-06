//
//  CurrencyListModel.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 30.06.2022.
//

import Foundation

struct CurrencyListModel: Codable {
    let success: Bool
    let symbols: [String : String]
}
