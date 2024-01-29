//
//  ViewController.swift
//  5dayWeatherAppHuseby
//
//  Created by CATHERINE HUSEBY on 1/25/24.
//

import UIKit


struct searchResult: Codable{
    var list: [forecast]
}


struct forecast: Codable{
    var main: oneForecast
    var dt_txt: String
    var weather: [moreWeather]
}

struct oneForecast: Codable{
    
    var temp: Double
    var feels_like: Double
    var humidity: Int
    var temp_max: Double
    var temp_min: Double
    
    
}


struct moreWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String

}



struct appData: Codable{
    static var index = 0
    static var forecastList = [forecast]()
    static var tempList = [Double]()
    static var dateList = [String]()
    
    static var longDateList = [String]()
    
    //static var moreWeatherList = [moreWeather]()
}



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //yay
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.tempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = "\(appData.dateList[indexPath.row]): \(appData.tempList[indexPath.row]) degrees Fahrenheit"
        
        cell.textLabel?.font = UIFont(name: "Futura Bold", size: CGFloat(integerLiteral: 15))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDay", sender: self)
        appData.index = indexPath.row
    }
    
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        appData.forecastList.removeAll()
        appData.dateList.removeAll()
        appData.tempList.removeAll()
        //appData.moreWeatherList.removeAll()
        getweather()
        //changeDayOfWeek()
        tableViewOutlet.reloadData()
    }
    
    func getweather(){
        let session = URLSession.shared
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=42.24&lon=-88.316&units=imperial&appid=6a76c3b63ebba36b8f19599ab210cb97")!
        
        // Making an api call and creating data in the completion handler
        let dataTask = session.dataTask(with: weatherURL) {
            // completion handler: happens on a different thread, could take time to get data
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error:\n\(error)")
            } else {
                //print("We got it")
                // if there is data
                if let data = data {
                    // convert data to json Object
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        // print the jsonObj to see structure
                        print(jsonObj)
                        
                        if let searchResult = try? JSONDecoder().decode(searchResult.self, from: data){
                            print("decoded yay")
                            DispatchQueue.main.async {
                                print("got to the main async")
                                for m in searchResult.list{
                                    let items = m.dt_txt.components(separatedBy: " ")
                                    if items[1] == "12:00:00"{
                                        appData.forecastList.append(m)
                                        appData.tempList.append(m.main.temp)
                                        appData.dateList.append(items[0])
                                        //appData.moreWeatherList.append(m.weather)
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                appData.longDateList = appData.dateList
                                self.changeDayOfWeek()
                                self.tableViewOutlet.reloadData()
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
                
        }
                            
                
                            
        dataTask.resume()
                        
    
                        
    }
    
    
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func changeDayOfWeek(){
    //print("func called")
        for i in 0 ..< appData.dateList.count{
            let x = getDayOfWeek(appData.dateList[i])
            switch x {
            case 1:
                appData.dateList[i] = "Sunday"
            case 2:
                appData.dateList[i] = "Monday"
            case 3:
                appData.dateList[i] = "Tuesday"
            case 4:
                appData.dateList[i] = "Wednesday"
            case 5:
                appData.dateList[i] = "Thursday"
            case 6:
                appData.dateList[i] = "Friday"
            case 7:
                appData.dateList[i] = "Saturday"
                

            case .none:
                print("whoops")
            case .some(_):
                print("whoops")
            }
            
                // tableViewOutlet.reloadData()
        }
    }
        
    
    }

    



