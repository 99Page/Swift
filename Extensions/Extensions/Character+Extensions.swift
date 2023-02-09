//
//  Character+Extensions.swift
//  Extensions
//
//  Created by 노우영 on 2023/02/09.
//

import Foundation

//  MARK: To ASCII

extension Character {
    func toASCII() -> Int {
        Int(self.unicodeScalars.first!.value)
    }
}
