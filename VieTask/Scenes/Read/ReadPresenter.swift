//
//  ReadPresenter.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

class ReadPresenter {
    
    func readMessage(completion: @escaping stringSuccessCompletion) {
        
        DispatchQueue.global().async {
            SocketController.shared.readMessage(completion: completion)
        }
    }
}
