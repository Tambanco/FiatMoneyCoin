//
//  AlertManager.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 30.06.2022.
//

import Foundation
import UIKit

enum AlertManager {
    static func showAddAlert(title: String, message: String, view: FiatViewProtocol?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        view?.setupView(currencyList: ["String"])
        DispatchQueue.main.async {
            view?.present(viewControllerToPresent: alert)
        }
    }
}
