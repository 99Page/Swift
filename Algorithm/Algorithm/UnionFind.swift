//
//  UnionFind.swift
//  Algorithm
//
//  Created by 노우영 on 2023/02/12.
//  union find, 유니온 파인드 

import Foundation

let size = 10000
var parents: [Int] = [Int]()
var groupSize: [Int] = [Int]()

func findRoot(_ u: Int) -> Int {
    if (parents[u] == u) {
        return u
    }
    
    parents[u] = findRoot(parents[u])
    return parents[u]
}

func unionGroup(_ u: Int, _ v: Int) {
    let rootU: Int = findRoot(u)
    let rootV: Int = findRoot(v)
    
    if groupSize[rootU] < groupSize[rootV] {
        parents[rootU] = rootV
        groupSize[rootV] += groupSize[rootU]
    } else {
        parents[rootV] = rootU;
        groupSize[rootU] += groupSize[rootV];
    }
}

func isSameGroup(_ u: Int, _ v: Int) -> Bool {
    return findRoot(u) == findRoot(v)
}

func initParent() {
    for i in 0..<size {
        parents[i] = i
    }
}
