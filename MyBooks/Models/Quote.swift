//
//  Qoute.swift
//  MyBooks
//
//  Created by Hope on 2024/3/16.
//

import Foundation
import SwiftData

@Model
class Quote {
    var createdDate: Date = Date.now
    var text: String = ""
    var page: String?
    var book: Book?
    
    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
}
