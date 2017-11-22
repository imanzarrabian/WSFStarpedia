//
//  PlanetDetailViewControllerViewController.swift
//  StarPedia
//
//  Created by Louis Paicheur on 17/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Kingfisher

class PlanetDetailViewController: UIViewController {
    
    @IBOutlet weak var pictureIV: UIImageView!
    @IBOutlet weak var rotationPeriodLabel: UILabel!
    @IBOutlet weak var orbitalPerdiodLabel: UILabel!
    
    var planet: Planet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = planet.name
        
        rotationPeriodLabel.text = planet.rotation_period + " days"
        orbitalPerdiodLabel.text = planet.orbital_period + " hours"

        let url = URL(string: planet.pictureURL)
                pictureIV.kf.setImage(with: url)
    }
}
