//
//  TableViewCell.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 30.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseID = "FiatCell"

    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var amountCurrency: UILabel!
    @IBOutlet weak var amountCurrencySymbol: UILabel!
    @IBOutlet weak var amountBaseCurrency: UILabel!
    @IBOutlet weak var earnPercent: UILabel!
    @IBOutlet weak var amountForCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
