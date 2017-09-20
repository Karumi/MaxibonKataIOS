//
//  ArbitraryDeveloper.swift
//  MaxibonKataIOS
//
//  Created by Pedro Vicente Gomez on 29/06/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import MaxibonKataIOS

extension Developer: Arbitrary {

    public static var arbitrary: Gen<Developer> {
        return Gen<Developer>.one(of: [
            Gen<Developer>.pure(Karumies.Alberto),
            Gen<Developer>.pure(Karumies.Pedro),
            Gen<Developer>.pure(Karumies.Jorge),
            Gen<Developer>.pure(Karumies.Davide),
            Gen<Developer>.pure(Karumies.Sergio),
            Gen<Developer>.pure(Karumies.Fran),
            ])
    }

    public static var arbitraryHungry: Gen<Developer> {
        return Gen<Int>.fromElements(in: 8...Int.max).map {
            let name = String.arbitrary.generate
            return Developer(name: name, numberOfMaxibonsToGet: $0)
        }
    }

    public static var arbitraryNotSoHungry: Gen<Developer> {
        return Gen<Int>.fromElements(in: 0...7).map {
            let name = String.arbitrary.generate
            return Developer(name: name, numberOfMaxibonsToGet: $0)
        }
    }
}
