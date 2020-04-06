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
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureBinding()
  }
  
  
}


extension ViewController {
  
  func configureUI() {
    self.title = "PHOTO ALBUM"
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowleft"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
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
    
    /*
     npsViewModel.npsData
     .asObservable()
     .bind { selectedScore in
     if let selectedScore = selectedScore{
     self.freemiumUsersLabel.text = "\(selectedScore.freemiumUsers)"
     self.preemiumUsersLabel.text = "\(selectedScore.premiumUsers)"
     if selectedScore.HighActPerc > 0 {
     var percentText = "\(Int(selectedScore.HighActPerc))%"
     if selectedScore.HighActPerc < 1 {
     percentText = String(format: "%.2f%", selectedScore.HighActPerc)
     }
     let activityText = "\(selectedScore.MaxAct) activities"
     let text = "\(percentText) of the users that answered \(self.indexSelected) in their NPS score saw \(activityText)"
     let range = (text as NSString).range(of: percentText)
     let rangeActivity = (text as NSString).range(of: activityText)
     let attributedString = NSMutableAttributedString(string:text)
     attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.baseColorB() , range: range)
     attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.baseColorF() , range: rangeActivity)
     self.activityLabel.attributedText = attributedString
     } else {
     self.activityLabel.text = ""
     }
     }
     }.disposed(by: disposeBag)
     */
    
    npsViewModel.npsData.asObservable()
      .bind(to: collectionView.rx.items(cellIdentifier: "ListCollectionViewCell", cellType: ListCollectionViewCell.self)) { index, item, cell in
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
        
        
      }).disposed(by: disposeBag)
  }
  
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.view.frame.width - 3 ) / 3 , height: (self.view.frame.width - 3 ) / 3)
  }
}
