//
//  GradientView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 05.09.2022.
//

import UIKit

class GradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let colorOne = UIColor(hexString: "e96443")
        let colorTwo = UIColor(hexString: "904e95")
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [colorOne.cgColor, colorTwo.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0)
        l.endPoint = CGPoint(x: 1, y: 1)
        l.cornerRadius = 20
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
