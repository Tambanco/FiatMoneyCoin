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
    func saveNewValue(newValue: String?, newSymbol: String?)
    func saveCurency(totalValue: String?, convertedValue: String?, currencySymbol: String?)
    func removeCurrency(object: NSManagedObject)
}

class StorageService: StorageServiceProtocol {
    func saveCurency(totalValue: String?, convertedValue: String?, currencySymbol: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Currency", in: managedContext)!
        let currency = NSManagedObject(entity: entity, insertInto: managedContext)
        currency.setValue(totalValue, forKey: "totalCurrency")
        currency.setValue(convertedValue, forKey: "convertedValue")
        currency.setValue(currencySymbol, forKey: "currencySymbol")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error.localizedDescription)")
        }
    }
    
    func removeCurrency(object: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(object)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error.localizedDescription)")
        }
    }
    
    func saveNewValue(newValue: String?, newSymbol: String?) {
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
}
