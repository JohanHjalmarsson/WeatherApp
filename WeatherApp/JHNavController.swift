//
//  JHNavController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class JHNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()

    }

}
