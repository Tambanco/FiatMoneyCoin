//
//  ModuleBuilder.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 29.06.2022.
//

import Foundation
import UIKit

protocol Builder: AnyObject {
    static func createFiatModule() -> UIViewController
    static func createCurrencyModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createFiatModule() -> UIViewController {
        let model = FiatModel(amount: 0, from: "EUR", to: "RUB")
        let view = FiatViewController()
        let presenter = FiatPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
    
    static func createCurrencyModule() -> UIViewController {
        let currencyListTest: [String] = []
        let model = CurrencyModel(amount: "", symbols: currencyListTest)
        let view = CurrencyViewController()
        let presenter = CurrencyPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
