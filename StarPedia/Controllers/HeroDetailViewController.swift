//
//  HeroDetailViewController.swift
//  StarPedia
//
//  Created by Iman Zarrabian on 20/10/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Kingfisher

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    @IBOutlet weak var homeWorldLabel: UILabel!
    
    @IBOutlet weak var avatarIV: UIImageView!
    
    var people: People!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = people.name
        
        massLabel.text = people.mass + " Kg"
        heightLabel.text = people.height + " Cm"
        homeWorldLabel.text = people.homeWorld
        
        let url = URL(string: people.pictureURL!)
        avatarIV.kf.setImage(with: url)
    }
}
