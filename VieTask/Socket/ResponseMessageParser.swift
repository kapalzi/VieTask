//
//  ResponseMessageParser.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

struct ResponseMessageParser {
    
    let responseType: SocketFrame.SocketFrameType
    
    func messageFromFrame(_ frame: Data) -> Result<String, SocketFrameError> {
        
        guard let text = String(bytes: frame, encoding: .ascii) else { return .failure(.invalidFrame) }
        
        switch (isFrameCategoryCorrect(fromTextFrame: text), isFrameTypeCorrect(fromTextFrame: text)) {
        case (true, true):
            let message = String(text.dropFirst(2))
            let socketFrame = SocketFrame(category: .response, type: .read, message: message)
            return .success(socketFrame.message)
        case (false, true):
            return .failure(.invalidCategory)
        case (true, false):
            return .failure(.invalidType)
        case (false, false):
            return .failure(.invalidFrame)
        }
    }
    
    private func isFrameCategoryCorrect(fromTextFrame text: String) -> Bool {
        
        guard let category = text.first else { return false }
        
        if category.asciiValue != SocketFrame.SocketFrameCategory.response.rawValue {
            return false
        }
        return true
    }
    
    private func isFrameTypeCorrect(fromTextFrame text: String) -> Bool {
        
        guard let type = text.dropFirst().first else { return false }
        
        switch responseType {
        case .read:
            if type.asciiValue == SocketFrame.SocketFrameType.read.rawValue {
                return true
            } else {
                return false
            }
        case .write:
            if type.asciiValue == SocketFrame.SocketFrameType.write.rawValue {
                return true
            } else {
                return false
            }
        case .error:
            return false
        }
    }
}
