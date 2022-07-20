//
//  FiatCell.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 20.07.2022.
//

import UIKit
import SnapKit

class FiatCell: UITableViewCell {
    static let reuseId = "FiatCell"
    
    let symbolImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FiatCell.reuseId)
        
        addSubview(symbolImageView)
        
        symbolImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
            make.width.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
