//
//  FiatPresenter.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 28.06.2022.
//
//  Template generated by Tambanco
//

import Foundation
import UIKit

// MARK: Output protocol
protocol FiatViewProtocol: AnyObject {
    func setupTableView(currencyList: [String])
    func setupTotalValue(totalValue: String, earnValue: String, earnPercent: String)
    func present(viewControllerToPresent: UIViewController)
}

// MARK: Input protocol
protocol FiatPresenterProtocol: AnyObject {
    var currencyList: [String] { get set }
    func getCurrencyList()
    func getConvert()
    func showAddAlert()
    func caculateTotalFiat()
    init(view: FiatViewProtocol, model:  FiatModel)

}

class FiatPresenter: FiatPresenterProtocol {
    
    
    var currencyList: [String] = []
    weak var view: FiatViewProtocol?
    var model: FiatModel
    
    func caculateTotalFiat() {
        let totalValue = 0
        let earnValue = -100
        let earnPercent = 0
        
        self.view?.setupTotalValue(totalValue: "\(totalValue)", earnValue: "\(earnValue)", earnPercent: "\(earnPercent) %")
    }
    
    func getCurrencyList() {
        NetworkManager.getSymbols()
    }
    
    func showAddAlert() {
        AlertManager.showAddAlert(title: "Currency List", message: "", view: view)
    }
    
    
    func getConvert() {
        NetworkManager.getConvert(amount: 1500, from: "EUR", to: "RUB")
    }
    
    required init(view: FiatViewProtocol, model: FiatModel) {
        self.view = view
        self.model = model
    }
}
