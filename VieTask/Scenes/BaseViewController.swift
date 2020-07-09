//
//  BaseViewController.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    func showResponseAlert(withMessage message: String) {
        
        let ac = UIAlertController(title: "Server response", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    func showAlertWithErrorAndDismiss(_ error: Error) {
        
        showAlertWithError(error) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showAlertWithError(_ error: Error, completion: (()->()) = {}) {
        
        let message = SocketErrorHelper.getErrorDescriptionForError(error)
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(ac, animated: true, completion: nil)
    }
}
