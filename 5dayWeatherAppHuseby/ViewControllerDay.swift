//
//  ViewControllerDay.swift
//  5dayWeatherAppHuseby
//
//  Created by CATHERINE HUSEBY on 1/26/24.
//

import UIKit

class ViewControllerDay: UIViewController {
    
  //  "Drizzle" : "🌦️",
    //    "ThunderStorm" : "⛈️",
    //    "Snow" : "❄️",
     //   "Rain" : "🌧️",
     //   "Clear" : "☀️",
     //   "Clouds" : "☁️"
    
    
  //  @IBOutlet weak var tempOutlet: UILabel!
    
    @IBOutlet weak var todayOutlet: UILabel!
    
    @IBOutlet weak var highOutlet: UILabel!
    
    @IBOutlet weak var lowOutlet: UILabel!
    
    @IBOutlet weak var feelsLikeOutlet: UILabel!
    
    @IBOutlet weak var humidityOutlet: UILabel!
    
    @IBOutlet weak var tempOutlet: UILabel!
    
    
    @IBOutlet weak var tempDescOutlet: UILabel!
    
    
    @IBOutlet weak var moreDescOutlet: UILabel!
    
    //var tempDesc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todayOutlet.text = "\(appData.dateList[appData.index]), \(appData.longDateList[appData.index])"
        highOutlet.text = "High: \(appData.forecastList[appData.index].main.temp_max) degrees"
        lowOutlet.text = "Low: \(appData.forecastList[appData.index].main.temp_min) degrees"
        feelsLikeOutlet.text = "Feels like: \(appData.forecastList[appData.index].main.feels_like) degrees"
        humidityOutlet.text = "Humidity: \(appData.forecastList[appData.index].main.humidity)%"
        tempOutlet.text = "Temprature: \(appData.forecastList[appData.index].main.temp) degrees"
        
        switch appData.forecastList[appData.index].weather[0].main {
        
        case "Clouds":
            tempDescOutlet.text = "☁️ Looking Cloudy!"
            
        case "Clear":
            tempDescOutlet.text = "☀️ All Clear!"
            
        case "Rain":
            tempDescOutlet.text = "🌧️ Rainy!"
            
        case "Snow":
            tempDescOutlet.text = "❄️ Snowy!"
            
        case "ThunderStorm":
            tempDescOutlet.text = "⛈️ Thunderstorm :("
            
        case "Drizzle":
            tempDescOutlet.text = "🌦️ Drizzle!"
            
        default:
            tempDescOutlet.text = "ZOMBIE APOCOLYPSE"
        }
        
        moreDescOutlet.text = "\(appData.forecastList[appData.index].weather[0].description)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
