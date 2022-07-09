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
            guard let fiatViewController = assemblyBuilder?.createFiatModule(router: self, amount: "0", currencySymbol: "foo") else { return }
            navigationController.viewControllers = [fiatViewController]
        }
    }
    
    func showCurrencyView(symbol: [String]) {
        if let navigationController = navigationController {
            guard let currencyViewController = assemblyBuilder?.createCurrencyModule(router: self, currencyList: symbol) else { return }
            navigationController.pushViewController(currencyViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
