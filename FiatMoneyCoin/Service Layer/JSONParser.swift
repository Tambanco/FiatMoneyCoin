//
//  JSONParser.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

protocol Parcerable: AnyObject {
    static func parseJSONCurrencyList(json: Data) -> [String]
}

class JSONParser: Parcerable {
    
    static func parseJSONCurrencyList(json: Data) -> [String] {

        let decoder = JSONDecoder()
        var fiatsSymbols: [String] = []
        
        do {
            let fiatList = try decoder.decode(FiatRawModel.self, from: json)
            fiatsSymbols = fiatList.symbols.compactMap{ "\($0.description) \($1.symbolDescription)" }.sorted()
            
        } catch {
            print("parsing failure")
        }
        
        return fiatsSymbols
    }
}
