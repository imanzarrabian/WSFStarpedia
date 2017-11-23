//
//  Planet.swift
//  StarPedia
//
//  Created by Thibault Weiser on 22/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import Foundation
import RealmSwift

class Planets: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var name: String = ""
    @objc dynamic var diameter: String = ""
    @objc dynamic var population: String = ""
    
    @objc dynamic var pictureURL: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
