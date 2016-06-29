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
        return Int.arbitrary.map {
            let name = String.arbitrary.generate
            return Developer(name: name, numberOfMaxibonsToGet: $0)
        }
    }

}