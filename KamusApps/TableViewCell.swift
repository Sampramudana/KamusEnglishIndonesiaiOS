//
//  TableViewCell.swift
//  KamusApps
//
//  Created by Becak Holic on 11/9/17.
//  Copyright © 2017 Sam Pramudana. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var indonesianDesc: UILabel!
    @IBOutlet weak var englishDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
