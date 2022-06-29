//
//  JSONParser.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

protocol Parcelable: AnyObject {
    static func parseJSON(json: Data)
}

class JSONParser: Parcelable {
    static func parseJSON(json: Data) {
        let decoder = JSONDecoder()
        let fiatLatest = try? decoder.decode(FiatModel.self, from: json)
        print(fiatLatest?.rates ?? "parse failure")
    }
}
