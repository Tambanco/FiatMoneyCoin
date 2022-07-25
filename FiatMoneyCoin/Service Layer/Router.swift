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
    var newCurrency: NewCurrencyModel? { get set }
    func initialViewController()
    func showCurrencyView()
    func popToRoot()
}

class Router: RouterProtocol {
    var newCurrency: NewCurrencyModel? = NewCurrencyModel()
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let fiatViewController = assemblyBuilder?.createFiatModule(router: self) else { return }
            navigationController.pushViewController(fiatViewController, animated: true)
        }
    }
    
    func showCurrencyView() {
        if let navigationController = navigationController {
            guard let currencyViewController = assemblyBuilder?.createCurrencyModule(router: self) else { return }
            navigationController.pushViewController(currencyViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    deinit {
        print("Route deinit")
    }
}
