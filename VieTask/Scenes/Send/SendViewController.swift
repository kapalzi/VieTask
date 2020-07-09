//
//  SendViewController.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class SendViewController: BaseViewController {
    
    var presenter: SendPresenter = SendPresenter(api: SocketController.shared)
    let disposeBag = DisposeBag()
    @IBOutlet var messageTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        limitTextView()
    }
    
    private func limitTextView() {
        messageTextView.rx.text.subscribe { [unowned self] in
            if let element = $0.element, let text = element {
                self.messageTextView.text = String(text.prefix(255))
            }
        }.disposed(by: disposeBag)
    }
    
    @IBAction func sendMessageBtnDidTap(_ sender: UIButton) {
        
        guard let message = messageTextView.text else { return }
        
        let activityView = ActivityViewController.showActivity(inView: self.view)
        
        presenter.sendMessage(message) { (result) in
            activityView.hide(forView: self.view)
            switch result {
            case .success(let message):
                self.showResponseAlert(withMessage: message)
            case .failure(let error):
                self.showAlertWithErrorAndDismiss(error)
            }
        }
    }
}
