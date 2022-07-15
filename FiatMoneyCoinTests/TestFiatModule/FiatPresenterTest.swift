//
//  FiatPresenterTest.swift
//  FiatMoneyCoinTests
//
//  Created by tambanco 🥳 on 14.07.2022.
//

import XCTest
@testable import FiatMoneyCoin

class MockView: FiatViewProtocol {
    var valueTest: String?
    var symbolTest: String?
    var totalValueTest: String?
    var earnValueTest: String?
    var earnPercentTest: String?
    
    func addNewCurrency(value: String, symbol: String) {
        self.valueTest = value
        self.symbolTest = symbol
    }
    
    func setupTotalValue(totalValue: String, earnValue: String, earnPercent: String) {
        self.totalValueTest = totalValue
        self.earnValueTest = earnValue
        self.earnPercentTest = earnPercent
    }
}

class MockRouter: RouterProtocol {
    var currencySymbol: String?
    
    var currencyValue: String?
    
    func initialViewController() {
        
    }
    
    func showCurrencyView() {
        
    }
    
    func setNewValues(value: String, symbol: String) {
        
    }
    
    func popToRoot() {
        
    }
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    
}

class FiatPresenterTest: XCTestCase {
    var view: FiatViewProtocol!
    var router: RouterProtocol!
    var model: FiatModel!
    
    func testPresenterNotNil() {
        view = MockView()

    }
}
