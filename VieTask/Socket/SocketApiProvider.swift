//
//  SocketApiProvider.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

protocol SocketApiProvider {
    
    func setConfiguaration(_ configuration: Configuration)
    
    func connect(completion: @escaping voidSuccessCompletion)
    
    func disconnect()
    
    func sendMessage(_ message: String, completion: @escaping stringSuccessCompletion)
    
    func readMessage(completion: @escaping stringSuccessCompletion)
}
