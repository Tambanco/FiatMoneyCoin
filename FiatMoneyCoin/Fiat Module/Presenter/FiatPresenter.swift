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
import CoreData

// MARK: Output protocol
protocol FiatViewProtocol: AnyObject {
    func updateFiatView()
    func updateTotalView(totalValue: String?)
}

// MARK: Input protocol
protocol FiatPresenterProtocol: AnyObject {
    var fiatCurrenciesFromCoreData: [NSManagedObject] { get set }
    
    var baseCurrency: String { get set }
    var convertedCurrency: String? { get set }
    var fiatCalculator: FiatCalculatorProtocol! { get set }
    var totalValue: String? { get set }
    
    func showCurrencyView()
    func fetchCurrency()
    func removeCurrency(rowIndex: Int)
    func currencyConverter(amount: String?, symbol: String?)
    
    init(router: RouterProtocol, view: FiatViewProtocol, networkService: NetworkServiceProtocol)
}

class FiatPresenter: FiatPresenterProtocol {
    var fiatCurrenciesFromCoreData: [NSManagedObject] = []
    
    var totalValue: String?
    var fiatCalculator: FiatCalculatorProtocol! = FiatCalculator()
    var baseCurrency: String = "RUB"
    var convertedCurrency: String?
    
    weak var view: FiatViewProtocol?
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    
    func fetchCurrency() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Currency")
        
        do {
            fiatCurrenciesFromCoreData = try managedContext.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.view?.updateFiatView()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
//        let amountCurrency = router?.newCurrency?.newValue
//        let amountCurrencySymbol = router?.newCurrency?.newSymbol
//        currencyConverter(amount: amountCurrency, symbol: amountCurrencySymbol)
//        self.view?.updateTotalView(totalValue: totalValue)
    }
    
    func removeCurrency(rowIndex: Int) {
        fiatCurrenciesFromCoreData.remove(at: rowIndex)
        DispatchQueue.main.async {
            self.view?.updateTotalView(totalValue: self.fiatCalculator.calculateTotalValue(values: self.fiatCurrenciesFromCoreData))
            self.view?.updateFiatView()
        }
    }
    
    func currencyConverter(amount: String?, symbol: String?) {
        guard symbol != nil else { return }
        let symbolToConvert = symbol!
        let currencyCode = String(symbolToConvert.prefix(3))
        networkService?.convertTwoCurrensies(from: currencyCode, to: baseCurrency, amount: amount ?? "", completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let convertedValue):
                    self.convertedCurrency = convertedValue
                    let amountCurrency = self.router?.newCurrency?.newValue
                    let amountCurrencySymbol = self.router?.newCurrency?.newSymbol
                    
                    let newValue = FiatModel(amountCurrency: amountCurrency ?? "0",
                                             amountCurrencySymbol: amountCurrencySymbol ?? "",
                                             amountBaseCurrency: self.baseCurrency,
                                             convertedValue: "\(self.convertedCurrency!)")
//                    self.fiatCurrencyList.append(newValue)
                    self.view?.updateFiatView()
//                    self.view?.updateTotalView(totalValue: self.fiatCalculator.calculateTotalValue(values: self.fiatCurrencyList))
                case .failure(let error):
                    print(error)
                }
            }
        })
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
