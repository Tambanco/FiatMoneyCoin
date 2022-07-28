//
//  Gradientor.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.07.2022.
//

import Foundation
import UIKit

protocol GradientProtocol: AnyObject {
    func setGradientForView(view: UIView)
}

class Gradientor: GradientProtocol {
    func setGradientForView(view: UIView) {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
                        
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = view.bounds
                    
            view.layer.insertSublayer(gradientLayer, at:0)
    }
}
