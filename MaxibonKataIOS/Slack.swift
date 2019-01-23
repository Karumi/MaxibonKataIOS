//
//  Slack.swift
//  MaxibonKataIOS
//
//  Created by Pedro Vicente Gomez on 29/06/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation

struct Slack: Chat {

    func send(message: String) {
        print("-------->" + message)
    }
}
