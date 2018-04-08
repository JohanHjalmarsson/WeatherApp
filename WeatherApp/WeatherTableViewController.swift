//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-21.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, UISearchResultsUpdating {

    var list : [WeatherLocationItem] = []
    var searchResults : [WeatherLocationItem] = []
    var theSearchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        theSearchController = UISearchController(searchResultsController: nil)
        theSearchController.searchResultsUpdater = self
        theSearchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = theSearchController
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Detail") {
            let destination = segue.destination as! DetailViewController,
            rowIndex = tableView.indexPathForSelectedRow!.row
            destination.shouldRequestData = true
            destination.city = searchResults[rowIndex].name!
        }
     }
}
