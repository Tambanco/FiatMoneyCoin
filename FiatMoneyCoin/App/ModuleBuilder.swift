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
        let model = FiatModel(base: "RUB", symbols: "USD")
        let view = FiatViewController()
        let presenter = FiatPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
