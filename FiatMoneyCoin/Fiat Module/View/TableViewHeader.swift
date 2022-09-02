//
//  TableViewHeader.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 02.09.2022.
//

import Foundation
import UIKit

class TableViewHeader: UIView {
    private lazy var pageControl = createPageControl()
    private lazy var headerLabel = createHeaderLabel()
    private lazy var totalLabel = createTotalLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(pageControl)
        pageControl.addSubview(headerLabel)
        pageControl.addSubview(totalLabel)
        
        pageControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(headerLabel.snp.bottom).inset(-20)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension TableViewHeader {
    private func createPageControl() -> UIPageControl{
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .systemBlue
        pageControl.numberOfPages = 2
        return pageControl
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
        label.text = "Сумма:"
        return label
    }
}

//extension TableViewHeader: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        <#code#>
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        <#code#>
//    }
//}
