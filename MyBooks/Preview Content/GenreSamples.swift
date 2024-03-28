//
//  GenreSamples.swift
//  MyBooks
//
//  Created by Hope on 2024/3/28.
//

import Foundation

extension Genre {
    static var sampleGenres: [Genre] {
        [
            Genre(name: "Fiction", color: "00ff00"),
            Genre(name: "Non Fiction", color: "0000ff"),
            Genre(name: "Romance", color: "ff0000"),
            Genre(name: "Thriller", color: "000000")
        ]
    }
}
