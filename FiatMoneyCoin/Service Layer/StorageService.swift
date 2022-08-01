//
//  StorageService.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 31.07.2022.
//

import Foundation
import CoreData

protocol StorageServiceProtocol: AnyObject {
    func saveToCoreData(newValue: String)
}

class StorageService: StorageServiceProtocol {
    var fiatCurrencies: [NSManagedObject] = []
    
    func saveToCoreData(newValue: String) {
        print("method called")
    }
    
}
