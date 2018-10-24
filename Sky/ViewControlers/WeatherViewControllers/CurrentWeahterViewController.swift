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
        let viewModel = Observable.combineLatest(locationVM, weatherVM) {
                return ($0, $1)
            }
            .filter {
                let (locaton, weather) = $0
                return !(locaton.isEmpty) && !(weather.isEmpty)
            }.share(replay: 1, scope: .whileConnected)
            .observeOn(MainScheduler.instance)
        
        viewModel.map { _ in false }.bind(to: self.activityIndicatorView.rx.isAnimating).disposed(by: bag)
        viewModel.map { _ in false }.bind(to: self.weatherContrainerView.rx.isHidden).disposed(by: bag)
        viewModel.map { $0.0.city }.bind(to: self.locationLabel.rx.text).disposed(by: bag)
        viewModel.map { $0.1.temperature }.bind(to: self.temperatureLabel.rx.text).disposed(by: bag)
        viewModel.map { $0.1.weatherIcon }.bind(to: self.weatherIcon.rx.image).disposed(by: bag)
        viewModel.map { $0.1.humidity }.bind(to: self.humidityLabel.rx.text).disposed(by: bag)
        viewModel.map { $0.1.summary }.bind(to: self.summaryLabel.rx.text).disposed(by: bag)
        viewModel.map { $0.1.date }.bind(to: self.dateLabel.rx.text).disposed(by: bag)



        
    }
}

