//
//  PlanetDetailedController.swift
//  StarPedia
//
//  Created by Théo DUGAUTIER on 22/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit

class PlanetDetailedViewController: UIViewController {
    
    @IBOutlet weak var diameterLabel: UILabel!
    var planet: Planet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = planet.name
        
        diameterLabel.text = planet.diameter + " Km"
    }
}
