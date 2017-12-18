//
//  PlanetDetailViewController.swift
//  StarPedia
//
//  Created by Thibault Weiser on 23/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import Foundation
import Kingfisher

class PlanetDetailViewController: UIViewController {
    
    @IBOutlet weak var ImageDescription: UIImageView!
    
    @IBOutlet weak var DiameterLabel: UILabel!
    @IBOutlet weak var PopulationLabel: UILabel!
    
    var planets: Planets!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = planets.name
        
        DiameterLabel.text = planets.diameter
        PopulationLabel.text = planets.population
        
        let url = URL(string: planets.pictureURL!)
        ImageDescription.kf.setImage(with: url)
    }
    
}
