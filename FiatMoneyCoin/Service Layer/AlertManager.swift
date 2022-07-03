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
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Введите сумму"
            alertTextField.keyboardType = .decimalPad
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Выберите валюту"
            
        }

        let addAction = UIAlertAction(title: "Добавить", style: .default, handler: { action in
            print("dobavit")
        })
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            view?.present(viewControllerToPresent: alert)
        }
    }
}
