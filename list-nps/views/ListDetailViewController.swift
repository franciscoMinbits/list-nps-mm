//
//  ListDetailViewController.swift
//  list-nps
//
//  Created by Ascenzo on 06/04/20.
//  Copyright © 2020 mm. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ListDetailViewController: BaseViewController {
  private let npsViewModel = NPSDetailViewModel(locator: BaseUseCaseLocatorImpl.defaultLocator)
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var numberImageLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  var selectedItem = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureBinding()
  }
  
  
}


extension ListDetailViewController {
  
  func configureUI() {
    self.title = "PHOTO DETAIL"
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowleft"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
  }
  
  func configureBinding() {
    
    npsViewModel.isLoading
      .asObservable()
      .bind { isLoading in
        if isLoading{
          CustomViews.sharedInstance.showLoading()
        } else {
          CustomViews.sharedInstance.dismissLoading()
        }
        
    }.disposed(by: disposeBag)
    
    npsViewModel.selectedItem
      .asObservable()
      .bind { selectedItem in
        if let  selectedItem = selectedItem{
          self.numberImageLabel.fadeTransition(2.0)
          self.descLabel.fadeTransition(2.0)
          self.descLabel.text = selectedItem.title
          self.numberImageLabel.text = "Image: \(selectedItem.id)"
          if let url = URL(string:  "\(selectedItem.url)"){
            self.photoImageView.kf.setImage(
              with: url)
          }
          
        }
    }.disposed(by: disposeBag)
    
    npsViewModel.onSelectedItem(index: selectedItem)
    
  }
  
}
