//
//  Shortest Path.swift
//  Algorithm
//  Created by 노우영 on 2023/02/12.
//  벨만포드, 다익스트라, 플로이드 워셜
//  Dijkstra, FloydWarshall, BellmanFord

import Foundation

//  출발노드 0번을 기준으로 한다.

struct Edge {
    let destination: Int
    let weight: Int
}

//  MARK: 다익스트라 Dijkstra
func dijkstra(size: Int, start: Int, edges: [[Edge]]) -> [Int] {
    
    // INF 값은 문제 상황마다 조절 필요
    let INF = 1000000
    
    var dists: [Int] = [Int](repeating: INF, count: size)
    dists[start] = 0
    
    // 거리를 기준으로 오름차순 정렬
    var pq: PriorityQueue<Edge> = PriorityQueue { $0.weight < $1.weight }
    pq.push(Edge(destination: start, weight: 0))
    
    
    while !pq.isEmpty() {
        let cur = pq.pop()!
        let node = cur.destination
        let dist = cur.weight
        
        if dists[node] < dist {
            continue
        }
        
        for edge in edges[node] {
            let newNode = edge.destination
            let newDist = dist + edge.weight
            
            if newDist < dists[newNode] {
                dists[newNode] = newDist
                pq.push(Edge(destination: newNode, weight: newDist))
            }
        }
        
    }
    
    return dists
}

//  MARK: 벨만포드 Bellmanford
func bellmanford(size: Int, start: Int, edges: [[Edge]]) -> [Int] {
    
    var dists: [Int] = [Int](repeating: Int.max, count: size)
    dists[start] = 0
    
    for _ in 0..<size-1 {
        for start in 0..<edges.count  {
            for edge in edges[start] {
                if dists[start] != Int.max && dists[edge.destination] > dists[start] + edge.weight {
                    dists[edge.destination] = dists[start] + edge.weight
                }
            }
        }
    }
    
    for start in 0..<edges.count {
        for edge in edges[start] {
            if dists[start] != Int.max && dists[edge.destination] > dists[start] + edge.weight {
                print("음수 사이클이 존재함")
                break
            }
        }
    }
    return dists
}

func floydWarshall(graph: [[Int]], size: Int) -> [[Int]] {
    var distances: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: size), count: size)

    for i in 0 ..< size {
        for j in 0 ..< size {
            distances[i][j] = graph[i][j]
        }
    }

    for k in 0 ..< size {
        for i in 0 ..< size {
            for j in 0 ..< size {
                if distances[i][k] != Int.max && distances[k][j] != Int.max {
                    distances[i][j] = min(distances[i][j], distances[i][k] + distances[k][j])
                }
            }
        }
    }

    return distances
}
