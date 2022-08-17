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
    func saveToCoreData(newData: NewCurrency?, entityName: String, key: String)
}

class StorageService: StorageServiceProtocol {
    func saveToCoreData(newData: NewCurrency?, entityName: String, key: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let objectToSave = NSManagedObject(entity: entity, insertInto: managedContext)
        do {
            try managedContext.save()
            objectToSave.setValue(newData, forKey: key)
        } catch let error as NSError {
            print("Could not save. \(error.localizedDescription)")
        }
    }
}
