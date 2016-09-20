//
//  KarumiHQsSpec.swift
//  MaxibonKataIOS
//
//  Created by Pedro Vicente Gomez on 29/06/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class KarumiHQsSpec: XCTestCase {

    func testKarumiHQsStartsTheWeekWithTenMaxibons() {
        XCTAssertEqual(10, KarumiHQs().maxibonsLeft)
    }

    func testAll() {

        property("The number of maxibons left can not be lower than two")
            <- forAll { (developer: Developer) in
            let karumiHQs = KarumiHQs()
            karumiHQs.openFridge(developer)
            return karumiHQs.maxibonsLeft > 2
        }

        property("If there are two or less maxibons pending after opening the fridge Karumi automatically buys 10 more")
            <- forAll(Developer.arbitraryHungry) { (developer: Developer) in
                let karumiHQs = KarumiHQs()
                let initialMaxibons = karumiHQs.maxibonsLeft
                let numOfMaxibons = developer.numberOfMaxibonsToGet
                let expectedMaxibons = self.maxibonsAfterOpeningTheFridge(initialMaxibons, numOfMaxibons)
                karumiHQs.openFridge(developer)
                return karumiHQs.maxibonsLeft == expectedMaxibons
        }

        property("If there are two or less maxibons after opening the fridge the developer sends a message to buy more")
            <- forAll(Developer.arbitraryHungry) { (developer: Developer) in
                let chat = MockChat()
                let karumiHQs = KarumiHQs(chat: chat)
                karumiHQs.openFridge(developer)
                let expectedResult = chat.messageSent == "Hi guys, I'm \(developer). We need more maxibons!"
                chat.messageSent = nil
                return expectedResult

        }

        property("If there are more than two maxibons after opening the fridge the developer does not send any message")
            <- forAll(Developer.arbitraryNotSoHungry) { (developer: Developer) in
                let chat = MockChat()
                let karumiHQs = KarumiHQs(chat: chat)
                karumiHQs.openFridge(developer)
                let expectedResult = chat.messageSent == nil
                chat.messageSent = nil
                return expectedResult
        }

        property("If some Karumies go to the kitchen the number of maxibons left can't be lower than 2")
            <- forAll { (developers: ArrayOf<Developer>) in
                let karumiHQs = KarumiHQs()
                karumiHQs.openFridge(developers.getArray)
                return karumiHQs.maxibonsLeft > 2
        }

        property("If some Karumies go to the kitchen the number of maxibons left has to be correct")
            <- forAll { (developers: ArrayOf<Developer>) in
                let karumiHQs = KarumiHQs()
                let initialMaxibons = karumiHQs.maxibonsLeft
                let karumies = developers.getArray
                karumiHQs.openFridge(karumies)
                let expectedMaxibons = self.calculateMaxibonsLeft(initialMaxibons, developers: karumies)
                return karumiHQs.maxibonsLeft == expectedMaxibons
        }

    }

    fileprivate func calculateMaxibonsLeft(_ initialMaxibons: Int, developers: [Developer]) -> Int {
        var maxibonsLeft = initialMaxibons
        developers.forEach { developer in
            maxibonsLeft -= developer.numberOfMaxibonsToGet
            if maxibonsLeft < 0 {
                maxibonsLeft = 0
            }
            if maxibonsLeft <= 2 {
                maxibonsLeft += 10
            }
        }
        return maxibonsLeft
    }

    fileprivate func maxibonsAfterOpeningTheFridge(_ initialMaxibons: Int, _ maxibonsToGet: Int) -> Int {
        var expectedMaxibons = initialMaxibons - maxibonsToGet
        if expectedMaxibons < 0 {
            expectedMaxibons = 0
        }
        expectedMaxibons += 10
        return expectedMaxibons
    }

}
