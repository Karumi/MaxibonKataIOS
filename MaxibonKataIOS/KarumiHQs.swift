//
//  KarumiHQs.swift
//  MaxibonKata
//
//  Created by Pedro Vicente Gomez on 29/06/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation

public final class KarumiHQs {

    private let chat: Chat

    var maxibonsLeft: Int

    private var shouldBuyMoreMaxibons: Bool {
        return maxibonsLeft <= 2
    }

    public init(chat: Chat) {
        self.maxibonsLeft = 10
        self.chat = chat
    }

    public convenience init() {
        self.init(chat: Slack())
    }

    public func openFridge(developer: Developer) {
        openFridge([developer])
    }

    public func openFridge(developers: [Developer]) {
        developers.forEach { developer in
            grabMaxibons(developer)
            if shouldBuyMoreMaxibons {
                notifyWeShouldBuyMaxibons(developer)
                buyMoreMaxibons()
            }
        }
    }

    private func notifyWeShouldBuyMaxibons(developer: Developer) {
        let message = "Hi guys, I'm \(developer). We need more maxibons!"
        chat.sendMessage(message)
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