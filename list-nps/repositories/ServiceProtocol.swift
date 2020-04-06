//
//  ServiceProtocol.swift
//  nps
//
//  Created by Ascenzo on 01/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation

enum ServiceResponse {
    case failure
    case timeOut
    case notConnectedToInternet
    case unauthorized
    case successLoadNPS(data: [NPSData])

 
}

protocol ServiceProtocol {
    func loadNPS(completion: @escaping (ServiceResponse) -> Void)
}
