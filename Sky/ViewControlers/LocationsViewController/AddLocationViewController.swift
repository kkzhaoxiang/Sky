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
    
    var delegate: AddLocationViewControllerDelegate?
    
    var viewModel: AddLocationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddLocationViewModel()
        viewModel.locationDidChange = { [unowned self] locations in
            self.tableView.reloadData()
        }
        
        viewModel.queryingStatusDidChange = {
            [unowned self] isQuerying in
            if isQuerying {
                self.title = "Searching..."
            } else {
                self.title = "Add a location"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
}

extension AddLocationViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfLocations
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell  else {
            fatalError("Unexpected table view cell")
        }
        
        if let vm = viewModel.locationViewModel(at: indexPath.row) {
            cell.configure(with: vm)
        }
        return cell
    }
}

extension AddLocationViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let location = viewModel.location(at: indexPath.row) else {
            return
        }
        delegate?.controller(self, didAddLocation: location)
        navigationController?.popViewController(animated: true)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.queryText = searchBar.text ?? ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.queryText = searchBar.text ?? ""
    }
}

