//
//  HeroDetailViewController.swift
//  StarPedia
//
//  Created by Iman Zarrabian on 20/10/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Kingfisher

class PlanetDetailViewController: UIViewController {
    
    var planet: Planet!
    
    @IBOutlet weak var rotationLabel: UILabel!
    @IBOutlet weak var orbitalLabel: UILabel!
    @IBOutlet weak var avatarIV: UIImageView!
    @IBOutlet weak var climatLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = planet.name
        
        rotationLabel.text = planet.rotation + " hours"
        orbitalLabel.text = planet.orbital + " days"
        climatLabel.text = planet.climate
        diameterLabel.text = planet.diameter + " km"
        populationLabel.text = planet.population + " inhabitants"
        
        let url = URL(string: planet.pictureURL!)
        avatarIV.kf.setImage(with: url)
    }
}

