//
//  MockChat.swift
//  MaxibonKataIOS
//
//  Created by Pedro Vicente Gomez on 29/06/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
@testable import MaxibonKataIOS

class MockChat
: Chat {

    var messageSent: String? = nil

    func sendMessage(message: String) {
        messageSent = message
    }
}