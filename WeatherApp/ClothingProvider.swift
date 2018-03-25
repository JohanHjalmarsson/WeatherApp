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
        
        if weather.wind.speed! > 6 || celsius < 10 || weather.weather[0].main == "Snow" {
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
    
    
//    func getMoodOfBaby(weather: Weather) -> String {
//
//
//        var celsius : Int
//        if let temp = weather.main.temp {
//            celsius = Int(temp-274.15)
//        } else {
//            celsius = 0
//            print("no temperature")
//        }
//
//        let lullWind  = weather.wind.speed! <= 1
//        let averageWind = weather.wind.speed! > 2 && weather.wind.speed! < 5
//        let hardWind = weather.wind.speed! >= 5 && weather.wind.speed! < 7
//        let stormWind = weather.wind.speed! <= 7
//
//        let sunShine = weather.weather[0].main == "Clear"
//        let rain = weather.weather[0].main == "Rain"
//        let thunderStorm = weather.weather[0].main == "ThunderStorm"
//        let lightRain = weather.weather[0].main == "Drizzle"
//        let snow = weather.weather[0].main == "Snow"
//        let clouds = weather.weather[0].main == "Clouds"
//
//        let coldTemp = celsius < 5
//        let averageTemp = celsius >= 5 && celsius < 15
//        let varmTemp = celsius >= 15 && celsius < 25
//        let veryHot = celsius >= 25
//
//
//        if (lullWind && clouds && !veryHot) ||
//            (lullWind && lightRain && !veryHot && !coldTemp)
//            {
//            return "happyBaby"
//        }
//        return "happy"
//    }

}
