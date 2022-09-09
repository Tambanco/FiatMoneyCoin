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
        setupSearchBar()
        setupPickerView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCancelButton()
        configureAddButton()
    }
    
    private func configureCancelButton() {
        let colorOne = UIColor(hexString: "e96443")
        let colorTwo = UIColor(hexString: "904e95")
        let l = CAGradientLayer()
        l.frame = currencyView.addCurrencyButton.bounds
        l.colors = [colorOne.cgColor, colorTwo.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0)
        l.endPoint = CGPoint(x: 1, y: 1)
        l.cornerRadius = 20
        currencyView.cancelButton.layer.insertSublayer(l, at: 0)
    }
    
    private func configureAddButton() {
        let colorOne = UIColor(hexString: "e96443")
        let colorTwo = UIColor(hexString: "904e95")
        let l = CAGradientLayer()
        l.frame = currencyView.addCurrencyButton.bounds
        l.colors = [colorOne.cgColor, colorTwo.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0)
        l.endPoint = CGPoint(x: 1, y: 1)
        l.cornerRadius = 20
        currencyView.addCurrencyButton.layer.insertSublayer(l, at: 0)
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = Constants.backgroundColorButton
    }
    
    func setupCurrencyView() {
        currencyView = CurrencyView()
        self.view.addSubview(currencyView)
        view.backgroundColor = .white
        currencyView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(-20)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height * 0.55)
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
    
    private func setupSearchBar() {
        self.currencyView.searchCurrencyTextField.delegate = self
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
        dismiss(animated: true)
    }
}

// MARK: - SearchBar
extension CurrencyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.fetchSearchText(searchText: searchText)
    }
}

// MARK: - PickerView
extension CurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return presenter.symbols?.count ?? 0
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return presenter.symbols?[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        newSymbol = presenter.symbols?[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.filteredData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.filteredData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newSymbol = presenter.filteredData[row]
    }
}

// MARK: - Binding
extension CurrencyViewController: CurrencyViewProtocol {
    func updatePickerView(filteredData: [String]) {
        currencyView.currencyPickerView.reloadAllComponents()
        newSymbol = presenter.filteredData[currencyView.currencyPickerView.selectedRow(inComponent: 0)]
    }
    
    func dismissView() {
        dismiss(animated: true)
    }
    
    func success() {
        currencyView.currencyPickerView.reloadAllComponents()
        newSymbol = presenter.symbols?[currencyView.currencyPickerView.selectedRow(inComponent: 0)]
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
