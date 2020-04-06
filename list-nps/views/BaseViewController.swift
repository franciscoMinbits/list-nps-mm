//
//  BaseViewController.swift
//  nps
//
//  Created by Ascenzo on 02/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
class BaseViewController: UIViewController {
    private(set) var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
