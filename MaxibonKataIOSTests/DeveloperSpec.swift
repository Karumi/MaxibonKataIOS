//
//  DeveloperSpec.swift
//  MaxibonKataIOS
//
//  Created by Pedro Vicente Gomez on 29/06/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class DeveloperSpec: XCTestCase {

    fileprivate let anyName = "Pedro"
    fileprivate let anyNumberOfMaxibonsToGet = 11

    func testTheNumberOfMaxibonsPerKarumieAre() {
        XCTAssertEqual(3, Karumies.Pedro.numberOfMaxibonsToGet)
        XCTAssertEqual(0, Karumies.Davide.numberOfMaxibonsToGet)
        XCTAssertEqual(1, Karumies.Alberto.numberOfMaxibonsToGet)
        XCTAssertEqual(2, Karumies.Jorge.numberOfMaxibonsToGet)
        XCTAssertEqual(1, Karumies.Sergio.numberOfMaxibonsToGet)
    }

    func testAll() {
        property("Number of maxibons to consume can not be negative") <- forAll { (developer: Developer) in
            return developer.numberOfMaxibonsToGet >= 0
        }

        property("The number of maxibons is asigned if is positive or zero")
            <- forAll { (positiveNumber: NonNegative<Int>) in
            let numberOfMaxibons = positiveNumber.getNonNegative
            let developer = Developer(name: self.anyName, numberOfMaxibonsToGet: numberOfMaxibons)
            return developer.numberOfMaxibonsToGet == numberOfMaxibons
        }

        property("The name is asigned in construction") <- forAll { (name: String) in
            let developer = Developer(name: name, numberOfMaxibonsToGet: self.anyNumberOfMaxibonsToGet)
            return developer.name == name
        }
    }

}
