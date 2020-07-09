//
//  SendPresenter.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

final class SendPresenter: BasePresenter<SocketApiProvider> {

    func sendMessage(_ message: String, completion: @escaping stringSuccessCompletion) {
        
        DispatchQueue.global().async {
            self.api.sendMessage(message, completion: completion)
        }
    }
}
