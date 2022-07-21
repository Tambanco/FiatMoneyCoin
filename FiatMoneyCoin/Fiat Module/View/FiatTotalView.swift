//
//  FiatTotalView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 22.07.2022.
//

import UIKit

class FiatTotalView: UIView {
    lazy var fiatTotalView: UIView! = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var fiatHeader: UILabel! = {
        let label = UILabel()
        label.text = "Fiat money"
        label.font = UIFont(name: "system", size: 44)
        return label
    }()
    
    lazy var totalLabel: UILabel! = {
        let label = UILabel()
        label.text = "Total"
        return label
    }()
    
    lazy var earnLabel: UILabel! = {
        let label = UILabel()
        label.text = "Earn"
        return label
    }()
    
    lazy var totalValue: UILabel! = {
        let label = UILabel()
        label.text = "totalValue"
        return label
    }()
    
    lazy var eranValue: UILabel! = {
        let label = UILabel()
        label.text = "eranValue"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(fiatTotalView)
        fiatTotalView.addSubview(fiatHeader)
        fiatTotalView.addSubview(totalLabel)
        fiatTotalView.addSubview(earnLabel)
        fiatTotalView.addSubview(totalValue)
        fiatTotalView.addSubview(eranValue)
        
        fiatTotalView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(300)
            
            fiatHeader.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(10)
                make.trailing.equalToSuperview().inset(10)
                make.top.equalToSuperview().inset(10)
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
