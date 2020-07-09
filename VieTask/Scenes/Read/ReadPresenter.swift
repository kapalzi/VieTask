//
//  ReadPresenter.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 08/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

final class ReadPresenter: BasePresenter<SocketApiProvider> {
    
    func readMessage(completion: @escaping stringSuccessCompletion) {
        
        DispatchQueue.global().async {
            self.api.readMessage(completion: completion)
        }
    }
}
