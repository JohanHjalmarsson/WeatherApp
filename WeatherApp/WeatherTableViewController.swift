//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-21.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, UISearchResultsUpdating {
   
    
    //var cityName : String = ""
    //var list : [Weather] = []
    //var weatherProvider: WeatherProvider!
    var list : [WeatherLocationItem] = []
    var searchResults : [WeatherLocationItem] = []
    
    
    
    var theSearchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
       // weatherProvider = WeatherProvider(delegate: self)
       // weatherProvider.getWeatherByCity(city: cityName)
        
        definesPresentationContext = true
        
        theSearchController = UISearchController(searchResultsController: nil)
        theSearchController.searchResultsUpdater = self
        theSearchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.searchController = theSearchController
        
        //let mainVC : MainViewController = MainViewController()
        //list = mainVC.allCitiesIntheHoleWorldList
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        theSearchController.searchBar.becomeFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let userInput = searchController.searchBar.text?.lowercased() {
            searchResults = list.filter({ $0.name!.lowercased().contains(userInput) })
        } else {
            searchResults = []
        }
        tableView.reloadData()
    }
    
    var shouldUseSearchResult : Bool {
        if let text = theSearchController.searchBar.text {
            if text.isEmpty {
                return false
            } else {
                return theSearchController.isActive
            }
        } else {
            return false
        }
    }
    
//    func didGetWeather(weather: Weather) {
//        DispatchQueue.main.async {
//            self.list.append(weather)
//            self.tableView.reloadData()
//        }
//    }
    
//    func didNotGetWeather(error: NSError) {
//        print(error)
//    }

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
        if shouldUseSearchResult {
            return searchResults.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AnotherWeatherCell = self.tableView.dequeueReusableCell(withIdentifier: "SearchDisplayCell") as! AnotherWeatherCell
        let array : [WeatherLocationItem]
        if shouldUseSearchResult {
            array = searchResults
        } else {
            array = []
        }
        cell.labelLeft.text = array[indexPath.row].name
        cell.labelRight.text = ""
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
            destination.shouldRequestData = true
            destination.city = searchResults[rowIndex].name!
        }
     
     }
 

}
