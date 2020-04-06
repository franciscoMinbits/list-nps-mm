//
//  LoadingView.swift
//  Pik
//
//  Created by Gesfor on 16/01/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import Foundation
import Lottie
import UIKit

class LoadingView: UIView , LoadingProtocol{
  func showProgress(progress: Int) {
    DispatchQueue.main.async {
      if self.labelPercent != nil {
        self.labelPercent?.text = "\(progress)%"
      }
    }
  }
  
  static var delegate: LoadingProtocol? = nil
  @IBOutlet weak var labelPercent: UILabel!
  var witdthloadView: CGFloat = 200.0
  var view: UIView!
  fileprivate var lottieLogo: AnimationView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    lottieLogo = AnimationView(name: "animationlottie")
    lottieLogo.contentMode = .scaleAspectFit
    super.init(coder: aDecoder)
  }
  
  func show(onView _: UIView) {
    LoadingView.delegate = self
    let superView = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    let viewAlert = UIView()
    viewAlert.frame = UIScreen.main.bounds
    let shadowEffectView = shadowEffect()
    frame = getAlertFrameConfig()
    viewAlert.addSubview(shadowEffectView)
    viewAlert.addSubview(self)
    
    lottieLogo.frame = CGRect(
      x: (viewAlert.frame.size.width / 2) - (witdthloadView / 2),
      y: (viewAlert.frame.size.height / 2) - (witdthloadView / 2),
      width: witdthloadView,
      height: witdthloadView
    )
    
    
    viewAlert.addSubview(lottieLogo)
    lottieLogo.play()
    lottieLogo.loopMode = .loop
    superView?.addSubview(viewAlert)
  }
  
  func dismiss() {
    lottieLogo.stop()
    superview?.removeFromSuperview()
  }
  
  func blurEffect() -> UIView {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = UIScreen.main.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return blurEffectView
  }
  
  func shadowEffect() -> UIView {
    let shadowEffectView = UIView()
    shadowEffectView.backgroundColor = UIColor.black
    shadowEffectView.alpha = 0.8
    shadowEffectView.frame = UIScreen.main.bounds
    shadowEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return shadowEffectView
  }
  
  func getAlertFrameConfig() -> CGRect {
    let screenSize: CGRect = UIScreen.main.bounds
    return CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
  }
}


protocol LoadingProtocol {
  func showProgress(progress : Int)
}
