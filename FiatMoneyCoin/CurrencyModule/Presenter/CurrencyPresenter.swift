//
//  CurrencyPresenter.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 05.07.2022.
//
//  Template generated by Tambanco
//

import Foundation
import UIKit

// MARK: Output protocol
protocol CurrencyViewProtocol: AnyObject {
    func setTotalValue(currencyList: [String])
    func present(viewControllerToPresent: UIViewController)
}

// MARK: Input protocol
protocol CurrencyPresenterProtocol: AnyObject {
    var currencyList: [String] { get set }
    
    func getCurrencyList()
    func setNewValueForCurrency(newCurrencyValue: String, newCurrencySymbol: String)
    func cancelAdding()
    init(router: RouterProtocol, view: CurrencyViewProtocol, model:  CurrencyModel)
}

class CurrencyPresenter: CurrencyPresenterProtocol {
    var currencyList: [String] = []
    
    weak var view: CurrencyViewProtocol?
    var router: RouterProtocol?
    var model: CurrencyModel
    
    func setNewValueForCurrency(newCurrencyValue: String, newCurrencySymbol: String) {
        router?.setNewValues(value: newCurrencyValue, symbol: newCurrencySymbol)
    }
    
    func getCurrencyList() {
        view?.setTotalValue(currencyList: model.symbols)
    }
    
    func cancelAdding() {
        router?.popToRoot()
    }
    
    required init(router: RouterProtocol, view: CurrencyViewProtocol, model: CurrencyModel) {
        self.router = router
        self.view = view
        self.model = model
    }
}
