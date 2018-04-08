//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Johan Hjalmarsson on 2018-03-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class MainViewController: UIViewController, WeatherProviderDelegate, WeatherLocationsDelegate {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var clothingView: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favMenuButton: UIButton!
    @IBOutlet weak var searchMenuButton: UIButton!
    @IBOutlet weak var customIndicator: NVActivityIndicatorView!
    @IBOutlet weak var mainView: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    
    var weatherProvider : WeatherProvider!
    var hasLoadedWeather : Bool = false
    var hasLoadedList : Bool = false
    var clotingProvider : ClothingProvider!
    var allCitiesIntheHoleWorldList : [WeatherLocationItem] = []
    var viewArray : [UIView] = []
    var timerInited : Bool = false
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherProvider = WeatherProvider(delegate: self)
        let weatherLocations = WeatherLocations(delegate: self)
        weatherLocations.parseJson()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navBar.title = "Weather App"
        hideOrShowUi(state: true)
        weatherProvider.getFavoriteCity()
        clotingProvider = ClothingProvider()
        setUpButton(button: favMenuButton, imageName: "heartFilled");
        setUpButton(button: searchMenuButton, imageName: "search")
        viewArray = [weatherImageView, clothingView, descriptionLabel, tempLabel, favMenuButton, searchMenuButton]
        setBackgroundImage()
    }
    
    func startTimer() {
        timerInited = true
        timer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true, block: { (timer) in
           self.weatherProvider.getFavoriteCity()
        })
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
                self.afterWeatherOrList()
            }
        }
    }
    
    func didNotGetWeather(error: NSError) {
        print(error)
    }
    func afterWeatherOrList() {
        if !timerInited {
            startTimer()
            hideOrShowUi(state: false)
        }
    }
    
    func didGetWeatherLocations(list: [WeatherLocationItem]) {
        DispatchQueue.main.async {
            self.allCitiesIntheHoleWorldList = list
            self.hasLoadedList = true
            if self.hasLoadedWeather {
            }
        }
    }
    func didNotGetWeatherLocations(error: NSError) {}
    
    func hideOrShowUi(state: Bool) {

        weatherImageView.isHidden = state
        clothingView.isHidden = state
        descriptionLabel.isHidden = state
        tempLabel.isHidden = state
        favMenuButton.isHidden = state
        searchMenuButton.isHidden = state
        
        weatherImageView.alpha = 0
        clothingView.alpha = 0
        descriptionLabel.alpha = 0
        tempLabel.alpha = 0
        favMenuButton.alpha = 0
        searchMenuButton.alpha = 0
        
        if state {
           customIndicator.startAnimating()
        } else {
           customIndicator.stopAnimating()
           customIndicator.isHidden = true
            animateStuff()
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
        let imageCount = CGFloat(imageArray.count+1)
        var imageSize : CGFloat {
            if clothingView.frame.size.width/imageCount > 50 {
                return CGFloat(50)
            } else {
                return CGFloat(clothingView.frame.size.width/imageCount)
            }
        }
        for i in 0...imageArray.count-1 {
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
    
    func setBackgroundImage() {
        backgroundView.image = UIImage(named: weatherProvider.getBackgroundImage())
    }
    
    func animateStuff() {
        var delay : Double = 0.0
        for view in viewArray {
            UIView.animate(withDuration: 0.3, delay: delay, animations: {
                view.alpha = 1
                view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { (complete) in
                let completeDelay = (view == self.favMenuButton || view == self.searchMenuButton) ? 0.5 : 0.0
                UIView.animate(withDuration: 0.5, delay: completeDelay, animations: {
                    view.transform = CGAffineTransform.identity
                })
            }
            delay = delay + 0.1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.loopAnimation(view: self.weatherImageView)
            print("kör!")
        })
    }
    
    func loopAnimation(view: UIView) {
        UIView.animate(withDuration: 1.9,delay: 0, options: [.repeat, .autoreverse], animations: {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (completion) in
            UIView.animate(withDuration: 1.9, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Search") {
            let searchC = segue.destination as! WeatherTableViewController
            searchC.list = allCitiesIntheHoleWorldList
        }

    }
    

}
