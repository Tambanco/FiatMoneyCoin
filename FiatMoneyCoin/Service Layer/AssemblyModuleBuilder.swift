//
//  ModuleBuilder.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 29.06.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol: AnyObject {
    func createFiatModule(router: RouterProtocol, amount: String, currencySymbol: String) -> UIViewController
    func createCurrencyModule(router: RouterProtocol, currencyList: [String]) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createFiatModule(router: RouterProtocol, amount: String, currencySymbol: String) -> UIViewController {
        let model = FiatModel(amount: amount, symbol: currencySymbol)
        let view = FiatViewController()
        let presenter = FiatPresenter(view: view, model: model, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCurrencyModule(router: RouterProtocol, currencyList: [String]) -> UIViewController {
        let model = CurrencyModel(amount: "0", symbols: currencyList)
        let view = CurrencyViewController()
        let presenter = CurrencyPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
