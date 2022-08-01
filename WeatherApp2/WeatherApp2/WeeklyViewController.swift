//
//  WeeklyViewController.swift
//  WeatherApp2
//
//  Created by irem on 29.07.2022.
//

import UIKit
import CoreLocation
import Foundation
class WeeklyViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var dayLabel1: UILabel!
    @IBOutlet weak var dayLabel2: UILabel!
    @IBOutlet weak var dayLabel3: UILabel!
    @IBOutlet weak var dayLabel4: UILabel!
    @IBOutlet weak var dayLabel5: UILabel!
    @IBOutlet weak var dayLabel6: UILabel!
    
    
    @IBOutlet weak var tempLabel1: UILabel!
    @IBOutlet weak var tempLabel2: UILabel!
    @IBOutlet weak var tempLabel3: UILabel!
    @IBOutlet weak var tempLabel4: UILabel!
    @IBOutlet weak var tempLabel5: UILabel!
    @IBOutlet weak var tempLabel6: UILabel!
    
    
    
    @IBOutlet weak var tempImage1: UIImageView!
    @IBOutlet weak var tempImage2: UIImageView!
    @IBOutlet weak var tempImage3: UIImageView!
    @IBOutlet weak var tempImage4: UIImageView!
    @IBOutlet weak var tempImage5: UIImageView!
    @IBOutlet weak var tempImage6: UIImageView!
    
   
    
    var lat=1.0
    var lon=1.0
    var day=""
    var locationManager = CLLocationManager()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        lat=location.latitude
        lon=location.longitude
    }
    
 
    @IBAction func GetDailyWeatherForecast(_ sender: Any) {
        let url = URL(string:"https://api.weatherbit.io/v2.0/forecast/daily?lat=\(lat)&lon=\(lon)&key=7522bb939d8a47059268bf43d7a0a276")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil  {
                print("error")
            }else  {
                //datayı alıyorum
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        
                        DispatchQueue.main.async {
                            if let daily = jsonResponse!["data"] as?  Array<Any> {
                                    if let ındex = daily[1] as?  [String:Any] {
                                        if let datetime = ındex["datetime"] as?  String {
                                            DateToDay(dateString: String(datetime))
                                            self.dayLabel1.text=String(self.day)
                                        }
                                        if let temp = ındex["temp"] as?  Double {
                                            self.tempLabel1.text=String(temp)
                                        }
                                        if let weather = ındex["weather"] as?  [String:Any] {
                                            if let icon = weather["icon"] as?  String {
                                                print(icon)
                                                self.tempImage1.loadFrom(URLAddress: "https://www.weatherbit.io/static/img/icons/\(icon).png")
                                            }
                                        }

                                    }
                                if let ındex = daily[2] as?  [String:Any] {
                                    if let datetime = ındex["datetime"] as?  String {
                                        DateToDay(dateString: String(datetime))
                                        self.dayLabel2.text=String(self.day)
                                    }
                                    if let temp = ındex["temp"] as?  Double {
                                        self.tempLabel2.text=String(temp)
                                    }
                                    if let weather = ındex["weather"] as?  [String:Any] {
                                        if let icon = weather["icon"] as?  String {
                                            print(icon)
                                            self.tempImage2.loadFrom(URLAddress: "https://www.weatherbit.io/static/img/icons/\(icon).png")
                                        }
                                    }
                                    
                                }
                                if let ındex = daily[3] as?  [String:Any] {
                                    if let datetime = ındex["datetime"] as?  String {
                                        DateToDay(dateString: String(datetime))
                                        self.dayLabel3.text=String(self.day)
                                    }
                                    if let temp = ındex["temp"] as?  Double {
                                        self.tempLabel3.text=String(temp)
                                    }
                                    if let weather = ındex["weather"] as?  [String:Any] {
                                        if let icon = weather["icon"] as?  String {
                                            print(icon)
                                            self.tempImage3.loadFrom(URLAddress: "https://www.weatherbit.io/static/img/icons/\(icon).png")
                                        }
                                    }
                                    
                                }
                                if let ındex = daily[4] as?  [String:Any] {
                                    if let datetime = ındex["datetime"] as?  String {
                                        DateToDay(dateString: String(datetime))
                                        self.dayLabel4.text=String(self.day)
                                    }
                                    if let temp = ındex["temp"] as?  Double {
                                        self.tempLabel4.text=String(temp)
                                    }
                                    if let weather = ındex["weather"] as?  [String:Any] {
                                        if let icon = weather["icon"] as?  String {
                                            print(icon)
                                            self.tempImage4.loadFrom(URLAddress: "https://www.weatherbit.io/static/img/icons/\(icon).png")
                                        }
                                    }
                                    
                                }
                                if let ındex = daily[5] as?  [String:Any] {
                                    if let datetime = ındex["datetime"] as?  String {
                                        DateToDay(dateString: String(datetime))
                                        self.dayLabel5.text=String(self.day)
                                    }
                                    if let temp = ındex["temp"] as?  Double {
                                        self.tempLabel5.text=String(temp)
                                    }
                                    if let weather = ındex["weather"] as?  [String:Any] {
                                        if let icon = weather["icon"] as?  String {
                                            print(icon)
                                            self.tempImage5.loadFrom(URLAddress: "https://www.weatherbit.io/static/img/icons/\(icon).png")
                                        }
                                    }
                                    
                                }
                                if let ındex = daily[6] as?  [String:Any] {
                                    if let datetime = ındex["datetime"] as?  String {
                                        DateToDay(dateString: String(datetime))
                                        self.dayLabel6.text=String(self.day)
                                    }
                                    if let temp = ındex["temp"] as?  Double {
                                        self.tempLabel6.text=String(temp)
                                                                          
                                    }
                                    if let weather = ındex["weather"] as?  [String:Any] {
                                        if let icon = weather["icon"] as?  String {
                                            print(icon)
                                            self.tempImage6.loadFrom(URLAddress: "https://www.weatherbit.io/static/img/icons/\(icon).png")
                                        }
                                    }
                                    
                                    
                                }
                                                              
                                
                            }
                        }

                        
                    }catch{
                        
                    }
                    
                }
            }
        }
        task.resume()
       
         
        func DateToDay(dateString:String){
               let formatter = DateFormatter()
               formatter.dateFormat = "yyyy-MM-dd"
               guard let date = formatter.date(from: dateString) else {
                   return
               }
                formatter.dateFormat = "EEEE"
               day = formatter.string(from: date)
        }

    }
    
    @IBAction func buttonClicked2(_ sender: Any) {
    }
}
extension UIImageView {
    func load(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
