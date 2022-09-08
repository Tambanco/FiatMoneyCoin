//
//  FiatCalculator.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 26.07.2022.
//

import Foundation
import CoreData

protocol FiatCalculatorProtocol: AnyObject {
    func calculateTotalValue(values: [NSManagedObject]) -> String?
}

class FiatCalculator: FiatCalculatorProtocol {
    func calculateTotalValue(values: [NSManagedObject]) -> String? {
        var baseCurrencyStringValues: [String] = []
        var doubleValues: [Double] = []
        
        var trimDoubleValues: [Double] = []
        _ = values.compactMap { elements in
            let newBaseValue = elements.value(forKey: "convertedValue")
            baseCurrencyStringValues.append(newBaseValue as? String ?? "0")
        }
        
        _ = baseCurrencyStringValues.compactMap { stringValue in
            let newDoubleValue = Double(stringValue)
            doubleValues.append(newDoubleValue ?? 0)
        }
        
        doubleValues.forEach { element in
            let newTrimValue = Double(round(100 * element) / 100)
            trimDoubleValues.append(newTrimValue)
        }
        
        let totalSum = trimDoubleValues.reduce(0, +)
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        let priceString = currencyFormatter.string(from: NSNumber(value: totalSum))
        
        return priceString
    }
}
