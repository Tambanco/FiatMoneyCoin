//
//  Constants.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 03.07.2022.
//

import Foundation
import UIKit

enum colorCode: String {
    case one = "187498"
    case two = "36AE7C"
    case three = "e96443"
    case four = "904e95"
    case five = "#757F9A"
    case six = "#D7DDE8"
}

struct Constants {
    static let backgroundColorView: UIColor = UIColor.systemCyan
    static let backgroundColorCell: CGColor = UIColor.systemCyan.cgColor
    static let backgroundColorButton: UIColor = .systemCyan
    
    static let cornerRadiusForView: Double = 20.0
    
    // MARK: - Colors for gradient
    static let colorOne = UIColor(hexString: colorCode.four.rawValue).cgColor
    static let colorTwo = UIColor(hexString: colorCode.three.rawValue).cgColor
}
