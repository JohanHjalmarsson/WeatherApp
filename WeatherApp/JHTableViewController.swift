//
//  JHTableViewController.swift
//  WeatherApp
//
//  Created by lösen är 0000 on 2018-03-05.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class JHTableViewController: UITableViewController, WeatherProviderDelegate {
    //var provider = WeatherProvider()
    var favList : [String] = []
    var weatherList : [Weather] = []
    var weatherProvider : WeatherProvider!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherProvider = WeatherProvider(delegate: self)
    
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
           // self.list.append(weather)
           // self.tableView.reloadData()
        }
    }
    
    func didNotGetWeather(error: NSError) {
        print(error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return self.list.count
        if shouldUseWeatherList {
            return weatherList.count
        } else {
            return favList.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "JHCell", for: indexPath)
        //let cell: WeatherCell = self.tableView.dequeueReusableCell(withIdentifier: "JHCell", for: indexPath)
        let cell: WeatherCell = self.tableView.dequeueReusableCell(withIdentifier: "JHCell") as! WeatherCell
        
        //cell.textLabel?.text = self.list[indexPath.row]
//        cell.labelLeft.text = self.list[indexPath.row]["City"]
//        cell.laberlRight.text = self.list[indexPath.row]["Weather"]
        
        if shouldUseWeatherList {
            cell.labelLeft.text = weatherList[indexPath.row].name
            cell.laberlRight.text = String(describing: weatherList[indexPath.row].main.temp)
        } else {
            cell.labelLeft.text = favList[indexPath.row]
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "Detail") {
            let destination = segue.destination as! DetailViewController,
            rowIndex = tableView.indexPathForSelectedRow!.row
            
            if let city = self.list[rowIndex]["City"] {
                destination.cityName = city
                destination.title = city
            }
            if let weather = self.list[rowIndex]["Weather"] {
                destination.weather = weather
            }
            
            
            
            
            
        }
        
    }
 
    */
 

}
