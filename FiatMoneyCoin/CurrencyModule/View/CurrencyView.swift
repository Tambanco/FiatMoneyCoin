//
//  CurrencyView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 22.07.2022.
//

import UIKit

class CurrencyView: UIView {
    private lazy var header = createHeader()
    lazy var newValueTextField = createNewValueTextField()
    private lazy var searchCurrencyTextField = createSearchCurrencyTextField()
    lazy var currencyPickerView = createCurrencyPickerView()
    lazy var cancelButton = createCancelButton()
    lazy var addCurrencyButton = createAddCurrencyButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(header)
        addSubview(newValueTextField)
        addSubview(searchCurrencyTextField)
        addSubview(currencyPickerView)
        addSubview(cancelButton)
        addSubview(addCurrencyButton)
        
        header.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        newValueTextField.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).inset(-20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        searchCurrencyTextField.snp.makeConstraints { make in
            make.top.equalTo(newValueTextField.snp.bottom).inset(-10)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(40)
        }
        
        currencyPickerView.snp.makeConstraints { make in
            make.top.equalTo(searchCurrencyTextField.snp.bottom)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(50)
            make.top.equalTo(currencyPickerView.snp.bottom).inset(0)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
        
        addCurrencyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(currencyPickerView.snp.bottom).inset(0)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension CurrencyView {
    private func createHeader() -> UILabel{
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "Новая валюта"
        return label
    }
    
    private func createNewValueTextField() -> UITextField{
        let textField = UITextField()
        textField.placeholder = "Введите значение"
        textField.keyboardType = .decimalPad
        return textField
    }
    
    private func createSearchCurrencyTextField() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
        searchBar.searchTextField.font = UIFont(name: "MarkPro", size: 15)
        searchBar.searchTextField.backgroundColor = UIColor(hexString: "FFFFFF")
        searchBar.backgroundImage = UIImage()
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        let imageV = textFieldInsideSearchBar?.leftView as! UIImageView
        imageV.image = imageV.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageV.tintColor = UIColor(hexString: "FF6E4E")
        return searchBar
    }
    
    
    private func createCurrencyPickerView() -> UIPickerView{
        let pickerView = UIPickerView()
        return pickerView
    }
    
    private func createCancelButton() -> UIButton{
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config)
        button.setTitle("Отмена", for: .normal)
        return button
    }
    
    private func createAddCurrencyButton() -> UIButton{
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config)
        button.setTitle("Добавить", for: .normal)
        return button
    }
}
