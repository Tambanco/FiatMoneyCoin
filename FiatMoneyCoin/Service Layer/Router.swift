//
//  Router.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 09.07.2022.
//

import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showCurrencyView(symbol: [String])
    func setFiatView(amount: String, symbol: String) -> (String, String)
    func updateFiatView()
    func popToRoot()
}

class Router: RouterProtocol {
    
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let fiatViewController = assemblyBuilder?.createFiatModule(router: self, newValueForCell: "foo", symbol: "bar") else { return }
            navigationController.pushViewController(fiatViewController, animated: true)
        }
    }
    
    func showCurrencyView(symbol: [String]) {
        if let navigationController = navigationController {
            guard let currencyViewController = assemblyBuilder?.createCurrencyModule(router: self, currencyList: symbol) else { return }
            navigationController.pushViewController(currencyViewController, animated: true)
        }
    }
    
    func setFiatView(amount: String, symbol: String) -> (String, String) {
        let amount = amount
        let symbol = symbol
        
        return (amount, symbol)
    }
    
    func updateFiatView() {
        <#code#>
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
