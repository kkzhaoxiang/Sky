//
//  AddLocationViewController.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/16.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit
import CoreLocation

protocol AddLocationViewControllerDelegate {
    func controller(_ controller: AddLocationViewController,
                    didAddLocation location: Location)
}

class AddLocationViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
   
    private var locations: [Location] = []
    
    var delegate: AddLocationViewControllerDelegate?
    
    var geocoder: CLGeocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
    
    private func geocode(address: String?) {
        guard let address = address else {
            locations = []
            tableView.reloadData()
            return
        }
        
        geocoder.geocodeAddressString(address) {
            [weak self] (placemarks, error) in
            DispatchQueue.main.async {
                self?.processResponse(with: placemarks, error: error)
            }
        }
    }
    
    private func processResponse(
        with placemarks: [CLPlacemark]?,
        error: Error?) {
        
        if let error = error {
            print("Cannot handle Geocode Address! \(error)")
        }
        else if let results = placemarks {
            locations = results.compactMap({ (result) -> Location? in
                guard let name = result.name else { return nil }
                guard let location = result.location else { return nil }
                
                return Location(name: name,
                                latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude)
            })
            
            tableView.reloadData()
        }
    }
}

extension AddLocationViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell  else {
            fatalError("Unexpected table view cell")
        }
        
        let location = locations[indexPath.row]
        let vm = LocationsViewModel(location: location.location,
                                    locationText: location.name)
        cell.configure(with: vm)
        return cell
    }
}

extension AddLocationViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        delegate?.controller(self, didAddLocation: location)
        navigationController?.popViewController(animated: true)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        geocode(address: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        locations = []
        tableView.reloadData()
    }
}

