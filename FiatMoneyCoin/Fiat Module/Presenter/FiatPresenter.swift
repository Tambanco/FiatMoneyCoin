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
    var fiatCurrencyList: [FiatModel] { get set }
    var baseCurrency: String { get set }
    var convertedCurrency: String? { get set }
    func showCurrencyView()
    func fetchCurrency()
    func currencyConverter(amount: String?, symbol: String?)
    init(router: RouterProtocol, view: FiatViewProtocol, networkService: NetworkServiceProtocol)
}

class FiatPresenter: FiatPresenterProtocol {
    var baseCurrency: String = "RUB"
    var convertedCurrency: String?
    var fiatCurrencyList: [FiatModel] = []
    
    weak var view: FiatViewProtocol?
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    
    func fetchCurrency() {
        let amountCurrency = router?.newCurrency?.newValue
        let amountCurrencySymbol = router?.newCurrency?.newSymbol
        currencyConverter(amount: amountCurrency, symbol: amountCurrencySymbol)
    }
    
    func currencyConverter(amount: String?, symbol: String?) {
        guard symbol != nil else { return }
        let symbolToConvert = symbol!
        let currencyCode = String(symbolToConvert.prefix(3))
        networkService?.convertTwoCurrensies(from: currencyCode, to: baseCurrency, amount: amount!, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let convertedValue):
                    self.convertedCurrency = convertedValue
                    let amountCurrency = self.router?.newCurrency?.newValue
                    let amountCurrencySymbol = self.router?.newCurrency?.newSymbol
                    
                    let newValue = FiatModel(amountCurrency: amountCurrency ?? "foo",
                                             amountCurrencySymbol: amountCurrencySymbol ?? "bar",
                                             amountBaseCurrency: self.baseCurrency,
                                             convertedValue: "\(self.convertedCurrency!) \(self.baseCurrency)")
                    self.fiatCurrencyList.append(newValue)
                    self.view?.updateFiatView()
                case .failure(let error):
                    print(error)
                }
            }
        }
        )
    }
    
    func showCurrencyView() {
        router?.showCurrencyView()
    }
    
    required init(router: RouterProtocol, view: FiatViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    deinit {
        print("FiatPresenter deinited")
    }
}
