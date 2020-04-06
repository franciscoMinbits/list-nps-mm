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
    let result = database.objects(NPSData.self).sorted(byKeyPath: "id", ascending: true).first
    return result
  }
  
  
  lazy var database:Realm = {
    return try! Realm()
  }()
  
  func loadNPSData() -> [NPSData] {
    let results: Results<NPSData> = database.objects(NPSData.self).sorted(byKeyPath: "id", ascending: true)
    return Array(results)
  }
  
  
  func saveNPSData(data: [NPSData],completionHandler: @escaping (_ success:Bool, _ data:[NPSData]) -> Void) {
    let backgroundQueue = DispatchQueue(label: ".realm", qos: .background)
    backgroundQueue.async {
      try! self.database.write {
        self.database.add(data,update: .modified)
        let versions = self.loadNPSData()
        completionHandler(true,versions)
      }
    }
  }
  
}
