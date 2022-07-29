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
    
    required init() {
        
    }
    
    convenience init(view: UIView, topColor: CGColor, bottomColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = view.layer.cornerRadius
        view.layer.insertSublayer(gradientLayer, at:0)
    
        self.init()
    }
    
    private func setGradientForView(view: UIView) {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = view.layer.cornerRadius
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}
