//
//  WeatherLocations.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-23.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

protocol WeatherLocationsDelegate {
    func didGetWeatherLocations(list: [WeatherLocationItem])
    func didNotGetWeatherLocations(error: NSError)
}

struct WeatherLocationItem : Codable {
    let name : String?
}

class WeatherLocations {
    
    private var delegate : WeatherLocationsDelegate
    
    init(delegate: WeatherLocationsDelegate) {
        self.delegate = delegate
    }
    
    func getWeatherLocations() {
        
    }
    
    func parseJson() {
        let url = Bundle.main.url(forResource: "city.list", withExtension: "json")
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request, completionHandler:
        { (data : Data?, response : URLResponse?, error : Error?) in
            if let actualError = error {
                print(actualError)
            } else {
                if let actualData = data {
                    print(actualData)
                    let decoder = JSONDecoder()
                    print(decoder)
                    do {
                        let weatherLocationList = try decoder.decode([WeatherLocationItem].self, from: actualData)
                        self.delegate.didGetWeatherLocations(list: weatherLocationList)
                    } catch let e {
                        print("Error parsing json: \(e)")
                    }
                } else {
                    print("Data was nil")
                }
            }
        })
        task.resume()
        print("Sending request!")
    }
    
    
}
