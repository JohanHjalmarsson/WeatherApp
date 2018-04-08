//
//  CompareCitiesViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-04-07.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit
import GraphKit

class CompareCitiesViewController: UIViewController, GKBarGraphDataSource {
    var cities : [Weather] = []
    var weatherHelper : WeatherHelper!
    var tempList : [Int] = []

    @IBOutlet weak var cityOneLabel: UILabel!
    @IBOutlet weak var cityTwoLabel: UILabel!
    @IBOutlet weak var cityOneTemp: UILabel!
    @IBOutlet weak var cityTwoTemp: UILabel!
    
    @IBOutlet weak var diagram: GKBarGraph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherHelper = WeatherHelper()
        tempList = weatherHelper.getScaleForTemp(list: cities)
        setUpLabels()
        diagram.dataSource = self
        diagram.barWidth = diagram.frame.width/3
        diagram.draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpLabels() {
        if cities.count == 2 {
            cityOneLabel.text = cities[0].name
            cityTwoLabel.text = cities[1].name
            cityOneTemp.text = "\(weatherHelper.getCelsius(weather: cities[0]))"
            cityTwoTemp.text = "\(weatherHelper.getCelsius(weather: cities[1]))"
        }
    }
    
    func numberOfBars() -> Int {
        return cities.count
    }
    
    func valueForBar(at index: Int) -> NSNumber! {
        let temp = tempList[index]
        let tempNs : NSNumber = NSNumber(value: temp)
        print(tempNs)
        return tempNs
    }
    
    func colorForBar(at index: Int) -> UIColor! {
        return UIColor.green
    }
    
    func titleForBar(at index: Int) -> String! {
        return ""
    }

}
