//
//  FiatTotalView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 22.07.2022.
//

import UIKit

class FiatView: UIView {
    lazy var fiatCardView: UIView! = {
        let view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var fiatHeader: UILabel! = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(fiatCardView)
        fiatCardView.addSubview(fiatHeader)
        fiatCardView.addSubview(totalLabel)
        
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
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
