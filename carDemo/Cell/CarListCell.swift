//
//  CarListCell.swift
//  carDemo
//
//  Created by 丁健 on 2018/9/20.
//  Copyright © 2018年 丁健. All rights reserved.
//

import UIKit

class CarListCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
