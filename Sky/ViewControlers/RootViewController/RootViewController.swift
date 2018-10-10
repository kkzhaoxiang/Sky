//
//  ViewController.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/5.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    var currentWeatherController: CurrentWeahterViewController!
    private let segueCurrentWeather = "SegueCurrentWeather"
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        // 设置精度
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        return manager
    }()
    
    private var currentLocation: CLLocation? {
        didSet {
            // Fetch the city name
            fetchCity()
            // Fetch the weather data
            fetchWeath()
        }
    }
    
    private func fetchCity() {
        guard let currentLocation = currentLocation else {
            return
        }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                dump(error)
            } else if let city = placemarks?.first?.locality {
                let location = Location(
                    name: city,
                    latitude: currentLocation.coordinate.latitude,
                    longitude: currentLocation.coordinate.longitude)
                self.currentWeatherController.viewModel?.location = location
            }
        }
    }
    
    private func fetchWeath() {
        guard let currentLocation = currentLocation else {
            return
        }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon) { (response, error) in
            if let error = error {
                dump(error)
            } else if let response = response {
                self.currentWeatherController.viewModel?.weather = response
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case segueCurrentWeather:
            guard let destinnation = segue.destination as? CurrentWeahterViewController else {
                fatalError("Invalid destinnation view control;er")
            }
            destinnation.viewModel = CurrentWeatherViewModel()
            destinnation.delegate = self
            currentWeatherController = destinnation
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActiveNotification()
        
        
    }
    
    private func setupActiveNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(RootViewController.applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    func requestLocation() {
        locationManager.delegate = self
        
        // 如果当前用户有权限了,就用locationManager请求位置,没有权限,就申请用户授权
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }


}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.delegate = nil
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}

extension RootViewController: CurrentWeatherViewControllerDelegate {
    func locationButtonPressed(controller: CurrentWeahterViewController) {
        print("Open location")
    }
    
    func settingButtonPressed(controller: CurrentWeahterViewController) {
        print("Open setting")
    }
}
