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
    func saveNewCurrency(newValue: String?, newSymbol: String?)
}

class StorageService: StorageServiceProtocol {
    func saveNewCurrency(newValue: String?, newSymbol: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "NewCurrency", in: managedContext)!
        let newCurrency = NSManagedObject(entity: entity, insertInto: managedContext)
        newCurrency.setValue(newValue, forKey: "newValue")
        newCurrency.setValue(newSymbol, forKey: "newSymbolCode")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error.localizedDescription)")
        }
    }
    
    
    
//    func saveToCoreData(newData: NewCurrency?, entityName: String, key: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
//        let objectToSave = NSManagedObject(entity: entity, insertInto: managedContext)
//        do {
//            try managedContext.save()
//            objectToSave.setValue(newData, forKey: key)
//        } catch let error as NSError {
//            print("Could not save. \(error.localizedDescription)")
//        }
//    }
}
