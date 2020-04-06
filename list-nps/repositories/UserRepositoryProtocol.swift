//
//  UserRepositoryProtocol.swift
//  nps
//
//  Created by Ascenzo on 01/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation

protocol UserRepositoryProtocol {
  func saveNPSData(data: [NPSData], completionHandler: @escaping (_ success:Bool, _ data:[NPSData]) -> Void)
  func loadNPSData() -> [NPSData]
  func loadNPSData(id:Int) -> NPSData?
}
