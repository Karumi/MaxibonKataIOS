//
//  Developer.swift
//  MaxibonKata
//
//  Created by Pedro Vicente Gomez on 29/06/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation

public struct Developer {

    public let name: String
    public let numberOfMaxibonsToGet: Int

    init(name: String, numberOfMaxibonsToGet: Int) {
        self.name = name
        self.numberOfMaxibonsToGet = numberOfMaxibonsToGet < 0 ? 0 : numberOfMaxibonsToGet
    }

}

public class Karumies {

    public static let Pedro = Developer(name: "Pedro", numberOfMaxibonsToGet: 2)
    public static let Davide = Developer(name: "Davide", numberOfMaxibonsToGet: 2)
    public static let Alberto = Developer(name: "Alberto", numberOfMaxibonsToGet: 2)
    public static let Jorge = Developer(name: "Jorge", numberOfMaxibonsToGet: 2)
    public static let Sergio = Developer(name: "Sergio", numberOfMaxibonsToGet: 2)

}
