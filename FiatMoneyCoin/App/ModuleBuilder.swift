//
//  ModuleBuilder.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 29.06.2022.
//

import Foundation
import UIKit

protocol Builder {
    static func createFiatModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createFiatModule() -> UIViewController {
        let model = FiatModel(amount: 1500, from: "EUR", to: "RUB")
        let view = FiatViewController()
        let presenter = FiatPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
