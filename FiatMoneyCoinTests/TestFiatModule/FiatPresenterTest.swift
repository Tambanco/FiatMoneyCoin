//
//  FiatPresenterTest.swift
//  FiatMoneyCoinTests
//
//  Created by tambanco 🥳 on 19.07.2022.
//

import XCTest
@testable import FiatMoneyCoin

class MockView: FiatViewProtocol {
    func updateFiatView() {
        <#code#>
    }
}

class FiatPresenterTest: XCTestCase {
    var view: MockView!
    var presenter: FiatPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var currencyList = [String]()
    
    override func tearDown() {
        view = nil
        presenter = nil
        networkService = nil
    }
    
    
    
}
