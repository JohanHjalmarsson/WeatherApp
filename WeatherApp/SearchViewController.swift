//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-21.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let searchDisplayTBC: WeatherTableViewController = segue.destination as! WeatherTableViewController
        if let city = searchField.text {
            searchDisplayTBC.cityName = city
        } else {
            searchDisplayTBC.cityName = "Search field was empty"
        }
        
    }
 */
 
    

}
