//
//  City.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class City {
    let name: String
    let temp: String
    let windSpeed: String
    
    init(name: String, temp: String, windSpeed: String) {
        self.name = name
        self.temp = temp
        self.windSpeed = windSpeed
    }
}
