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
    func showEditAlert(alert: UIAlertController)
}

// MARK: Input protocol
protocol FiatPresenterProtocol: AnyObject {
    var fiatCurrenciesFromCoreData: [NSManagedObject] { get set }
    var totalValue: [NSManagedObject] { get set }
    var baseCurrency: String { get }
    var convertedCurrency: String? { get set }
    var fiatCalculator: FiatCalculatorProtocol! { get set }
    var storageService: StorageService? { get set }
    
    func showCurrencyView()
    func fetchCurrency(completion: ((() -> Void)?) -> Void)
    func removeCurrency(rowIndex: Int)
    func editCurrencyValue(rowIndex: Int)
    
    init(router: RouterProtocol, view: FiatViewProtocol, networkService: NetworkServiceProtocol)
}

class FiatPresenter: FiatPresenterProtocol {
    var storageService: StorageService? = StorageService()
    var totalValue: [NSManagedObject] = []
    var fiatCurrenciesFromCoreData: [NSManagedObject] = []
    var fiatCalculator: FiatCalculatorProtocol! = FiatCalculator()
    var baseCurrency: String = "RUB"
    var convertedCurrency: String?
    
    weak var view: FiatViewProtocol?
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    
    func fetchCurrency(completion: ((() -> Void)?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Currency")
        do {
            fiatCurrenciesFromCoreData = try managedContext.fetch(fetchRequest)
            let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
            userInitiatedQueue.async {
                let updatedTotalValue = self.fiatCalculator.calculateTotalValue(values: self.fiatCurrenciesFromCoreData)
                DispatchQueue.main.async {
                    self.view?.updateFiatView()
                    self.view?.updateTotalView(totalValue: updatedTotalValue)
                }
            }
//                let totalFiatValue = self.fiatCalculator.calculateTotalValue(values: self.fiatCurrenciesFromCoreData)
//                self.view?.updateTotalView(totalValue: totalFiatValue)
////                self.view?.updateFiatView()
//            print("fetch completed")
//            completion(self.view?.updateFiatView)
        } catch let error as NSError {
            print("Could not fetch. \(error.localizedDescription)")
        }
    }
    
    func editCurrencyValue(rowIndex: Int) {
        let alert = UIAlertController(title: "Новое значение", message: nil, preferredStyle: .alert)
        alert.addTextField { alertTextField in
            let oldValue = self.fiatCurrenciesFromCoreData[rowIndex].value(forKey: "totalCurrency")
            alertTextField.placeholder = oldValue as? String
        }
        
        let editAction = UIAlertAction(title: "Изменить", style: .default) { action in
            let newTotalValue = alert.textFields?.first?.text
            self.fiatCurrenciesFromCoreData[rowIndex].setValue(newTotalValue, forKey: "totalCurrency")
            self.storageService?.updateTotalValue(update: self.fiatCurrenciesFromCoreData[rowIndex])
            let updatedTotalValue = self.fiatCalculator.calculateTotalValue(values: self.fiatCurrenciesFromCoreData)
            
            self.view?.updateFiatView()
            self.view?.updateTotalView(totalValue: updatedTotalValue)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(editAction)
        alert.addAction(cancelAction)

        self.view?.showEditAlert(alert: alert)
        self.view?.updateFiatView()
    }
    
    func removeCurrency(rowIndex: Int) {
        storageService?.removeCurrency(object: fiatCurrenciesFromCoreData[rowIndex])
        fiatCurrenciesFromCoreData.remove(at: rowIndex)
        DispatchQueue.main.async {
            let totalFiatValue = self.fiatCalculator.calculateTotalValue(values: self.fiatCurrenciesFromCoreData)
            self.view?.updateTotalView(totalValue: totalFiatValue)
            self.view?.updateFiatView()
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
