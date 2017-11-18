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
    
    var planet: Planet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = planet.name

        let url = URL(string: planet.pictureURL)
                pictureIV.kf.setImage(with: url)
    }
}
