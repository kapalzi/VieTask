//
//  ActivityViewController.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation
import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!

    class func showActivity(inView view: UIView) -> ActivityViewController {
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let vc = storyboard.instantiateViewController(identifier: String(describing: ActivityViewController.self)) as! ActivityViewController
        vc.setup(forView: view)
        view.addSubview(vc.view)
        view.isUserInteractionEnabled = false
        return vc
    }
    
    func setup(forView view:UIView) {
        
        self.view.frame = view.bounds
        self.indicatorView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hide(forView view:UIView) {
        
        self.indicatorView.stopAnimating()
        self.view.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
    
    
    
    
}
