//
//  ResponseMessageParserTest.swift
//  VieTaskTests
//
//  Created by Krzysztof Kapała on 09/07/2020.
//  Copyright © 2020 kapala. All rights reserved.
//

import Quick
import Nimble

@testable import VieTask

class ResponseMessageParserTest: QuickSpec {
    
    override func spec() {
        
        var sut: ResponseMessageParser!
        
        describe("Response Message Parser") {
            context("Reading message from socket read response") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    sut = ResponseMessageParser(responseType: .read)
                }
                it("can read proper response") {
                    
                    let data = Data([0x2, 0x4, 0x74, 0x72, 0x75, 0x65])
                    
                    switch sut.messageFromFrame(data) {
                    case .success(let message):
                        expect(message).to(equal("true"))
                    case .failure(_):
                        fail()
                    }
                }
                it("can give error for invalid category") {
                    
                    let data = Data([0x1, 0x4, 0x74, 0x72, 0x75, 0x65])
                    
                    switch sut.messageFromFrame(data) {
                    case .success(_):
                        fail()
                    case .failure(let error):
                        expect(error).to(equal(.invalidCategory))
                    }
                }
                it("can give error for invalid type") {
                    
                    let data = Data([0x2, 0x3, 0x74, 0x72, 0x75, 0x65])
                    
                    switch sut.messageFromFrame(data) {
                    case .success(_):
                        fail()
                    case .failure(let error):
                        expect(error).to(equal(.invalidType))
                    }
                }
            }
            context("Reading message from socket write response") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    sut = ResponseMessageParser(responseType: .write)
                }
                it("can read proper response") {
                    
                    let data = Data([0x2, 0x3, 0x74, 0x72, 0x75, 0x65])
                    
                    switch sut.messageFromFrame(data) {
                    case .success(let message):
                        expect(message).to(equal("true"))
                    case .failure(_):
                        fail()
                    }
                }
                it("can give error for invalid category") {
                    
                    let data = Data([0x1, 0x3, 0x74, 0x72, 0x75, 0x65])
                    
                    switch sut.messageFromFrame(data) {
                    case .success(_):
                        fail()
                    case .failure(let error):
                        expect(error).to(equal(.invalidCategory))
                    }
                }
                it("can give error for invalid type") {
                    
                    let data = Data([0x2, 0x2, 0x74, 0x72, 0x75, 0x65])
                    
                    switch sut.messageFromFrame(data) {
                    case .success(_):
                        fail()
                    case .failure(let error):
                        expect(error).to(equal(.invalidType))
                    }
                }
            }
        }
    }
}
