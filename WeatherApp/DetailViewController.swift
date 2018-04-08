//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by lösen är 0000 on 2018-03-06.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, WeatherProviderDelegate {
    
    var city : String = ""
    var weatherInfo : [String] = []
    var uiArray : [UIView] = []
    var weatherProvider : WeatherProvider!
    var shouldRequestData : Bool = false
    var clothingProvider : ClothingProvider!
    var useWeather : Weather!

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var clothingView: UIView!
    @IBOutlet weak var invisibleView: UIView!
    @IBOutlet weak var backgroundView: UIImageView!
    
    var dynamicAnimator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherProvider = WeatherProvider(delegate: self)
        clothingProvider = ClothingProvider()
        
        if shouldRequestData {
            weatherProvider.getWeatherByCity(city: city)
        } else {
            setUpUi()
            setUpClothing(imageArray: clothingProvider.getAppClothes(weather: useWeather))
        }
        
        backgroundView.image = UIImage(named: weatherProvider.getBackgroundImage())
        dropView(items: [clothingView])
    }
    
    func dropView(items: [UIView]) {
        dynamicAnimator = UIDynamicAnimator(referenceView: invisibleView)
        gravity = UIGravityBehavior(items: items)
        collision = UICollisionBehavior(items: items)
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collision)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didGetWeather(weather: Weather) {
        DispatchQueue.main.async {
            self.weatherInfo = self.weatherProvider.getWeatherInfoArray(weather: weather)
            self.setUpUi()
            self.setUpClothing(imageArray: self.clothingProvider.getAppClothes(weather: weather))
        }
    }
    
    func didNotGetWeather(error: NSError) {}
    
    func setUpUi() {
        title = weatherInfo[0]
        tempLabel.text = weatherInfo[1]
        descriptionLabel.text = weatherInfo[2]
        weatherImageView.image = UIImage(named: weatherInfo[3])
        heartButton.setBackgroundImage(UIImage(named: weatherProvider.heartImagePath(city: weatherInfo[0])), for: UIControlState.normal)
        clothingView.layer.masksToBounds = true
        clothingView.layer.cornerRadius = 10.0
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
        let remainingWidth = clothingView.frame.size.width-(imageSize*imageCount)
        for i in 0...imageArray.count-1 {
            let i2 = CGFloat(i)
            let x = clothingView.frame.size.width/imageCount*i2+(remainingWidth/2)
            let y = clothingView.frame.size.height/2-(imageSize/2)
            print(imageArray[i])
            let imageView = UIImageView(image: imageArray[i])
            imageView.frame = CGRect(x: x, y: y, width: imageSize, height: imageSize)
            clothingView.addSubview(imageView)
        }
    }
    
    @IBAction func heartButtonClicked(_ sender: Any) {
        if weatherProvider.isFavoriteCity(city: weatherInfo[0]) {
            weatherProvider.removeCityFromFavoriteList(city: weatherInfo[0])
        } else {
            weatherProvider.addCityToFavoriteList(city: weatherInfo[0])
        }
        heartButton.setBackgroundImage(UIImage(named: weatherProvider.heartImagePath(city: weatherInfo[0])), for: UIControlState.normal)
    }

}
