//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, WeatherProviderDelegate, WeatherLocationsDelegate {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tempLabel: UILabel!
    //@IBOutlet weak var searchItem: UIBarButtonItem!
    //@IBOutlet weak var favoriteItem: UIBarButtonItem!
    @IBOutlet weak var clothingView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favMenuButton: UIButton!
    @IBOutlet weak var searchMenuButton: UIButton!
    
    var weatherProvider : WeatherProvider!
    var hasLoadedWeather : Bool = false
    var hasLoadedList : Bool = false
    var clotingProvider : ClothingProvider!
    var allCitiesIntheHoleWorldList : [WeatherLocationItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherProvider = WeatherProvider(delegate: self)
        let weatherLocations = WeatherLocations(delegate: self)
        weatherLocations.parseJson()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navBar.title = "Weather App"
        hideOrShowUi(state: true)
        weatherProvider.getFavoriteCity()
        clotingProvider = ClothingProvider()
        setUpButton(button: favMenuButton, imageName: "heartFilled");
        setUpButton(button: searchMenuButton, imageName: "search")
      
    }
    
    func getAllCitiesInTheHoleWorld() -> [WeatherLocationItem] {
        return allCitiesIntheHoleWorldList
    }
    
    func didGetWeather(weather: Weather) {
        DispatchQueue.main.async {
           self.setUpUi(weather: self.weatherProvider.getWeatherInfoArray(weather: weather))
            self.setUpClothing(imageArray: self.clotingProvider.getAppClothes(weather: weather))
            self.hasLoadedWeather = true
            if self.hasLoadedList {
                self.hideOrShowUi(state: false)
            }
        }
    }
    
    func didNotGetWeather(error: NSError) {
        print(error)
    }
    
    func didGetWeatherLocations(list: [WeatherLocationItem]) {
        DispatchQueue.main.async {
            self.allCitiesIntheHoleWorldList = list
            self.hasLoadedList = true
            if self.hasLoadedWeather {
                self.hideOrShowUi(state: false)
            }
        }
    }
    func didNotGetWeatherLocations(error: NSError) {}
    
    func hideOrShowUi(state: Bool) {
        tempLabel.isHidden = state
        weatherImageView.isHidden = state
        descriptionLabel.isHidden = state
//        searchItem.isEnabled = !state
//        favoriteItem.isEnabled = !state
        if state {
            indicatorView.startAnimating()
        } else {
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
        }
    }
    
    func setUpUi(weather: [String]) {
        navBar.title = weather[0]
        tempLabel.text = weather[1]
        descriptionLabel.text = weather[2]
        weatherImageView.image = UIImage(named: weather[3])
    }
    // Fundera på att sätta denna i ClothingProvider och endast returnera en view
    func setUpClothing(imageArray: [UIImage]) {
        print("set up cloth")
        let imageCount = CGFloat(imageArray.count+1)
        var imageSize : CGFloat {
            if clothingView.frame.size.width/imageCount > 50 {
                return CGFloat(50)
            } else {
                return CGFloat(clothingView.frame.size.width/imageCount)
            }
        }
        for i in 0...imageArray.count-1 {
            print("clothes: ",i)
            let i2 = CGFloat(i)
            let y = clothingView.frame.size.height/imageCount*i2
            let x = clothingView.frame.size.width/(CGFloat(2))-imageSize/2
            print(imageArray[i])
            let imageView = UIImageView(image: imageArray[i])
            imageView.frame = CGRect(x: x, y: y, width: imageSize, height: imageSize)
            clothingView.addSubview(imageView)
        }
    }
    
    func setUpButton(button: UIButton, imageName: String) {
        button.layer.cornerRadius = favMenuButton.frame.size.height / 2
        button.clipsToBounds = true
        button.setImage(UIImage(named:imageName), for: .normal)
        button.contentMode = UIViewContentMode.center
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 5
        button.layer.masksToBounds = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Search") {
            let searchC = segue.destination as! WeatherTableViewController
            searchC.list = allCitiesIntheHoleWorldList
        }

    }
    

}
