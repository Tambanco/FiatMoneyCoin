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
    func success()
    func failure(error: Error)
}

// MARK: Input protocol
protocol CurrencyPresenterProtocol: AnyObject {
    var symbols: [String]? { get set }
    func cancel()
    init(router: RouterProtocol, view: CurrencyViewProtocol, networkService: NetworkServiceProtocol)
}

class CurrencyPresenter: CurrencyPresenterProtocol {
    var symbols: [String]? = []
    
    weak var view: CurrencyViewProtocol?
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    
    func cancel() {
        router?.popToRoot()
    }
    
    required init(router: RouterProtocol, view: CurrencyViewProtocol, networkService: NetworkServiceProtocol) {
        self.router = router
        self.view = view
        self.networkService = networkService
        
        getSymbols()
    }
    
    func getSymbols() {
        networkService?.getCurrencyList(completion: { [weak self] result in  // проверить утечки памяти
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let symbols):
                    self.symbols = symbols
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
}
