//
//  SegmentTree.swift
//  Algorithm
//
//  Created by 노우영 on 2023/02/12.
//  Segment Tree 세그먼트 트리

import Foundation

//  편하지만 느림 
class SegmentTree<T> {
    var value: T
    var function: (T, T) -> T
    var leftBounds: Int
    var rightBounds: Int
    var leftChild: SegmentTree<T>?
    var rightChild: SegmentTree<T>?
    
    init(array: [T], leftBounds: Int, rightBounds: Int, function: @escaping (T, T) -> T) {
        self.leftBounds = leftBounds
        self.rightBounds = rightBounds
        self.function = function
        
        if leftBounds == rightBounds {
            self.value = array[leftBounds]
        } else {
            let middle = (leftBounds + rightBounds) / 2
            self.leftChild = SegmentTree<T>(
                array: array,
                leftBounds: leftBounds,
                rightBounds: middle,
                function: function
            )
            
            self.rightChild = SegmentTree<T>(
                array: array,
                leftBounds: middle+1,
                rightBounds: rightBounds,
                function: function
            )
            self.value = function(leftChild!.value, rightChild!.value)
        }
    }
    
    convenience init(array: [T], function: @escaping (T, T) -> T) {
        self.init(array: array, leftBounds: 0, rightBounds: array.count-1, function: function)
    }
    
    // O(logN)
    func query(withLeftBounds leftBounds: Int, rightBounds: Int) -> T {
        // left, right가 모두 일치 -> 자기 value 리턴
        if self.leftBounds == leftBounds, self.rightBounds == rightBounds {
            return value
        }
        
        guard let leftChild = leftChild,
              let rightChild = rightChild
        else { fatalError() }
        
        // 왼쪽자식의 오른쪽이 left보다 작다. -> 오른쪽 자식에 모두 포함되므로 오른쪽부터 다시
        if leftChild.rightBounds < leftBounds {
            return rightChild.query(withLeftBounds: leftBounds, rightBounds: rightBounds)
        }
        
        // 오른쪽자식의 왼쪽이 right보다 크다. -> 왼쪽 자식에 모두 포함되므로 왼쪽부터 다시
        else if rightChild.leftBounds > rightBounds {
            return leftChild.query(withLeftBounds: leftBounds, rightBounds: rightBounds)
        }
        
        // 양쪽 자식들에 걸쳐져 있음 -> (leftBounds ~ leftChild.right) + (rightChild.left ~ rightBounds)
        else {
            let leftValue = leftChild.query(withLeftBounds: leftBounds, rightBounds: leftChild.rightBounds)
            let rightValue = rightChild.query(withLeftBounds: rightChild.leftBounds, rightBounds: rightBounds)
            return function(leftValue, rightValue)
        }
    }
    
    // O(logN)
    func replaceItem(at index: Int, withItem item: T) {
        if leftBounds == rightBounds {
            value = item
        } else if let leftChild = leftChild, let rightChild = rightChild {
            if leftChild.rightBounds >= index {
                leftChild.replaceItem(at: index, withItem: item)
            } else {
                rightChild.replaceItem(at: index, withItem: item)
            }
            value = function(leftChild.value, rightChild.value)
        }
    }
}
