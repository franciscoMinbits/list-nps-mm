//
//  NPSViewModel.swift
//  nps
//
//  Created by Ascenzo on 02/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class NPSViewModel {
  private let locator: BaseUseCaseLocatorProtocol
  var searchValue = BehaviorRelay<String?>(value: nil)
  var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)
  var isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
  private var npsData: BehaviorRelay<[NPSData]> =  BehaviorRelay(value: [])
  
  init( locator: BaseUseCaseLocatorProtocol) {
    self.locator = locator
    loadNPS()
  }
  
  func loadNPS(refresh: Bool  = false){
    if let npsUseCase = locator.getUseCase(ofType: NPSUseCaseProtocol.self)  {
      isLoading.accept(true)
      if refresh {
        npsData.accept([])
      }
      
      npsUseCase.loadNPS(){[weak self] result in
        self?.didFinish(result: result)
      }
    }
  }
  
  
}

extension NPSViewModel {
  private func didFinish(result: ServiceResponse) {
    isLoading.accept(false)
    switch result {
    case .successLoadNPS(let data):
      saveData(data: data)
      break
    case .failure:
      errorMessage.accept("Error el conectar")
      break
    case .timeOut:
      errorMessage.accept("Error el conectar")
    case .notConnectedToInternet:
      errorMessage.accept("Error el conectar")
    default:
      errorMessage.accept("Error el conectar")
    }
  }
  
  private func saveData(data: [NPSData]){
    if let npsUseCase = locator.getUseCase(ofType: NPSUseCaseProtocol.self) {
      npsUseCase.saveData(data: data){success, data in
        if success {
          DispatchQueue.main.sync {
            self.npsData.accept(data)
            
          }
          
        }
      }
    }
  }
}
