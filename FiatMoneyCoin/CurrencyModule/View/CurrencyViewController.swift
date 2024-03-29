//
//  CurrencyViewController.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 05.07.2022.
//
//  Template generated by Tambanco
//

import UIKit
import CoreData

class CurrencyViewController: UIViewController {
    var presenter: CurrencyPresenterProtocol!
    var currencyView: CurrencyView!
    
    private var newValue: String?
    private var newSymbol: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCurrencyView()
        setupPickerView()
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = Constants.backgroundColorButton
    }
    
    func  setupCurrencyView() {
        currencyView = CurrencyView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(currencyView)
        view.backgroundColor = .white
        currencyView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height * 0.5)
        }
        
        self.currencyView.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        self.currencyView.addCurrencyButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func setupPickerView() {
        self.currencyView.currencyPickerView.delegate = self
        self.currencyView.currencyPickerView.dataSource = self
        self.currencyView.newValueTextField.addTarget(self, action: #selector(textFieldEndEditing), for: .editingChanged)
    }
    
    @objc func textFieldEndEditing() {
        newValue = currencyView.newValueTextField.text
    }
    
    @objc func addAction() {
        presenter.newValueToSave = newValue
        presenter.newSymbolToSave = newSymbol
        presenter.saveToCoreData()
    }
    
    @objc func cancelAction() {
        presenter.cancelAdding()
    }
}

// MARK: - PickerView
extension CurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.symbols?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.symbols?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newSymbol = presenter.symbols?[row]
    }
}

// MARK: - Binding
extension CurrencyViewController: CurrencyViewProtocol {
    func success() {
        currencyView.currencyPickerView.reloadAllComponents()
        newSymbol = presenter.symbols?[currencyView.currencyPickerView.selectedRow(inComponent: 0)]
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
