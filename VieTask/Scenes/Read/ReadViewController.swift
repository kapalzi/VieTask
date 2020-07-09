//
//  ReadViewController.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation
import UIKit

class ReadViewController: BaseViewController {
    
    var presenter: ReadPresenter!
    @IBOutlet var messageTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.presenter = ReadPresenter()
    }
    
    @IBAction func receiveMessageBtnDidTap(_ sender: UIButton) {
        
        let activityView = ActivityViewController.showActivity(inView: self.view)
        
        presenter.readMessage { (result) in
            activityView.hide(forView: self.view)
            switch result {
            case .success(let message):
                self.messageTextView.text = message
            case .failure(let error):
                self.showAlertWithErrorAndDismiss(error)
            }
        }
    }
}
