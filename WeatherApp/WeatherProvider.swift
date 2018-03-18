//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by lösen är 0000 on 2018-03-06.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class WeatherProvider {
    let list : [[String: String]] = [["City": "Gothenburg", "Weather": "-4"],
                           ["City": "Barcelona", "Weather": "28"],
                           ["City": "Paris", "Weather": "19"]]
    
    func getList() -> [[String: String]] {
        return self.list;
    }
    
    func getFavCityName() -> String {
        if let name = self.list[0]["City"] {
           return name
        } else {
            return "no data"
        }
    }
    
    func getFavCityWeather() -> String {
        if let weather = self.list[0]["Weather"] {
            return weather
        } else {
            return "no data"
        }
    }
}
