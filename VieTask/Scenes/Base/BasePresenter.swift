//
//  BasePresenter.swift
//  VieTask
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Foundation

class BasePresenter<ApiProvider> {
    
    let api: ApiProvider
    
    init(api: ApiProvider) {
        
        self.api = api
    }
}
