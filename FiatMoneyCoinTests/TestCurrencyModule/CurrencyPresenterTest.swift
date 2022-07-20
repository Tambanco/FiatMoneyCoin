//
//  CurrencyPresenterTest.swift
//  FiatMoneyCoinTests
//
//  Created by tambanco 🥳 on 19.07.2022.
//

import XCTest
@testable import FiatMoneyCoin

class MockView: CurrencyViewProtocol {
    func success() {
    }
    
    func failure(error: Error) {
    }
}

class MockNetworkService: NetworkServiceProtocol {
    func convertTwoCurrensies(from: String, to: String, amount: Double, completion: @escaping (Result<String?, Error>) -> Void) {
        
    }
    

    
    var symbols: [String]!
    
    init() {}
    
    convenience init(symbols: [String]) {
        self.init()
        self.symbols = symbols
    }
    
    func getCurrencyList(completion: @escaping (Result<[String]?, Error>) -> Void) {
        if let symbols = symbols {
            completion(.success(symbols))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

class CurrencyPresenterTest: XCTestCase {
    var view: CurrencyViewProtocol!
    var presenter: CurrencyPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var symbols = [String]()
    
    override func setUp() {
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyModuleBuilder()
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDown() {
        view = nil
        presenter = nil
        networkService = nil
    }
    
    func testGetSuccessSymbols() {
        let symbols = ["foo", "bar", "baz"]
        
        view = MockView()
        networkService = MockNetworkService(symbols: symbols)
        presenter = CurrencyPresenter(router: router, view: view, networkService: networkService)
        
        var catchSymbols: [String]?
        
        networkService.getCurrencyList { result in
            switch result {
            case .success(let symbols):
                catchSymbols = symbols
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchSymbols?.count, 0)
    }
    
    func testGetFailureSymbols() {
        
        view = MockView()
        networkService = MockNetworkService()
        presenter = CurrencyPresenter(router: router, view: view, networkService: networkService)
        
        var catchError: Error?
        
        networkService.getCurrencyList { result in
            switch result {
            case .success(let symbols):
                print(symbols ?? "")
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)
    }
}
