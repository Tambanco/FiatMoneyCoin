//
//  Animator.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 31.07.2022.
//

import Foundation
import UIKit

protocol AnimatorProtocol {
    func animateButton(button: UIButton)
    init()
}

class Animator: AnimatorProtocol {
    
    required init() {}
    
    convenience init(forButton: UIButton) {
        forButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.init()
    }
    
    func animateButton(button: UIButton) {
        
    }
}
