//
//  CurrencyViewController.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 05.07.2022.
//
//  Template generated by Tambanco
//

import UIKit

class CurrencyViewController: UIViewController {
    var presenter: CurrencyPresenterProtocol!
    var currencyView: CurrencyView!
    
    private var newValue: String?
    private var newSymbol: String?
    
//    @IBOutlet weak var addCurrencyTextField: UITextField!
//    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCurrencyView()
        setupPickerView()
    }
    
    func  setupCurrencyView() {
        currencyView = CurrencyView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        currencyView.layer.backgroundColor = UIColor.green.cgColor
        self.view.addSubview(currencyView)
        
        currencyView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
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
        currencyView.currencyPickerView.delegate = self
        currencyView.currencyPickerView.dataSource = self
        currencyView.newValueTextField.addTarget(self, action: #selector(textFieldEndEditing), for: .editingChanged)
    }
    
    @objc func textFieldEndEditing() {
        newValue = currencyView.newValueTextField.text
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        presenter.cancel()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        guard let newSymbol = newSymbol else { return }
        presenter.newCurrencyValue?.newSymbol = newSymbol
        presenter.newCurrencyValue?.newValue = newValue
        presenter.setNewValue()
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
