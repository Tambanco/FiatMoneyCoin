//
//  JSONParser.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

protocol Parcerable: AnyObject {
    static func parseCurrencyList(json: Data) -> [String]
    static func parseConvertedResult(json: Data) -> String?
}

class JSONParser: Parcerable {
    static func parseCurrencyList(json: Data) -> [String] {
        let decoder = JSONDecoder()
        var fiatsSymbols: [String] = []
        
        do {
            let fiatList = try decoder.decode(FiatRawModel.self, from: json)
            fiatsSymbols = fiatList.symbols.compactMap{ "\($0.description) \($1.symbolDescription)" }.sorted()
        } catch {
            print("parsing symbols failure")
        }
        
        return fiatsSymbols
    }
    
    static func parseConvertedResult(json: Data) -> String? {
        let decoder = JSONDecoder()
        var convertedValue: String?
        
        do {
            let converted = try decoder.decode(ConvertedModel.self, from: json)
            let convertedDouble = converted.result
            let convertedTrimedValue = Double(round(100 * convertedDouble) / 100)
            convertedValue = String(convertedTrimedValue)
            
        } catch {
            print("parsing result of conversion failure")
        }
        
        return convertedValue
    }
}
