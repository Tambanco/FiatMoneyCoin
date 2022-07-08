//
//  Router.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 09.07.2022.
//

import Foundation
import UIKit

protocol Router {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol {
    func initialViewController()
    func showCurrencyView(amount: String, symbol: String)
    func popToRoot()
}
