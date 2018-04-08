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
    let wind : WindInfo
    
    struct WindInfo : Codable {
        let speed : Float?
    }
    
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
    private let openWeatherMapAPIKey = "53b99e377fd99bcc794ffa8a719713b1"
    
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
        for i in favoriteList {
            if city == i {
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
    func getNameAndTempArray(list: [Weather]) ->[String:[String]] {
        var dict : [String:[String]] = [:]
        for weather in list {
            dict[weather.name!] = getWeatherInfoArray(weather: weather)
        }
        return dict
    }
    
    func getFavoriteCity() {
        let random : Int = Int(arc4random_uniform(UInt32(favoriteList.count)))
        if favoriteList.count > 0 {
            sendWeatherRequest(city: favoriteList[random])
        } else {
            sendWeatherRequest(city: "gothenburg")
        }
    }
    
    func addCityToFavoriteList(city: String) {
        favoriteList.append(city)
        userDefaults.set(favoriteList, forKey: favListKey)
    }
    
    func removeCityFromFavoriteList(city: String) {
        for i in 0..<favoriteList.count {
            if city == favoriteList[i] {
                favoriteList.remove(at: i)
                break;
            }
        }
        userDefaults.set(favoriteList, forKey: favListKey)
    }
    
    func getFavoriteList() -> [String] {
        return favoriteList
    }
    
    func heartImagePath(city: String) -> String {
        if isFavoriteCity(city: city) {
            return "heartFilled"
        } else {
            return "heart"
        }
    }
    
    func getBackgroundImage() -> String {
        let array = ["town","town2","town3","town4"]
        let i : Int = Int(arc4random_uniform(4))
        return array[i]
    }

    private func sendWeatherRequest(city: String) {
        if let safeString = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(safeString)&APPID=\(openWeatherMapAPIKey)") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler:
            { (data : Data?, response : URLResponse?, error : Error?) in
                if let actualError = error {
                    print(actualError)
                } else {
                    if let actualData = data {
                        let decoder = JSONDecoder()
                        do {
                            let weather = try decoder.decode(Weather.self, from: actualData)
                            self.delegate.didGetWeather(weather: weather)
                        } catch let e {
                            print("Error parsing json: \(e)")
                        }
                    } else {
                        print("Data was nil")
                    }
                }
            })
            task.resume()
        }else {
            print("Bad url string.")
        }
    }

    
}
