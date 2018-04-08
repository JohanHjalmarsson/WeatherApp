//
//  WeatherHelper.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-04-08.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class WeatherHelper {
    
    func getCelsius(weather: Weather) -> Int {
        if let temp = weather.main.temp {
            let celsius : Int = Int(temp-274.15)
            return celsius
        } else {
            return 0
        }
    }
    
    func getScaleForTemp(list: [Weather]) -> [Int]{
        var array : [Double] = []
        for weather in list {
            var temp = Double(getCelsius(weather: weather))
            if temp == 0 {
                temp = 1
            }
            array.append(temp)
        }
        if let max = array.max() {
            for i in 0..<array.count {
                let temp = array[i]
                array[i] = temp/max*100
            }
        }
        var intArray : [Int] = []
        for value in array {
            intArray.append(Int(value))
        }
        return intArray
    }
}
