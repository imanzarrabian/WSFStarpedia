//
//  Planet.swift
//  StarPedia
//
//  Created by Iman Zarrabian on 19/10/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import Foundation
import RealmSwift

class Planet: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var rotation: String = ""
    @objc dynamic var orbital: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var climate: String = ""
    @objc dynamic var diameter: String = ""
    @objc dynamic var population: String = ""
    
    //v2
    @objc dynamic var pictureURL: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

