//
//  JSONParser.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

protocol Parcerable: AnyObject {
    static func parseJSONCurrencyList(json: Data) -> [String]
    static func parseJSONConvertedCurrency(json: Data)
}

class JSONParser: Parcerable {
    
    static func parseJSONCurrencyList(json: Data) -> [String] {

        let decoder = JSONDecoder()
        var fiatsSymbols: [String] = []
        
        do {
            let fiatList = try decoder.decode(CurrencyListModel.self, from: json)
//            print(fiatList)
            fiatsSymbols = fiatList.symbols.compactMap { $0.key }
//            print(fiats)
        } catch {
            print("parsing failure")
        }
        
        return fiatsSymbols
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
