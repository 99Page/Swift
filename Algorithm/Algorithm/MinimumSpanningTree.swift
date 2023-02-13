//
//  MinimumSpanningTree.swift
//  Algorithm
//
//  Created by 노우영 on 2023/02/
//  Minumum Spanning Tree MST Prim 프림

import Foundation

//  MARK: Prim 프림
//  Weight의 총 합을 반환한다.
func prim(start: Int, size: Int, edges: [[Edge]]) -> Int {
    
    
    var isVisited: [Bool] = [Bool](repeating: false, count: size)
    var result = 0
    isVisited[start] = true
    
    
    
    let pq: PriorityQueue<Edge> = PriorityQueue { $0.weight < $1.weight }
    
    for edge in edges[start] {
        pq.push(edge)
    }
    
    while !pq.isEmpty() {
        let cur = pq.pop()!
        let node = cur.destination
        let weight = cur.weight
        
        if isVisited[cur.destination] {
            continue
        }
        
        isVisited[node] = true
        result += weight
        
        for edge in edges[node] {
            let nextNode = edge.destination
            if !isVisited[nextNode]  {
                pq.push(Edge(destination: nextNode, weight: weight))
            }
        }
    }
    
    return result
}
