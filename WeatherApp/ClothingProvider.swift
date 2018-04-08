//
//  ClothingProvider.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-25.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class ClothingProvider {
    
    func getAppClothes(weather: Weather) -> [UIImage] {
        var array : [UIImage] = []
        
        var celsius : Int
            if let temp = weather.main.temp {
                celsius = Int(temp-274.15)
            } else {
                celsius = 0
                print("no temperature")
            }
        
        if weather.wind.speed! > 6 || celsius <= 10 || weather.weather[0].main == "Snow" {
            let image = UIImage(named: "coldC")
            array.append(image!)
            print("coldC added")
        }
        if weather.weather[0].main == "Rain" || weather.weather[0].main == "Drizzle" {
            let image = UIImage(named: "rainC")
            array.append(image!)
            print("rainC added")
        }
        if celsius > 20 {
            let image = UIImage(named: "warmC")
            array.append(image!)
            print("warmC added")
        }
        if celsius < 20 && celsius > 10 {
            let image = UIImage(named: "averageC")
            array.append(image!)
            print("averageC added")
        }
        if celsius < 3 || (celsius < 10 && weather.wind.speed! > 10) {
            let image = UIImage(named: "winterC")
            array.append(image!)
        }
        return array
    }
}
