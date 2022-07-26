//
//  FiatCalculator.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 26.07.2022.
//

import Foundation

protocol FiatCalculatorProtocol: AnyObject {
    func calculateTotalValue(values: [FiatModel]) -> String?
}

class FiatCalculator: FiatCalculatorProtocol {
    func calculateTotalValue(values: [FiatModel]) -> String? {
        var baseCurrencyValues: [String] = []
        let mapedValues = values.compactMap { elements in
            let newBaseValue = elements.amountBaseCurrency
            baseCurrencyValues.append(newBaseValue)
        }
        
        return baseCurrencyValues.first
    }
}
