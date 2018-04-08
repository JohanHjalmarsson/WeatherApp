//
//  ChooseCompViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-04-07.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class ChooseCompViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var cities : [Weather] = []
    var sendCities : [Weather] = []
    var pickerData : [[String]] = [[]]

    @IBOutlet weak var pickerOne: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerOne.delegate = self
        pickerOne.dataSource = self
        initPickerData()
        updateSendCities()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateSendCities()
    }
    
    func updateSendCities() {
        if sendCities.count > 0 {
            sendCities.removeAll()
        }
        for city in cities {
            if city.name == pickerData[1][pickerOne.selectedRow(inComponent: 1)] {
                sendCities.append(city)
            }
            if city.name == pickerData[0][pickerOne.selectedRow(inComponent: 0)] {
                sendCities.append(city)
            }
        }
    }
    
    func initPickerData() {
        var arrayOne : [String] = []
        var arrayTwo : [String] = []
        for weather in cities {
            if let city = weather.name {
                arrayOne.append(city)
                arrayTwo.append(city)
            }
        }
        pickerData = [arrayOne, arrayTwo]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "CompareChoices") {
            let destination = segue.destination as! CompareCitiesViewController
            destination.cities = sendCities
        }
    }
}
