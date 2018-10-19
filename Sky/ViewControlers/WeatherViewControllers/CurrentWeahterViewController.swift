//
//  CurrentWeahterViewController.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(controller: CurrentWeahterViewController)
    func settingButtonPressed(controller: CurrentWeahterViewController)

}

class CurrentWeahterViewController: WeatherViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var bag = DisposeBag()
    var weatherVM: BehaviorRelay<CurrentWeatherViewModel> = BehaviorRelay(value: CurrentWeatherViewModel.empty)
    var locationVM: BehaviorRelay<CurrentLocationViewModel> = BehaviorRelay(value: CurrentLocationViewModel.empty)
    
    weak var delegate: CurrentWeatherViewControllerDelegate?

    var viewModel: CurrentWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        delegate?.settingButtonPressed(controller: self)
    }
    
    func updateView() {
        activityIndicatorView.startAnimating()
        
        weatherVM.accept(weatherVM.value)
        locationVM.accept(locationVM.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.combineLatest(locationVM, weatherVM) {
                return ($0, $1)
            }
            .filter {
                let (locaton, weather) = $0
                return !(locaton.isEmpty) && !(weather.isEmpty)
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                let (location, weather) = $0
                self.weatherContrainerView.isHidden = false
                self.locationLabel.text = location.city
                self.temperatureLabel.text = weather.temperature
                self.weatherIcon.image = weather.weatherIcon
                self.humidityLabel.text = weather.humidity
                self.summaryLabel.text = weather.summary
                self.dateLabel.text = weather.date
            }).disposed(by: bag)
        
    }
}

