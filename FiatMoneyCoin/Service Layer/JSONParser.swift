//
//  JSONParser.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import Foundation

protocol Parcelable: AnyObject {
    static func parseJSON<T: Decodable>(json: Data, model: T)
}

class JSONParser: Parcelable {
    static func parseJSON<T>(json: Data, model: T) where T : Decodable {
        let decoder = JSONDecoder()
        do {
            let fiatLatest = try decoder.decode(model.self as! T.Type, from: json)
            print(fiatLatest)
        } catch {
            print("parsing failure")
        }
//        let fiatLatest = try? decoder.decode(model.self, from: json)
//        print(fiatLatest ?? )
    }
    
//    static func parseJSON(json: Data) {
//        let decoder = JSONDecoder()
//        let fiatLatest = try? decoder.decode(FiatRawModel.self, from: json)
//        print(fiatLatest ?? "parsing failure")
//    }
}
