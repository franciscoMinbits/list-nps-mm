//
//  BaseUseCaseLocatorProtocol.swift
//  nps
//
//  Created by Ascenzo on 02/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation

protocol BaseUseCaseLocatorProtocol {
    func getUseCase<T>(ofType type: T.Type) -> T?
}
