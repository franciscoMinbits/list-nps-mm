//
//  NPSDetailUseCaseImpl.swift
//  nps
//
//  Created by Ascenzo on 06/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation

class NPSDetailUseCaseImpl: BaseUseCaseImpl, NPSDetailUseCaseProtocol {
  func loadNPSData(id: Int, completionHandler: @escaping (Bool, NPSData?) -> Void) {
   let item =  repository.loadNPSData(id: id)
    completionHandler(true, item)
  }
}
