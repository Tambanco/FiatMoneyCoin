//
//  HeaderView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 07.09.2022.
//

import UIKit

class HeaderView: UIView {
    
    lazy var headerCardView = createCardView()
    private lazy var headerLabel = createHeaderLabel()
    lazy var totalLabel = createTotalLabel()
    private lazy var gradientLayer = createGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerCardView)
        addSubview(headerLabel)
        addSubview(totalLabel)
        
        headerCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(20)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(headerLabel.snp.bottom).inset(-20)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension HeaderView {
    private func createCardView() -> UIView {
        let cardView = UIView()
        cardView.layer.cornerRadius = 20
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
        label.text = "Сумма: "
        return label
    }
    
    private func createGradientLayer() -> CAGradientLayer{
        let colorOne = UIColor(hexString: "e96443")
        let colorTwo = UIColor(hexString: "904e95")
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 20
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}
