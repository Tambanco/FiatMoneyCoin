//
//  NewCurrency+CoreDataProperties.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 16.08.2022.
//
//

import Foundation
import CoreData


extension NewCurrency {
    
    convenience init(symbol: String?, value: String?) {
        self.init()
        self.newValue = value
        self.newSymbolCode = newSymbolCode
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewCurrency> {
        return NSFetchRequest<NewCurrency>(entityName: "NewCurrency")
    }

    @NSManaged public var newSymbolCode: String?
    @NSManaged public var newValue: String?

}

extension NewCurrency : Identifiable {

}
