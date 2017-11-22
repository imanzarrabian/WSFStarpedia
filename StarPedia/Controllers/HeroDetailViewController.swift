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
    
    @IBAction func planetToggleButton(_ sender: Any) {
        getPlanet(url: people.homeWorld)
    }
    
    var people: People!
    var planet = Planet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = people.name
        
        // Hide labels for planet
        planetNameLabel.isHidden = true
        planetRotationPeriodLabel.isHidden = true
        planetOrbitalPeriodLabel.isHidden = true
        planetDiameterLabel.isHidden = true
        
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
        self.planetNameLabel.text = self.planet.name
        self.planetNameLabel.isHidden = false
        
        self.planetRotationPeriodLabel.text = self.planet.rotation_period + " days"
        self.planetRotationPeriodLabel.isHidden = false
        
        self.planetOrbitalPeriodLabel.text = self.planet.orbital_period + " hours"
        self.planetOrbitalPeriodLabel.isHidden = false
        
        self.planetDiameterLabel.text = self.planet.diameter + " kilometres"
        self.planetDiameterLabel.isHidden = false
    }
}
