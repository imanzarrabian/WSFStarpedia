//
//  People.swift
//  StarPedia
//
//  Created by Iman Zarrabian on 19/10/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import Foundation
import RealmSwift

class People: Object {
    @objc dynamic var id: Int = 0

    @objc dynamic var name: String = ""
    @objc dynamic var mass: String = ""
    @objc dynamic var height: String = ""
    
    //v2
    @objc dynamic var pictureURL: String?
    @objc dynamic var homeWorld: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
