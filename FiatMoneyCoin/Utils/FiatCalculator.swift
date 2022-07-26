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
        print(values)
        return values.amountBaseCurrency
    }
}
