import Foundation
import SwiftCheck
import XCTest

@testable import MaxibonKataIOS

class DeveloperSpec: XCTestCase {
    private let anyName = "Pedro"
    private let anyNumberOfMaxibonsToGet = 11

    func testTheNumberOfMaxibonsPerKarumieAre() {
        XCTAssertEqual(3, Karumies.Pedro.numberOfMaxibonsToGet)
        XCTAssertEqual(0, Karumies.Davide.numberOfMaxibonsToGet)
        XCTAssertEqual(1, Karumies.Toni.numberOfMaxibonsToGet)
        XCTAssertEqual(2, Karumies.Jorge.numberOfMaxibonsToGet)
        XCTAssertEqual(1, Karumies.Sergio.numberOfMaxibonsToGet)
        XCTAssertEqual(1, Karumies.Fran.numberOfMaxibonsToGet)
    }

    func testAll() {
        property("Number of maxibons to consume can not be negative") <- forAll { (developer: Developer) in
            developer.numberOfMaxibonsToGet >= 0
        }

        property("The number of maxibons is asigned if is positive or zero")
            <- forAll { (positiveNumber: NonNegative<Int>) in
                let numberOfMaxibons = positiveNumber.getNonNegative
                let developer = Developer(
                    name: self.anyName,
                    numberOfMaxibonsToGet: numberOfMaxibons)
                return developer.numberOfMaxibonsToGet == numberOfMaxibons
            }
    }
}
