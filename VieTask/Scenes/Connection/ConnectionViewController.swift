//
//  ConnectionViewController.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import UIKit

final class ConnectionViewController: BaseViewController {

    private let presenter: ConnectionPresenter = ConnectionPresenter(api: SocketController.shared)
    @IBOutlet var ipAddressTextField: UITextField!
    @IBOutlet var portTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.disconnect()
    }

    @IBAction func connectBtnDidTap(_ sender: UIButton) {
        
        let activityView = ActivityViewController.showActivity(inView: self.view)
        
        presenter.connect(withIpAddress: ipAddressTextField.text!, andWithPort: portTextField.text!) { [unowned self] (result) in
            activityView.hide(forView: self.view)
            switch result {
            case .success:
                self.goToMenu()
            case .failure(let error):
                self.showAlertWithError(error)
            }
        }
    }
    
    private func goToMenu() {
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let vc = storyboard.instantiateViewController(identifier: String(describing: MenuViewController.self)) as! MenuViewController
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        
        self.present(navController, animated: true, completion: nil)
    }
}

