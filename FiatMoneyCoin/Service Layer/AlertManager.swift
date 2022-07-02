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
            alertTextField.autocapitalizationType = .sentences
        }
        
        let pickerViewFrame = CGRect(x: 0, y: 0, width: 250, height: 300)
        let pickerViewRadius = UIPickerView(frame: pickerViewFrame)
        
        alert.view.addSubview(pickerViewRadius)

        let addAction = UIAlertAction(title: "Добавить", style: .default, handler: { action in
            print("dobavit")
        })
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.view.addConstraint(NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300))
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        view?.setupView(currencyList: ["String"])
        DispatchQueue.main.async {
            view?.present(viewControllerToPresent: alert)
        }
    }
}
