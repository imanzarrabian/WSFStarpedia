//
//  Planet.swift
//  StarPedia
//
//  Created by Louis Paicheur on 17/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import Foundation
import RealmSwift

class Planet: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var name: String = ""
    @objc dynamic var rotation_period: String = ""
    @objc dynamic var orbital_period: String = ""
    @objc dynamic var diameter: String = ""
    @objc dynamic var pictureURL: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
