//
//  Currency+CoreDataProperties.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 31.07.2022.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var baseCurrency: String?
    @NSManaged public var convertedValue: String?
    @NSManaged public var currencySymbol: String?
    @NSManaged public var totalCurrency: String?

}

extension Currency : Identifiable {

}
