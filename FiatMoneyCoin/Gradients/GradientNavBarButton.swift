//
//  GradientNavBarButton.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 06.09.2022.
//

import UIKit

class GradientNavBarButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let colorOne = UIColor.white
        let colorTwo = UIColor.white
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [colorOne.cgColor, colorTwo.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0)
        l.endPoint = CGPoint(x: 1, y: 1)
        l.cornerRadius = 10
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
