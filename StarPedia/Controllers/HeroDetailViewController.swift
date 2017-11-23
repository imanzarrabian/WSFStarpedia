//
//  HeroDetailViewController.swift
//  StarPedia
//
//  Created by Iman Zarrabian on 20/10/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    @IBOutlet weak var avatarIV: UIImageView!
    
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetRotationPeriodLabel: UILabel!
    @IBOutlet weak var planetOrbitalPeriodLabel: UILabel!
    @IBOutlet weak var planetDiameterLabel: UILabel!
    
    @IBOutlet weak var togglePlanetButton: UIButton!
    
    @IBAction func togglePlanet(_ sender: Any) {
        togglePlanetButton.alpha = 0.3
        togglePlanetButton.isEnabled = false
        togglePlanetButton.setTitle("Loading...", for: .normal)
        
        getPlanet(url: people.homeWorld)
    }
    
    @IBOutlet weak var planetView: UIView!
    
    
    var people: People!
    var planet = Planet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bords arrondis pour le boutton planète
        togglePlanetButton.layer.cornerRadius = 4
        
        title = people.name
        
        massLabel.text = people.mass + " Kg"
        heightLabel.text = people.height + " Cm"
        
        let url = URL(string: people.pictureURL!)
        avatarIV.kf.setImage(with: url)
    }
    
    func getPlanet(url: String) {
        Alamofire.request(url).responseJSON { (response) in

            if let jsonValue = response.result.value { // recupere le json à la racine
                
                let jsonObject = jsonValue as! [String: Any] // je tranforme ce json à la racine en un objet clef (String) et valeur (Any)

                let name = jsonObject["name"] as! String
                let rotation_period = jsonObject["rotation_period"] as! String
                let orbital_period = jsonObject["orbital_period"] as! String
                let diameter = jsonObject["diameter"] as! String
                
                self.planet.name = name
                self.planet.rotation_period = rotation_period
                self.planet.orbital_period = orbital_period
                self.planet.diameter = diameter
                
                self.populateView()
            }
        }
    }
    
    func populateView() {
        togglePlanetButton.setTitle("Loaded", for: .normal)

        // Affiche le view controller pour la planète
        self.planetView.isHidden = false
        
        self.planetNameLabel.text = self.planet.name
        self.planetRotationPeriodLabel.text = self.planet.rotation_period + " days"
        self.planetOrbitalPeriodLabel.text = self.planet.orbital_period + " hours"
        self.planetDiameterLabel.text = self.planet.diameter + " kilometres"
    }
}
