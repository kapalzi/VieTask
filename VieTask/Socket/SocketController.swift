//
//  SocketController.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation
import Socket

typealias voidSuccessCompletion = ((Result<Void, Error>)->Void)
typealias stringSuccessCompletion = ((Result<String, Error>)->Void)

class SocketController {
    
    static let shared = SocketController()
    private var configuration = Configuration(ipAddress: "", port: "")
    private var socket: Socket!
    
    func setConfiguaration(_ configuration: Configuration) {
        
        self.configuration = configuration
    }
    
    func connect(completion: @escaping voidSuccessCompletion) {
        
        do {
            
            let signature = try Socket.Signature(protocolFamily: .inet, socketType: .stream, proto: .tcp, hostname: configuration.ipAddress, port: Int32(configuration.port))!
            
            self.socket = try Socket.create()
            
            try self.socket.connect(using: signature)
            try setTimeouts(value: 10000)
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
            
        } catch let error {
            DispatchQueue.main.async {
                completion(.failure(error as? Socket.Error ?? error))
            }
        }
    }
    
    func disconnect() {
        
        self.socket?.close()
        print("Disconnected")
    }
    
    func sendMessage(_ message: String, completion: @escaping stringSuccessCompletion) {

        sendRequest(withSocketFrameType: .write, andWithMessage: message, completion: completion)
    }
    
    func readMessage(completion: @escaping stringSuccessCompletion) {
        
        sendRequest(withSocketFrameType: .read) { (result) in
            switch result {
            case .success( _):
                    self.readResponse(forResponseType: .read, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    private func sendRequest(withSocketFrameType type: SocketFrame.SocketFrameType, andWithMessage message: String = "", completion: @escaping stringSuccessCompletion) {
        
        let socketFrame = SocketFrame(category: .request, type: type, message: message)
        
        do {
            try socket.write(from: socketFrame.frame)
            readResponse(forResponseType: .write, completion: completion)
        } catch let error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
    
    private func readResponse(forResponseType type: SocketFrame.SocketFrameType, completion: @escaping stringSuccessCompletion) {
        
        var data = Data()
        data.count = 0
        
        do {
            
            let bytes = try socket.read(into: &data)
            
            if bytes > 0 {
                
                let responseFactory = ResponseSocketFrameFactory(responseType: type)
                
                switch responseFactory.createFromFrame(data) {
                case .success(let socketFrame):
                    DispatchQueue.main.async {
                        completion(.success(socketFrame.message))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(SocketFrameError.emptyFrame))
                }
            }
            
        } catch let error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
    
    private func setTimeouts(value: UInt) throws {
        
        try socket.setReadTimeout(value: value)
        try socket.setWriteTimeout(value: value)
    }
}


