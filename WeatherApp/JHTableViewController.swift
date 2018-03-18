//
//  JHTableViewController.swift
//  WeatherApp
//
//  Created by lösen är 0000 on 2018-03-05.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class JHTableViewController: UITableViewController {
    var provider = WeatherProvider()
    var list : [[String: String]] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.list = provider.getList()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return self.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "JHCell", for: indexPath)
        //let cell: WeatherCell = self.tableView.dequeueReusableCell(withIdentifier: "JHCell", for: indexPath)
        let cell: WeatherCell = self.tableView.dequeueReusableCell(withIdentifier: "JHCell") as! WeatherCell
        
        //cell.textLabel?.text = self.list[indexPath.row]
        cell.labelLeft.text = self.list[indexPath.row]["City"]
        cell.laberlRight.text = self.list[indexPath.row]["Weather"]

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
 

}
