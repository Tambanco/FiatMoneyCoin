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
    func updateFiatView()
}

// MARK: Input protocol
protocol FiatPresenterProtocol: AnyObject {
    var fiatCurrencyList: [FiatModel]? { get set }
    func showCurrencyView()
    func fetchCurrency()
    init(router: RouterProtocol, view: FiatViewProtocol, networkService: NetworkServiceProtocol)
}

class FiatPresenter: FiatPresenterProtocol {
    var fiatCurrencyList: [FiatModel]? = []
    weak var view: FiatViewProtocol?
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    
    func fetchCurrency() {
        let newCurrencyValue = router?.currencyValue
        let newSymbolValue = router?.currencySymbol
        if newSymbolValue != nil {
            fiatCurrencyList?.append(FiatModel.init(valueForCell: newCurrencyValue, symbol: newSymbolValue))
            view?.updateFiatView()
        }
    }
    func showCurrencyView() {
        router?.showCurrencyView()
    }
    
    required init(router: RouterProtocol, view: FiatViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
}
