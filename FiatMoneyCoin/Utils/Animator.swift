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
    
    convenience init(forButton: UIButton, firstDuration: TimeInterval, secondDuration: TimeInterval) {
        UIView.animate(withDuration: firstDuration,
            animations: {
            forButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
            },
            completion: { _ in
            UIView.animate(withDuration: secondDuration) {
                forButton.transform = CGAffineTransform.identity
                }
            })
        self.init()
    }
    
    func animateButton(button: UIButton) {
        
    }
}
