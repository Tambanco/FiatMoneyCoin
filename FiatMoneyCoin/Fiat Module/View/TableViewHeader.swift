//
//  TableViewHeader.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 02.09.2022.
//

import Foundation
import UIKit

class TableViewHeader: UIView {
    
    lazy var totalValue = 0
    private var dropShadow: DropShadowProtocol!
    private var gradientor: GradientProtocol!
    private lazy var pageControl = createPageControl()
//    private lazy var headerLabel = createHeaderLabel()
//    private lazy var totalLabel = createTotalLabel()
    private lazy var fiatView = FiatView(frame: CGRect(x: 20, y: 20, width: 300, height: 200))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fiatView.backgroundColor = .systemRed
        
        addSubview(pageControl)
        pageControl.addSubview(fiatView)
//        pageControl.addSubview(headerLabel)
//        pageControl.addSubview(totalLabel)
        
        pageControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
//
//        headerLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(20)
//            make.top.equalToSuperview().inset(10)
//        }
//
//        totalLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(20)
//            make.top.equalTo(headerLabel.snp.bottom).inset(-20)
//        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension TableViewHeader {
    private func createPageControl() -> UIPageControl{
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.layer.cornerRadius = 20
        pageControl.backgroundColor = .systemBlue
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        pageControl.layer.masksToBounds = true
        return pageControl
    }
    
//    private func createHeaderLabel() -> UILabel{
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        label.textColor = .white
//        label.text = "Фиатные деньги"
//        return label
//    }
//    
//    private func createTotalLabel() -> UILabel{
//        let label = UILabel()
//        label.textColor = .white
//        label.text = "Сумма: \(totalValue)"
//        return label
//    }
}
