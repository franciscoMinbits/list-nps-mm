//
//  ViewController.swift
//  list-nps
//
//  Created by Ascenzo on 06/04/20.
//  Copyright © 2020 mm. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: BaseViewController {
  private let npsViewModel = NPSViewModel(locator: BaseUseCaseLocatorImpl.defaultLocator)
  @IBOutlet weak var collectionView: UICollectionView!
  var selectedItem = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureBinding()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let viewController = segue.destination as? ListDetailViewController {
      viewController.selectedItem = self.selectedItem
    }
  }
}


extension ViewController {
  
  func configureUI() {
    self.title = "PHOTO ALBUM"
   
    collectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
    
    
    npsViewModel.npsData.asObservable()
      .bind(to: collectionView.rx.items(cellIdentifier: "ListCollectionViewCell", cellType: ListCollectionViewCell.self)) { index, item, cell in
        cell.nameLabel.fadeTransition(0.5)
        cell.nameLabel.text = "\(item.title)"
        if let url = URL(string:  "\(item.thumbnailUrl)"){
          cell.photoImageView.kf.setImage(
            with: url)
        }
    }
    .disposed(by: self.disposeBag)
    
    collectionView
      .rx
      .itemSelected
      .subscribe(onNext:{ indexPath in
        self.selectedItem = self.npsViewModel.npsData.value[indexPath.row].id
        self.performSegue(withIdentifier: "showDetail", sender: nil)
      }).disposed(by: disposeBag)
  }
  
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.view.frame.width - 3 ) / 3 , height: (self.view.frame.width - 3 ) / 3)
  }
}
