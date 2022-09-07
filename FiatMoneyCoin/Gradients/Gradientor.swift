//
//  Gradientor.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.07.2022.
//

import Foundation
import UIKit

protocol GradientProtocol: AnyObject {
    init()
}

class Gradientor: GradientProtocol {
    required init() {}
    
    convenience init(forView: UIView, topColor: CGColor, bottomColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = forView.bounds
        gradientLayer.cornerRadius = forView.layer.cornerRadius
        forView.layer.insertSublayer(gradientLayer, at: 0)
        
        self.init()
    }
    
    convenience init(forView: UIView, topColor: CGColor,  middleColor: CGColor, bottomColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, middleColor, bottomColor]
        gradientLayer.locations = [0.01, 0.3, 1]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = forView.bounds
        gradientLayer.cornerRadius = forView.layer.cornerRadius
        forView.layer.insertSublayer(gradientLayer, at: 0)
        
        self.init()
    }
}
