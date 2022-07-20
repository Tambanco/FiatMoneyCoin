//
//  TableViewCell.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 30.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let reuseID = "FiatCellCell"

    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var amountCurrency: UILabel!
    @IBOutlet weak var amountCurrencySymbol: UILabel!
    @IBOutlet weak var convertedValue: UILabel!
    @IBOutlet weak var earnPercent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.backgroundColor = Constants.backgroundColorCell
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
