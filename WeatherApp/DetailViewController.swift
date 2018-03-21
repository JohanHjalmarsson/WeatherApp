//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by lösen är 0000 on 2018-03-06.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var weatherInfo : [String] = []
    var uiArray : [UIView] = []

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUi() {
        label.text = weatherInfo[0]
        weatherLabel.text = weatherInfo[2]
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
