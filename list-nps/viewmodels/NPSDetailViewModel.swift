//
//  NPSDetailViewModel.swift
//  nps
//
//  Created by Ascenzo on 06/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class NPSDetailViewModel {
  private let locator: BaseUseCaseLocatorProtocol
  var searchValue = BehaviorRelay<String?>(value: nil)
  var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)
  var isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
  var selectedScore: BehaviorRelay<NPSData?> = BehaviorRelay(value: nil)
  
  init( locator: BaseUseCaseLocatorProtocol) {
    self.locator = locator
 
  }
  
  
  func onSelectedItem(index: Int){
    self.isLoading.accept(true)
    if let npsDetailUseCase = locator.getUseCase(ofType: NPSDetailUseCaseProtocol.self)  {
      isLoading.accept(true)
      npsDetailUseCase.loadNPSData( id:index ){ success , data  in
        DispatchQueue.main.sync {
          self.isLoading.accept(false)
              self.selectedScore.accept(data)
        }
      }
    }
  }
}
