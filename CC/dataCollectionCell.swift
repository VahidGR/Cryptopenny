//
//  dataCollectionCell.swift
//  CC
//
//  Created by Vahid Ghanbarpour on 12/6/17.
//  Copyright © 2017 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class dataCollectionCell: UICollectionViewCell {
    
    var rankNsymbol: UILabel!
    var recentChange: UILabel!
    var recentChangeImage: UIImageView!
    var name: UILabel!
    var usdPrice: UILabel!
    var cellImage: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        rankNsymbol.text = nil
        name.text = nil
        usdPrice.text = nil
        recentChange.text = nil
        recentChangeImage.image = nil
        cellImage.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rankNsymbol = UILabel(frame: CGRect(x: 10, y: 0, width: frame.width - 145, height: 40))
        rankNsymbol.textColor = UIColor(hex: "27253A")
        rankNsymbol.textAlignment = .left
        contentView.addSubview(rankNsymbol)
        
        recentChange = UILabel(frame: CGRect(x: frame.width - 80, y: 0, width: 75, height: 40))
        recentChange.textAlignment = .left
        contentView.addSubview(recentChange)
        
        recentChangeImage = UIImageView(frame: CGRect(x: frame.width - 110, y: 8, width: 20, height: 20))
        recentChangeImage.contentMode = .scaleAspectFit
        contentView.addSubview(recentChangeImage)
        
        cellImage = UIImageView(frame: CGRect(x: 10, y: 50, width: 20, height: 20))
        cellImage.contentMode = .scaleAspectFit
        contentView.addSubview(cellImage)

        name = UILabel(frame: CGRect(x: 40, y: 40, width: frame.width - 100, height: 40))
        name.textColor = UIColor(hex: "27253A")
        name.textAlignment = .left
        contentView.addSubview(name)
        
        usdPrice = UILabel(frame: CGRect(x: frame.width - 110, y: 40, width: 110, height: 40))
        usdPrice.textAlignment = .left
        contentView.addSubview(usdPrice)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
