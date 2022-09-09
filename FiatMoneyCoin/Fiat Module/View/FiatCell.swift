//
//  FiatCell.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 20.07.2022.
//

import UIKit
import SnapKit

extension UITableViewCell {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}

class FiatCell: UITableViewCell {
    private var dropShadow: DropShadowProtocol!
    
    private lazy var cellView = createCellView()
    lazy var currencyImage = createCurrencyImage()
    lazy var amountCurrency = createAmountCurrency()
    lazy var amountCurrencySymbol = createAmountCurrencySymbol()
    lazy var convertedValue = createConvertedValue()
    lazy var earnPercent = createEarnPercent()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FiatCell.reuseId)
        
        backgroundColor = .clear
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView
        
        addSubview(cellView)
        cellView.addSubview(currencyImage)
        cellView.addSubview(amountCurrency)
        cellView.addSubview(amountCurrencySymbol)
        cellView.addSubview(convertedValue)
        cellView.addSubview(earnPercent)
        
        cellView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        
        currencyImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(40)
        }
        
        amountCurrency.snp.makeConstraints { make in
            make.leading.equalTo(currencyImage.snp.trailing).inset(-15)
            make.top.equalToSuperview().inset(10)
        }
        
        amountCurrencySymbol.snp.makeConstraints { make in
            make.leading.equalTo(amountCurrency.snp.trailing).inset(-10)
            make.centerY.equalTo(amountCurrency)
        }
        
        convertedValue.snp.makeConstraints { make in
            make.leading.equalTo(currencyImage.snp.trailing).inset(-15)
            make.top.equalTo(amountCurrency.snp.bottom).inset(-7)
        }
        
        earnPercent.snp.makeConstraints { make in
            make.centerY.equalTo(convertedValue)
            make.leading.equalTo(convertedValue.snp.trailing).inset(-10)
            make.top.equalTo(amountCurrencySymbol.snp.bottom).inset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension FiatCell {
    private func createCellView() -> UIView{
        let view = UIView()
        //        view.backgroundColor = UIColor(hexString: colorCode.six.rawValue).withAlphaComponent(0.7)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 15
        return view
    }
    
    private func createCurrencyImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }
    
    private func createAmountCurrency() -> UILabel{
        let label = UILabel()
        label.text = "currency"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }
    
    private func createAmountCurrencySymbol() -> UILabel{
        let label = UILabel()
        label.text = "symbol"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }
    
    private func createConvertedValue() -> UILabel{
        let label = UILabel()
        label.text = "converted"
        return label
    }
    
    private func createEarnPercent() -> UILabel{
        let label = UILabel()
        label.text = "earnPercent"
        return label
    }
}
