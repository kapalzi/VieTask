//
//  SocketErrorHelper.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation
import Socket

enum SocketFrameError: Error {
    
    case invalidFrame
    case invalidCategory
    case invalidType
    case emptyFrame
}

extension SocketFrameError {
    public var localizedDescription: String {
        switch self {
        case .invalidFrame:
            return "Frame is invalid"
        case .invalidCategory:
            return "Category field is invalid"
        case .invalidType:
            return "Type field is invalid"
        case .emptyFrame:
            return "Frame is empty"
        }
    }
}

struct SocketErrorHelper {
    
    static func getErrorDescriptionForError(_ error: Error) -> String {
        
        if let err = error as? Socket.Error {
            return err.description
        } else if let err = error as? SocketFrameError {
            return err.localizedDescription
        } else {
            return error.localizedDescription
        }
    }
}
