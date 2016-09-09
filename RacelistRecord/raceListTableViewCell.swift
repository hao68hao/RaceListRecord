//
//  raceListTableViewCell.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/15.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class raceListTableViewCell: UITableViewCell {

    @IBOutlet weak var raceImage: UIImageView!
    @IBOutlet weak var raceName: UILabel!
    @IBOutlet weak var raceDate: UILabel!
    @IBOutlet weak var raceResult: UILabel!
    @IBOutlet weak var raceAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
