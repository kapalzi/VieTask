//
//  ConnectionPresenterTest.swift
//  VieTaskTests
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Quick
import Nimble

@testable import VieTask

class ConnectionPresenterTest: QuickSpec {
    
    override func spec() {
        
        var sut: ConnectionPresenter!
        
        describe("Connenction Presenter") {
            context("Connecting to socket") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    sut = ConnectionPresenter(api: MockSocketApi.shared)
                }
                it("can connect to socket") {
                    waitUntil { (done) in
                        sut.connect(withIpAddress: "", andWithPort: "") { (result) in
                            switch result {
                            case .success(_):
                                done()
                            case .failure(_):
                                fail()
                            }
                        }
                    }
                }
            }
        }
    }
}
