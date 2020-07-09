//
//  MenuViewController.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation
import UIKit

final class MenuViewController: UIViewController {

    @IBAction func disconnectBtnDidTap(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
