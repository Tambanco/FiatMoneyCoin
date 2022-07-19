//
//  RouterTest.swift
//  FiatMoneyCoinTests
//
//  Created by tambanco 🥳 on 19.07.2022.
//

import XCTest
@testable import FiatMoneyCoin

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
}

class RouterTest: XCTestCase {
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AssemblyModuleBuilder()

    override func setUp() {
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }

    override func tearDown() {
        router = nil
    }
    
    func testRouter() {
        router.showCurrencyView()
        let currencyViewController = navigationController.presentedVC
        XCTAssertTrue(currencyViewController is CurrencyViewController)
    }
}
