//
//  CustomViews.swift
//  nps
//
//  Created by Ascenzo on 05/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation
import UIKit

public class CustomViews: NSObject {
  static let sharedInstance = CustomViews()
  var loadingView: LoadingView?
  override init() {
    super.init()
    loadingView = LoadingView.instantiateFromNib()
    
  }
  
  func showLoading() {
    if let topView = UIApplication.topViewController()?.view {
      DispatchQueue.main.async {
        self.loadingView?.dismiss()
        self.loadingView?.show(onView: topView)
      }
    }
  }
  
  func dismissLoading() {
    DispatchQueue.main.async {
      self.loadingView?.dismiss()
    }
  }
}


extension UIView {
  public class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
    return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
  }
  
  public class func instantiateFromNib() -> Self {
    return instantiateFromNib(viewType: self)
  }
  
}
