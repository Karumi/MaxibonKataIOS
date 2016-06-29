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

    private let anyName = "Pedro"
    private let anyNumberOfMaxibonsToGet = 11

    func testAll() {
        property("Number of maxibons to consume can not be negative") <- forAll { (numOfMaxibons: Int) in
            let developer = Developer(name: self.anyName, numberOfMaxibonsToGet: numOfMaxibons)
            return developer.numberOfMaxibonsToGet >= 0
        }

        property("The number of maxibons is asigned if is positive") <- forAll { (positiveNumber: Positive<Int>) in
            let numberOfMaxibons = positiveNumber.getPositive
            let developer = Developer(name: self.anyName, numberOfMaxibonsToGet: numberOfMaxibons)
            return developer.numberOfMaxibonsToGet == numberOfMaxibons
        }

        property("The name is asigned in construction") <- forAll { (name: String) in
            let developer = Developer(name: name, numberOfMaxibonsToGet: self.anyNumberOfMaxibonsToGet)
            return developer.name == name
        }
    }

}
