//
//  ActualGradientButton.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 05.09.2022.
//

import UIKit

class ActualGradientButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.systemGray5.cgColor, UIColor.systemGray6.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = l.bounds.width / 2
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
