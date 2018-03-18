//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var weatherProvider = WeatherProvider()
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        setData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData() {
        navBar.title = weatherProvider.getFavCityName()
        tempLabel.text = weatherProvider.getFavCityWeather()
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
