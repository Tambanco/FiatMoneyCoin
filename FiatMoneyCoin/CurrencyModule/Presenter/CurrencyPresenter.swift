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
    init(router: RouterProtocol, view: CurrencyViewProtocol, model:  CurrencyModel)
    func getCurrencyList()
    func setNewValueForFiatCell(newValueForCell: String, symbol: String)
    func cancelAdding()
}

class CurrencyPresenter: CurrencyPresenterProtocol {
    weak var view: CurrencyViewProtocol?
    var router: RouterProtocol?
    var model: CurrencyModel
    
    func setNewValueForFiatCell(newValueForCell: String, symbol: String) {
        router?.updateFiatView(amount: newValueForCell, symbol: symbol)
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
