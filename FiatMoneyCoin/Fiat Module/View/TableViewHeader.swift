//
//  TableViewHeader.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 02.09.2022.
//

import Foundation
import UIKit

class TableViewHeader: UIView {
    private lazy var cardView = createCardView()
    private lazy var headerLabel = createHeaderLabel()
    private lazy var totalLabel = createTotalLabel()
    lazy var totalValue = "empty"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cardView)
        cardView.addSubview(headerLabel)
        cardView.addSubview(totalLabel)
        
        cardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }

        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
        }

        totalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(headerLabel.snp.bottom).inset(-20)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension TableViewHeader {
    private func createCardView() -> UIView{
        let cardView = UIView()
        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = true
        cardView.backgroundColor = .systemCyan
        return cardView
    }
    
    private func createHeaderLabel() -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.text = "Фиатные деньги"
        return label
    }
    
    private func createTotalLabel() -> UILabel{
        let label = UILabel()
        label.textColor = .white
        label.text = "Сумма: \(totalValue)"
        return label
    }
}
