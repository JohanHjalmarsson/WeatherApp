//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, WeatherProviderDelegate {
    
    //var weatherProvider = WeatherProvider()
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var weatherProvider : WeatherProvider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherProvider = WeatherProvider(delegate: self)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navBar.title = "Weather App"
        hideOrShowUi(state: false)
        weatherProvider.getFavoriteCity()
        //setData()

        // Do any additional setup after loading the view.
    }
    
    func didGetWeather(weather: Weather) {
        DispatchQueue.main.async {
           self.setUpUi(weather: self.weatherProvider.getWeatherInfoArray(weather: weather))
        }
    }
    
    func didNotGetWeather(error: NSError) {
        print(error)
    }
    
    func hideOrShowUi(state: Bool) {
        tempLabel.isHidden = state
        weatherImageView.isHidden = state
        descriptionLabel.isHidden = state
    }
    
    func setUpUi(weather: [String]) {
        navBar.title = weather[0]
        tempLabel.text = weather[1]
        descriptionLabel.text = weather[2]
        weatherImageView.image = UIImage(named: weather[3])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
