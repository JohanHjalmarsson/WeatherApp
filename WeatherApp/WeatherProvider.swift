//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by lösen är 0000 on 2018-03-06.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

protocol WeatherProviderDelegate {
    func didGetWeather(weather: Weather)
    func didNotGetWeather(error: NSError)
}

struct Weather : Codable {
    let name : String?
    let id : Int?
    let main : OwMain
    let weather : [OwWeather]
    
    struct OwMain : Codable {
        let temp : Float?
        let humidity : Float?
    }
    
    struct OwWeather : Codable {
        let main : String?
        let description : String?
        let icon : String?
    }
    
}

class WeatherProvider {
    private var delegate : WeatherProviderDelegate
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "f1fe503eba89cad6f7057dcadc66c81c"
    
    private let userDefaults : UserDefaults
    private let favCityKey : String = "favCity"
    private var favoriteList : [String]
    private let favListKey : String = "favList"
    
    init(delegate: WeatherProviderDelegate) {
        self.delegate = delegate
        self.userDefaults = UserDefaults.standard
        if let list = userDefaults.array(forKey: favListKey) {
            favoriteList = list as! [String]
        } else {
            favoriteList = []
        }
    }
    
    func setFavoriteCity(city: String) {
        userDefaults.set(city, forKey: favCityKey)
    }
    
    func isFavoriteCity(city: String) -> Bool {
        var b : Bool = false
        for i in 0...favoriteList.count {
            if city == favoriteList[i] {
                b = true
                break
            }
        }
        return b
    }
    
    func getWeatherByCity(city: String) {
        sendWeatherRequest(city: city)
    }
    
    func getWeatherInfoArray(weather: Weather) -> [String] {
        var array : [String] = []
        // Name [0]
        if let cityName = weather.name {
            array.append(cityName)
        } else {
            array.append("No Data")
        }
        // Temp [1]
        if let temp = weather.main.temp {
            let celsius : Int = Int(temp-274.15)
            let tempString = "\(celsius.description) °"
            array.append(tempString)
        }
        else {
            array.append("No Data")
        }
        // Description [2]
        if let description = weather.weather[0].description {
            array.append(description)
        }
        else {
            array.append("No Data")
        }
        // Icon [3]
        if let icon = weather.weather[0].icon {
            array.append(icon)
        }
        else {
            array.append("No Data")
        }
        return array
    }
    
    func getFavoriteCity() {
        if let city = userDefaults.string(forKey: favCityKey) {
            sendWeatherRequest(city: city)
        } else {
            sendWeatherRequest(city: "london")
        }
    }
    
    func addCityToFavoriteList(city: String) {
        favoriteList.append(city)
        userDefaults.set(favoriteList, forKey: favListKey)
    }
    
    func getFavoriteList() -> [String] {
        return favoriteList
    }

    
    private func sendWeatherRequest(city: String) {
        //if let safeString = searchField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=f1fe503eba89cad6f7057dcadc66c81c") {
            //
            // behöver ingen if let, för den funkar alltid om den får en url
            let request = URLRequest(url: url)
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
                            let weather = try decoder.decode(Weather.self, from: actualData)
                            print(weather)
                            
                            self.delegate.didGetWeather(weather: weather)
//                            DispatchQueue.main.async {
//                              print("Name "+weather.name!)
//                                print("id "+String(weather.id!))
//                                print("Temp "+String(weather.main.temp!))
//                                print("Description "+weather.weather[0].description!)
//                            }
                            
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
            
        }else {
            print("Bad url string.")
        }
    }
    
    
    
}
