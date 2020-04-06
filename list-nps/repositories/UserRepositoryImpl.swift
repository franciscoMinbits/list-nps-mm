//
//  UserRepositoryImpl.swift
//  nps
//
//  Created by Ascenzo on 01/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation
import RealmSwift
class UserRepositoryImpl: UserRepositoryProtocol {
  func loadNPSData(id: Int) -> NPSData? {
     let realm = try! Realm()
    let result = realm.objects(NPSData.self).sorted(byKeyPath: "id", ascending: true).filter("id = \(id)").first
    return result
  }
  
  

  func loadNPSData() -> [NPSData] {
    let realm = try! Realm()
    let results: Results<NPSData> = realm.objects(NPSData.self).sorted(byKeyPath: "id", ascending: true)
    return Array(results)
  }
  
  
  func saveNPSData(data: [NPSData],completionHandler: @escaping (_ success:Bool, _ data:[NPSData]) -> Void) {
 
       let realm = try! Realm()
      try! realm.write {
         realm.add(data[0...50],update: .modified)
        let items = self.loadNPSData()
        completionHandler(true,items)
      }
    
  }
}
