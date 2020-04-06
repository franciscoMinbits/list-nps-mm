//
//  RoundUIView.swift
//  nps
//
//  Created by Ascenzo on 02/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var showShadow: Bool = false {
        didSet {
            if showShadow {
                layer.shadowColor = UIColor.gray.cgColor
                layer.shadowOpacity = 0.5
                layer.shadowOffset =  CGSize(width: 0, height: 3)
                layer.shadowRadius = 5
            }
        }
    }
}
