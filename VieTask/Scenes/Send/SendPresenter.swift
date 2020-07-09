//
//  SendPresenter.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

class SendPresenter {
    
    func sendMessage(_ message: String, completion: @escaping stringSuccessCompletion) {
        
        DispatchQueue.global().async {
            SocketController.shared.sendMessage(message, completion: completion)
        }
    }
}
