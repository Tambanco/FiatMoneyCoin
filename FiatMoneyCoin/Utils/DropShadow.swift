//
//  DropShadow.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 24.07.2022.
//

import Foundation
import UIKit

protocol DropShadowProtocol: AnyObject {
    init()
}

class DropShadow: DropShadowProtocol {
    
    required init() {
        print("DropShadow initialized")
    }
    
    convenience init(onView: UIView) {
        onView.layer.shadowColor = UIColor.black.cgColor
        onView.layer.shadowOpacity = 0.5
        onView.layer.shadowOffset = .zero
        onView.layer.shadowRadius = 10
        print("convenience #1 worked")
        self.init()
    }
    
    convenience init(onView: UIView, color: CGColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        onView.layer.shadowColor = color
        onView.layer.shadowOpacity = opacity
        onView.layer.shadowOffset = offset
        onView.layer.shadowRadius = radius
        print("convenience #2 worked")
        self.init()
    }
    
    
    deinit {
        print("DropShadow deinited")
    }
}
