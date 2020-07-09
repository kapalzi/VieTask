//
//  SocketFrame.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

struct SocketFrame {
    
    enum SocketFrameCategory: UInt8 {
        case request = 0x01
        case response = 0x02
    }
    
    enum SocketFrameType: UInt8 {
        case write = 0x03
        case read = 0x04
        case error = 0x05
    }
    
    private(set) var category: SocketFrameCategory
    private(set) var type: SocketFrameType
    private(set) var message: String
    var frame: Data {
        var frame: [UInt8] = [category.rawValue, type.rawValue]
        message.forEach {
            if let ascii = $0.asciiValue {
                frame.append(ascii)
            }
        }
        return Data(bytes: frame, count: frame.count)
    }
}
