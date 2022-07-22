//
//  CurrencyView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 22.07.2022.
//

import UIKit

class CurrencyView: UIView {
    
    lazy var header: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 38)
        label.text = "Add new currency"
        return label
    }()
    
    lazy var newValueTextField: UITextField! = {
        let textField = UITextField()
        textField.placeholder = "Enter new value"
        textField.layer.backgroundColor = UIColor.brown.cgColor
        return textField
    }()
    
    lazy var currencyPickerView: UIPickerView! = {
        let pickerView = UIPickerView()
        pickerView.layer.backgroundColor = UIColor.blue.cgColor
        return pickerView
    }()
    
    lazy var cancelButton: UIButton! = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    lazy var addCurrencyButton: UIButton! = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.setTitle("Add", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .brown
        addSubview(header)
        addSubview(newValueTextField)
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
        
        currencyPickerView.snp.makeConstraints { make in
            make.top.equalTo(newValueTextField.snp.bottom).inset(-20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(50)
            make.top.equalTo(currencyPickerView.snp.bottom).inset(20)
            make.width.equalTo(100)
        }
        
        addCurrencyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(currencyPickerView.snp.bottom).inset(20)
            make.width.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
