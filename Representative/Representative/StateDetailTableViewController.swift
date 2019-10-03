//
//  StateDetailTableViewController.swift
//  Representative
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {
    // MARK: - Global Variables
    // Source of truth
    var representatives: [Representative] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // Receiver
    var state: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = state
        if let state = state {
            RepresentativeController.searchRepresentatives(by: state) { (representativeArray) in
                self.representatives = representativeArray
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "representativeCell", for: indexPath) as? RepresentativeTableViewCell
            // Initialized
            else { return UITableViewCell() }
        let representative = representatives[indexPath.row]
        cell.representative = representative
        return cell
    }
}
