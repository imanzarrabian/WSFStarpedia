//
//  PlanetDetailViewController.swift
//  StarPedia
//
//  Created by Nina Queuche on 15/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//


import UIKit
import Kingfisher

class PlanetDetailViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var rotationPeriodLabel: UILabel!
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    
    var planet: Planet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = planet.name
    
        rotationPeriodLabel.text = planet.rotationPeriod + "days"
        orbitalPeriodLabel.text = planet.orbitalPeriod + " days"
        populationLabel.text = planet.population + " peoples"
        diameterLabel.text = planet.diameter
        climateLabel.text = planet.climate
        
        
        let url = URL(string: planet.pictureURL!)
        avatar.kf.setImage(with: url)
    }
}
