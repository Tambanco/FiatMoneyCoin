//
//  StorageService.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 31.07.2022.
//

import Foundation
import UIKit
import CoreData

protocol StorageServiceProtocol: AnyObject {
    func saveToCoreData(newValue: String)
}

class StorageService: StorageServiceProtocol {
    var fiatCurrencies: [NSManagedObject] = []

    func saveToCoreData(newValue: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Currency", in: managedContext)!
        let currency = NSManagedObject(entity: entity, insertInto: managedContext)
        
        currency.setValue(newValue, forKey: "totalCurrency")
        
        do {
            try managedContext.save()
            fiatCurrencies.append(currency)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
