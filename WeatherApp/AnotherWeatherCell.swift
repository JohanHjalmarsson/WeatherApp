//
//  AnotherWeatherCell.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-21.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class AnotherWeatherCell: UITableViewCell {
    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var labelRight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
