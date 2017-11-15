//
//  Planet.swift
//  StarPedia
//
//  Created by Nina Queuche on 15/11/2017.
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
    @objc dynamic var climate: String = ""
    @objc dynamic var population: String = ""
    @objc dynamic var pictureURL: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
