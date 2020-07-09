//
//  SendPresenterTest.swift
//  VieTaskTests
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Quick
import Nimble

@testable import VieTask

class SendPresenterTest: QuickSpec {
    
    override func spec() {
        
        var sut: SendPresenter!
        
        describe("Send Presenter") {
            context("Sending to socket") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    sut = SendPresenter(api: MockSocketApi.shared)
                }
                it("can send to socket") {
                    waitUntil { (done) in
                        sut.sendMessage("a") { (result) in
                            done()
                            switch result {
                            case .success(let msg):
                                expect(msg).to(equal("Success"))
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
