//
//  compareCitiesViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-04-07.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit
import GraphKit

class CompareCitiesViewController: UIViewController, GKBarGraphDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //diagram.dataSource = self
        //diagram.draw()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfBars() -> Int {
        return 2
    }
    
    func valueForBar(at index: Int) -> NSNumber! {
        return 4
    }
    
    func colorForBar(at index: Int) -> UIColor! {
        return UIColor.blue
    }
    
    func titleForBar(at index: Int) -> String! {
        return "bar"
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
