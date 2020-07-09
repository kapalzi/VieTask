//
//  ConnectionPresenter.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

class ConnectionPresenter {
    
    func connect(withIpAddress address: String, andWithPort port: String, completion: @escaping voidSuccessCompletion){
        
        DispatchQueue.global().async {
            let configuration = Configuration(ipAddress: address, port: port)
            SocketController.shared.setConfiguaration(configuration)
            SocketController.shared.connect(completion: completion)
        }
    }
    
    func disconnect() {
        
        SocketController.shared.disconnect()
    }
    
}
