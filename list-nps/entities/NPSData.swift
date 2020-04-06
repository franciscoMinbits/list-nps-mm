//
//  NPSData.swift
//  nps
//
//  Created by Ascenzo on 01/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class NPSData: Object, Mappable {
  required convenience init?(map _: Map) {
    self.init()
  }
  
  @objc dynamic var id = 0
  @objc dynamic var title = ""
  @objc dynamic var url = ""
  @objc dynamic var thumbnailUrl = ""

  
  
  func mapping(map: Map) {
    id <- map["id"]
    title <- map["title"]
    url <- map["url"]
    thumbnailUrl <- map["thumbnailUrl"]
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
