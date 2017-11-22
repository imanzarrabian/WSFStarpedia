//
//  planet.swift
//  StarPedia
//
//  Created by Théo DUGAUTIER on 15/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import Foundation
import RealmSwift

class Planet: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var diameter: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
