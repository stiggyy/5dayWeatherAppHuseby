//
//  ViewController.swift
//  5dayWeatherAppHuseby
//
//  Created by CATHERINE HUSEBY on 1/25/24.
//

import UIKit


struct weather: Codable{
    var list: [forecast]
}


struct forecast: Codable{
    var main: oneForecast
    var dt_txt: String
}

struct oneForecast: Codable{
    
    var temp: Double
    
    
}

struct appData: Codable{
    
    static var forecastList = [forecast]()
    static var tempList = [Double]()
    static var dateList = [String]()
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.tempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = "\(appData.dateList[indexPath.row]): \(appData.tempList[indexPath.row])"
        
        return cell
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
        getweather()
        tableViewOutlet.reloadData()
    }
    
    func getweather(){
        // creating object of URLSession class to make api call
        let session = URLSession.shared

                //creating URL for api call (you need your apikey)
                let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=-88.99&units=imperial&appid=6a76c3b63ebba36b8f19599ab210cb97")!
        
        // Making an api call and creating data in the completion handler
        let dataTask = session.dataTask(with: weatherURL) {
            // completion handler: happens on a different thread, could take time to get data
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error:\n\(error)")
            } else {
                // if there is data
                if let data = data {
                    // convert data to json Object
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        // print the jsonObj to see structure
                        print(jsonObj)
                        
                        if let searchResult = try? JSONDecoder().decode(weather.self, from: data){
                   
                                DispatchQueue.main.async {
                                    for m in searchResult.list{
                                        
                                        print(m.main.temp)
                                        appData.forecastList.append(m)
                                        appData.tempList.append(m.main.temp)
                                        self.tableViewOutlet.reloadData()
                                        
                                        let items = m.dt_txt.components(separatedBy: " ")
                                        var x = 0
                                        for i in items{
                                            if x % 2 == 0 {
                                                appData.dateList.append(i)
                                                
                                            }
                                            x = x + 1
                                        }
                                        
                                        for i in appData.dateList {
                                            print(i)
                                        }
                                        
                                        
                                    }
                                    
                                }
                                                                
                                
                            
                        }
                        
            
                            
                        }
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
                            
                
                            
        dataTask.resume()
                        
    
                        
                    }
        
    
                }

    



