//
//  JSONParser.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

protocol Parcelable: AnyObject {
    static func parseJSONCurrencyList(json: Data)
    static func parseJSONConvertedCurrency(json: Data)
}

class JSONParser: Parcelable {
    static func parseJSONCurrencyList(json: Data) {
        let decoder = JSONDecoder()
        do {
            let fiatList = try decoder.decode(CurrencyListModel.self, from: json)
            print(fiatList)
            
        } catch {
            print("parsing failure")
        }
    }
    
    static func parseJSONConvertedCurrency(json: Data) {
        let decoder = JSONDecoder()
        do {
            let convertedCurrency = try decoder.decode(FiatRawModel.self, from: json)
            print(convertedCurrency)
        } catch {
            print("parsing failure")
        }
    }
}
