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
    var colorIndex : Int = 0
    var colorIndexDirection : Bool = true
    
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
            self.colorIndex = 0
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
        cell.backgroundColor = getCellColorTest(row: indexPath.row)
        cell.labelLeft.textColor = UIColor.white
        cell.laberlRight.textColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0;
    }
    
    func getCellColorTest(row: Int) -> UIColor {
        let color1 = UIColor(red: 72/255, green: 65/255, blue: 96/255, alpha: 1)
        let color2 = UIColor(red: 73/255, green: 68/255, blue: 93/255, alpha: 1)
        let color3 = UIColor(red: 58/255, green: 54/255, blue: 72/255, alpha: 1)
        let color4 = UIColor(red: 47/255, green: 44/255, blue: 55/255, alpha: 1)
        let color5 = UIColor(red: 40/255, green: 39/255, blue: 45/255, alpha: 1)
        let color6 = UIColor(red: 32/255, green: 31/255, blue: 34/255, alpha: 1)
        
        let array = [color1, color2, color3, color4, color5, color6]
        
        if colorIndex == 5 {
            colorIndexDirection = false
        }
        if colorIndex == 0 {
            colorIndexDirection = true
        }
        let color = array[colorIndex]
        colorIndex = (colorIndexDirection) ? (colorIndex + 1) : (colorIndex - 1)
      
        return color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "Detail") {
            let destination = segue.destination as! DetailViewController,
            rowIndex = tableView.indexPathForSelectedRow!.row
            destination.weatherInfo = weatherProvider.getWeatherInfoArray(weather: weatherList[rowIndex])
            destination.useWeather = weatherList[rowIndex]
        }
        else if (segue.identifier == "Compare") {
            let destination = segue.destination as! ChooseCompViewController
            destination.cities = weatherList
            
        }
    }
 
}
