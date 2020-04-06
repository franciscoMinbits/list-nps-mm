//
//  BaseUseCaseLocator.swift
//  nps
//
//  Created by Ascenzo on 02/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation

class BaseUseCaseLocatorImpl : BaseUseCaseLocatorProtocol {
  static let defaultLocator = BaseUseCaseLocatorImpl(repository: UserRepositoryImpl(),
                                                     service: ServiceImpl())
  fileprivate let repository: UserRepositoryProtocol
  fileprivate let service: ServiceProtocol
  init(repository: UserRepositoryProtocol, service: ServiceProtocol) {
    self.repository = repository
    self.service = service
  }
  
  func getUseCase<T>(ofType type: T.Type) -> T? {
    switch String(describing: type) {
    case String(describing: NPSUseCaseProtocol.self):
      return buildUseCase(type: NPSUseCaseImpl.self)
    case String(describing: NPSDetailUseCaseProtocol.self):
      return buildUseCase(type: NPSDetailUseCaseImpl.self)
    default:
      return nil
    }
  }
}

private extension BaseUseCaseLocatorImpl {
  func buildUseCase<U: BaseUseCaseImpl, R>(type: U.Type) -> R? {
    return U(repository: repository, service: service) as? R
  }
}

class BaseUseCaseImpl {
  let repository: UserRepositoryProtocol
  let service: ServiceProtocol
  required init(repository: UserRepositoryProtocol,service: ServiceProtocol) {
    self.repository = repository
    self.service = service
  }
}
