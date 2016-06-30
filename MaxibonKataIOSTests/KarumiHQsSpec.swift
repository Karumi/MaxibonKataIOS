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

    func testAll() {

        property("Karumi HQs starts every week with 10 maxibons") <- forAll { (karumiHQs: KarumiHQs) in
            return KarumiHQs().maxibonsLeft == 10
        }.once

        property("The number of maxibons left can not be negative")
            <- forAll { (karumiHQs: KarumiHQs, developer: Developer) in
            karumiHQs.openFridge(developer)
            return karumiHQs.maxibonsLeft >= 0
        }

        property("If there are two or less maxibons pending after opening the fridge Karumi automatically buys 10 more")
            <- forAll { (karumiHQs: KarumiHQs, developer: Developer) in
                let initialMaxibons = karumiHQs.maxibonsLeft
                return initialMaxibons - developer.numberOfMaxibonsToGet <= 2 ==> {
                    let numOfMaxibons = developer.numberOfMaxibonsToGet
                    let expectedMaxibons = self.maxibonsAfterOpeningTheFridge(initialMaxibons, numOfMaxibons)
                    karumiHQs.openFridge(developer)
                    return karumiHQs.maxibonsLeft == expectedMaxibons
                }
        }

        let chat = MockChat()
        let karumiHQsGenerator = KarumiHQs.create(chat)
        let developerGenerator = Developer.arbitrary

        property("If there are two or less maxibons after opening the fridge the developer sends a message to buy more")
            <- forAll(karumiHQsGenerator, developerGenerator) { (karumiHQs: KarumiHQs, developer: Developer) in
                let initialMaxibons = karumiHQs.maxibonsLeft
                return initialMaxibons - developer.numberOfMaxibonsToGet <= 2 ==> {
                    karumiHQs.openFridge(developer)
                    let expectedResult = chat.messageSent == "Hi guys, I'm \(developer). We need more maxibons!"
                    chat.messageSent = nil
                    return expectedResult
                }
        }

        property("If there are more than two maxibons after opening the fridge the developer does not send any message")
            <- forAll(karumiHQsGenerator, developerGenerator) { (karumiHQs: KarumiHQs, developer: Developer) in
                let initialMaxibons = karumiHQs.maxibonsLeft
                return initialMaxibons - developer.numberOfMaxibonsToGet > 2 ==> {
                    karumiHQs.openFridge(developer)
                    let expectedResult = chat.messageSent == nil
                    chat.messageSent = nil
                    return expectedResult
                }
        }
    }

    private func maxibonsAfterOpeningTheFridge(initialMaxibons: Int, _ maxibonsToGet: Int) -> Int {
        var expectedMaxibons = initialMaxibons - maxibonsToGet
        if expectedMaxibons < 0 {
            expectedMaxibons = 0
        }
        expectedMaxibons += 10
        return expectedMaxibons
    }

}
