//
//  main.swift
//  Extensions
//
//  Created by 노우영 on 2023/02/09.
//

import Foundation

// MARK : String Extension Examples
let str = "abcdef"
let sub1 = str.substring(from: 1, to: 2) // "bc"
let sub2 = str.substring(from: 0, to: str.count - 2) // "abcde"
let sub3 = Character(str.at(2)) // "c"

//  MARK: String to ASCII

let str_1 = "A"
var ascii: Int = str_1.toASCII() // 65

let char_1: Character = "A"
ascii = char_1.toASCII() // 65
