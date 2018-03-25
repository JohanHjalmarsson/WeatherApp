//
//  JHTableViewController.swift
//  WeatherApp
//
//  Created by lösen är 0000 on 2018-03-05.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class JHTableViewController: UITableViewController, WeatherProviderDelegate {
    
    var favList : [String] = []
    var weatherList : [Weather] = []
    var weatherProvider : WeatherProvider!
    var weather : Weather!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherProvider = WeatherProvider(delegate: self)
        favList = weatherProvider.getFavoriteList()
        getWeatherForList()
    }
    
    var shouldUseWeatherList : Bool {
        if weatherList.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func didGetWeather(weather: Weather) {
        DispatchQueue.main.async {
           self.weatherList.append(weather)
            self.weather = weather
           self.tableView.reloadData()
        }
    }
    
    func didNotGetWeather(error: NSError) {
        print(error)
    }
    
    func getWeatherForList() {
        for city in favList {
            weatherProvider.getWeatherByCity(city: city)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldUseWeatherList {
            return weatherList.count
        } else {
            return favList.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherCell = self.tableView.dequeueReusableCell(withIdentifier: "JHCell") as! WeatherCell
        
        if shouldUseWeatherList {
            let array : [String] = weatherProvider.getWeatherInfoArray(weather: weatherList[indexPath.row])
            cell.labelLeft.text = array[0]
            cell.laberlRight.text = array[1]
        } else {
            cell.labelLeft.text = favList[indexPath.row]
            cell.laberlRight.text = "loading..."
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "Detail") {
            let destination = segue.destination as! DetailViewController,
            rowIndex = tableView.indexPathForSelectedRow!.row
            destination.weatherInfo = weatherProvider.getWeatherInfoArray(weather: weatherList[rowIndex])
            destination.useWeather = weather
        }
    }
 
}
