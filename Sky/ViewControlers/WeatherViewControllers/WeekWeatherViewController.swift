//
//  WeekWeatherViewController.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/10.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

class WeekWeatherViewController: WeatherViewController {

    @IBOutlet weak var weekWeatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension WeekWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
