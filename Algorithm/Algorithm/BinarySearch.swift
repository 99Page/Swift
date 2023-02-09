//
//  BinarySearch.swift
//  Algorithm
//
//  Created by 노우영 on 2023/02/09.
//

import Foundation

//  MARK: 이분탐색, lowerBound, upperBound

extension Array where Element: Comparable {

    func lowerBound(target: Element) -> Int {
        var e = self.count
        var s = 0
        while(s < e) {
            let m = (s+e) / 2
            if (self[m] as Element >= target) {
                e = m
            } else {
                s = m+1
            }
        }

        return e;
    }
    
    func upperBound(target: Element) -> Int {
        var e = self.count
        var s = 0
        while(s < e) {
            let m = (s+e) / 2;
            if (self[m] as Element > target) {
                e = m;
            } else {
                s = m+1;
            }
        }

        return e;
    }
}
