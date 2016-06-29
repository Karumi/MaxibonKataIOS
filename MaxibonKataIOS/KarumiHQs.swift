//
//  KarumiHQs.swift
//  MaxibonKata
//
//  Created by Pedro Vicente Gomez on 29/06/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation

public final class KarumiHQs {

    private let slack: Slack

    var maxibonsLeft: Int

    private var shouldBuyMoreMaxibons: Bool {
        return maxibonsLeft <= 2
    }

    public init(slack: Slack) {
        self.maxibonsLeft = 10
        self.slack = slack
    }

    public convenience init() {
        self.init(slack: ConsoleSlack())
    }

    public func openFridge(developer: Developer) {
        grabMaxibons(developer)
        if shouldBuyMoreMaxibons {
            notifyWeShouldByMaxibons(developer)
            buyMoreMaxibons()
        }
    }

    private func notifyWeShouldByMaxibons(developer: Developer) {
        let message = "Hi guys, I'm \(developer). We need more maxibons!"
        slack.sendMessage(message)
    }

    private func buyMoreMaxibons() {
        maxibonsLeft += 10
    }

    private func grabMaxibons(developer: Developer) {
        maxibonsLeft -= developer.numberOfMaxibonsToGet
        if maxibonsLeft < 0 {
            maxibonsLeft = 0
        }
    }
}