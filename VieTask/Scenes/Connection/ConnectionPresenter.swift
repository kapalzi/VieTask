//
//  ConnectionPresenter.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

class ConnectionPresenter: BasePresenter<SocketApiProvider> {
    
    func connect(withIpAddress address: String, andWithPort port: String, completion: @escaping voidSuccessCompletion){
        
        DispatchQueue.global().async {
            let configuration = Configuration(ipAddress: address, port: port)
            self.api.setConfiguaration(configuration)
            self.api.connect(completion: completion)
        }
    }
    
    func disconnect() {
        
        api.disconnect()
    }
    
}
