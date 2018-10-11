//
//  SettingViewController.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/11.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func controllerDidChangeTimeMode(controller: SettingsViewController)
    func controllerDidChangeTemperatureModel(controller: SettingsViewController)
}

class SettingsViewController: UITableViewController {
    
    weak var settingsDelegate: SettingsViewControllerDelegate?
    
    private enum Section: Int {
        case date
        case temperature
        
        var numberOfRows: Int {
            return 2
        }
        
        static var count: Int {
            return Section.temperature.rawValue + 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return Section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected section index")
        }
        return section.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Date format"
        }
        
        return "Temperature unit"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            fatalError("Unexpected table view cell")
        }
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section index")
        }
        
        switch section {
        case .date:
            cell.label.text = (indexPath.row == 0) ? "Fri, 01 December" : "F, 12/01"
            let timeMode = UserDefaults.dateMode()
            
            if indexPath.row == timeMode.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .temperature:
            cell.label.text = (indexPath.row == 0) ? "Celcius" : "Fahrenheit"
            let temperatureNotation = UserDefaults.temperatureMode()
            
            if indexPath.row == temperatureNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    // MARk: UITableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section index")
        }
        
        switch section {
        case .date:
            let dateMode = UserDefaults.dateMode()
            guard indexPath.row != dateMode.rawValue else { return }
            
            if let newMode = DateMode(rawValue: indexPath.row) {
                UserDefaults.setDateMode(to: newMode)
            }
            
            settingsDelegate?.controllerDidChangeTimeMode(controller: self)
        case .temperature:
            let temperature = UserDefaults.temperatureMode()
            guard indexPath.row != temperature.rawValue else { return }
            
            if let newMode = TemperatureMode(rawValue: indexPath.row) {
                UserDefaults.setTemperatureMode(to: newMode)
            }
            
            settingsDelegate?.controllerDidChangeTemperatureModel(controller: self)
        }
        
        let sections = IndexSet(integer: indexPath.section)
        tableView.reloadSections(sections, with: .none)
    }

}
