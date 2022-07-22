//
//  CurrencyView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 22.07.2022.
//

import UIKit

class CurrencyView: UIView {
    
    lazy var addCurrencyHeader: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 44)
        label.textColor = .white
        label.text = "Add new currency"
        return label
    }()
    
    lazy var newValueTextField: UITextField! = {
        let textField = UITextField()
        textField.placeholder = "Enter new value"
        return textField
    }()
    
    lazy var currencyPickerView: UIPickerView! = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    lazy var cancelButton: UIButton! = {
        let button = UIButton()
        return button
    }()
    
    lazy var addCurrencyButton: UIButton! = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addCurrencyHeader)
        addSubview(newValueTextField)
        addSubview(currencyPickerView)
        addSubview(cancelButton)
        addSubview(addCurrencyButton)
        
        addCurrencyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.leading.equalToSuperview().inset(20)
        }
        
        newValueTextField.snp.makeConstraints { make in
            make.top.equalTo(addCurrencyButton.snp.bottom).inset(-20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        currencyPickerView.snp.makeConstraints { make in
            make.top.equalTo(newValueTextField.snp.bottom).inset(-20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(currencyPickerView.snp.bottom).inset(20)
            make.width.equalTo(50)
        }
        
        addCurrencyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(currencyPickerView.snp.bottom).inset(20)
            make.width.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
