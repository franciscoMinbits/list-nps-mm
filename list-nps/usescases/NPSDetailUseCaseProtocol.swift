//
//  NPSDetailUseCaseProtocol.swift
//  nps
//
//  Created by Ascenzo on 06/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation

protocol NPSDetailUseCaseProtocol {
  func loadNPSData(id:Int,completionHandler: @escaping (_ success:Bool, _ data:NPSData?) -> Void)

}
