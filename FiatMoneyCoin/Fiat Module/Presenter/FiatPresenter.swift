//
//  FiatPresenter.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 28.06.2022.
//
//  Template generated by Tambanco
//

import Foundation

// MARK: Output protocol
protocol FiatViewProtocol: AnyObject {
    func setupView()
}

// MARK: Input protocol
protocol FiatPresenterProtocol: AnyObject {
    var currencyList: [String] { get set }
    func getCurrencyList()
    func getConvert()
    init(view: FiatViewProtocol, model:  FiatModel)

}

class FiatPresenter: FiatPresenterProtocol {
    var currencyList: [String] = []
    
    func getCurrencyList() {
        
    }
    
    
    weak var view: FiatViewProtocol?
    var model: FiatModel
    
    func getConvert() {
        NetworkManager.getConvert(amount: 1500, from: "EUR", to: "RUB")
    }
    
    required init(view: FiatViewProtocol, model: FiatModel) {
        self.view = view
        self.model = model
    }
}
