//
//  ReadPresenterTest.swift
//  VieTaskTests
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Quick
import Nimble

@testable import VieTask

class ReadPresenterTest: QuickSpec {
    
    override func spec() {
        
        var sut: ReadPresenter!
        
        describe("Read Presenter") {
            context("Reading from socket") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    sut = ReadPresenter(api: MockSocketApi.shared)
                }
                it("can read to socket") {
                    waitUntil { (done) in
                        
                        sut.readMessage { (result) in
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

