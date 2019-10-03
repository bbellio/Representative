//
//  RepresentativeTableViewCell.swift
//  Representative
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class RepresentativeTableViewCell: UITableViewCell {
    // MARK: - Global Variables
    // Source of truth
    var representative: Representative? {
        didSet {
            updateViews()
        }
    }
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    func updateViews() {
        guard let representative = representative else { return }
        nameLabel.text = representative.name
        partyLabel.text = representative.party
        districtLabel.text = representative.district
        websiteLabel.text = representative.link
        phoneNumberLabel.text = representative.phone
    }
}
