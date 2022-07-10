//
//  ModuleBuilder.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 29.06.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol: AnyObject {
    func createFiatModule(router: RouterProtocol, newValueForCell: String, symbol: String) -> UIViewController
    func createCurrencyModule(router: RouterProtocol, currencyList: [String]) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createFiatModule(router: RouterProtocol, newValueForCell: String, symbol: String) -> UIViewController {
        let model = FiatModel(valueForCell: newValueForCell, symbol: symbol)
        let view = FiatViewController()
        let presenter = FiatPresenter(router: router, view: view, model:  model)
        view.presenter = presenter
        return view
    }
    
    func createCurrencyModule(router: RouterProtocol, currencyList: [String]) -> UIViewController {
        let model = CurrencyModel(symbols: currencyList)
        let view = CurrencyViewController()
        let presenter = CurrencyPresenter(router: router, view: view, model: model)
        view.presenter = presenter
        return view
    }
}
