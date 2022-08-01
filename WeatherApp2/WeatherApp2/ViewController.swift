//
//  ViewController.swift
//  WeatherApp2
//
//  Created by irem on 29.07.2022.
//

import UIKit
import CoreLocation


class ViewController: UIViewController,  CLLocationManagerDelegate {
    

    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var feelsLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var feelsImage: UIImageView!
    @IBOutlet weak var windImage: UIImageView!
    
    var lat=1.0
    var lon=1.0
    var locationManager = CLLocationManager()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather API"
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

   
    
    
    @IBAction func getButtonClicked(_ sender: Any) {
        // web adresine istek gönderiyorum
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=093094ae7caad196fbc3d7c0e65e9295")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil  {
                print("error")
            }else  {
                //datayı alıyorum
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        
                        DispatchQueue.main.async { [self] in
                            if let main = jsonResponse!["main"] as?  [String:Any] {
                                if let temp = main["temp"] as?  Double{
                                    self.currentLabel.text = String(Int(temp - 272.15))
                                }
                                if let feels = main["feels_like"] as? Double{
                                    self.feelsLabel.text = String(Int(feels - 272.15))
                                }
                            }
                            if let wind = jsonResponse!["wind"] as? [String:Any]{
                                if let speed = wind["speed"] as? Double{
                                    self.windLabel.text = String(Int(speed))
                                }
                            }
                            
                            if let name = jsonResponse!["name"] as? String{
                                self.locationLabel.text = String(name)
                            }
                            
                            if let sys = jsonResponse!["sys"] as? [String:Any]{
                                if let country = sys["country"] as? String{
                                    self.countryLabel.text = String(country)
                                }
                            }
                            if let weather = jsonResponse!["weather"] as? Array<Any>{
                                if let index = weather[0] as? [String:Any]{
                                    if let icon = index["icon"] as? String{
                                        self.currentImage.loadFrom(URLAddress: "https://openweathermap.org/img/wn/\(icon)@2x.png")
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
        
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
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
