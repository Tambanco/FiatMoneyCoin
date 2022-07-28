//
//  FiatTotalView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 22.07.2022.
//

import UIKit

class FiatTotalView: UIView {
    lazy var fiatCardView: UIView! = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = Constants.backgroundColorView
        return view
    }()
    
    lazy var fiatHeader: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.text = "Фиатные деньги"
        return label
    }()
    
    lazy var totalLabel: UILabel! = {
        let label = UILabel()
        label.text = "Сумма:"
        label.textColor = .white
        return label
    }()
    
    lazy var earnLabel: UILabel! = {
        let label = UILabel()
        label.text = "Заработок:"
        label.textColor = .white
        return label
    }()
    
    lazy var totalValue: UILabel! = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        return label
    }()
    
    lazy var eranValue: UILabel! = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(fiatCardView)
        fiatCardView.addSubview(fiatHeader)
        fiatCardView.addSubview(totalLabel)
        fiatCardView.addSubview(totalValue)
        fiatCardView.addSubview(earnLabel)
        fiatCardView.addSubview(eranValue)
        
        fiatCardView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        fiatHeader.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(fiatHeader.snp.bottom).inset(-20)
        }
        
        totalValue.snp.makeConstraints { make in
            make.leading.equalTo(totalLabel.snp.trailing).inset(-10)
            make.centerY.equalTo(totalLabel)
        }
        
        earnLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(totalLabel.snp.bottom).inset(-20)
        }
        
        eranValue.snp.makeConstraints { make in
            make.leading.equalTo(earnLabel.snp.trailing).inset(-10)
            make.centerY.equalTo(earnLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
