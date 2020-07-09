//
//  MockSocketApi.swift
//  VieTaskTests
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation
@testable import VieTask

class MockSocketApi: SocketApiProvider {
    
    static let shared = MockSocketApi()
    
    func setConfiguaration(_ configuration: Configuration) {
        return
    }
    
    func connect(completion: @escaping voidSuccessCompletion) {
        
        DispatchQueue.main.async {
            completion(.success(()))
        }
    }
    
    func disconnect() {
        
        return
    }
    
    func sendMessage(_ message: String, completion: @escaping stringSuccessCompletion) {
        
        DispatchQueue.main.async {
            completion(.success("Success"))
        }
    }
    
    func readMessage(completion: @escaping stringSuccessCompletion) {
        
        DispatchQueue.main.async {
            completion(.success("Success"))
        }
    }
}
