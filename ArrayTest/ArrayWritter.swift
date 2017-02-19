//
//  ArrayWritter.swift
//  ArrayTest
//
//  Created by NRokudaime on 19.02.17.
//  Copyright © 2017 NRokudaime. All rights reserved.
//

import Foundation

class ArrayWritter {
    typealias Point = (collumn: Int, line: Int)

    var inputArray:Array<Array<Int>>
    let inputValue: Int
    var outputString = ""
    
    init(inputArray:Array<Array<Int>>, inputValue: Int) {
        self.inputArray = inputArray
        self.inputValue = inputValue
    }
    
    /// Получение строки в виде спирали "изнутри наружу"
    /// - parameter complection: обработка полученной строки
    func spiralString(complection:@escaping ((String) -> Void)) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let weakSelf = self else {
                return
            }
            let centerIndex = weakSelf.inputValue - 1
            weakSelf.outputString = "\(weakSelf.inputArray[centerIndex][centerIndex]) "
            var linePos = centerIndex
            var collumPos = centerIndex - 1
            var direction: Direction = .bottom
            
            while (collumPos >= 0 && linePos >= 0) {
                let newPoints = weakSelf.move(collumPos: collumPos, linePos: linePos, direction: direction)
                collumPos = newPoints.collumn
                linePos = newPoints.line
                
                if abs(centerIndex - linePos) == abs(centerIndex - collumPos) {
                    if weakSelf.inputArray[linePos + direction.next.coordinate.line][collumPos + direction.next.coordinate.collumn] == -1 {
                        let newPoints = weakSelf.move(collumPos: collumPos, linePos: linePos, direction: direction)
                        collumPos = newPoints.collumn
                        linePos = newPoints.line
                        
                    }
                    direction = direction.next
                }
            }
            
            DispatchQueue.main.sync {
                complection(weakSelf.outputString)
            }
        }
    }
    
    private func move(collumPos: Int, linePos: Int, direction: Direction) -> Point {
        outputString.append("\(inputArray[linePos][collumPos]) ")
        inputArray[linePos][collumPos] = -1
        return (collumPos + direction.coordinate.collumn, linePos + direction.coordinate.line)
    }

    
    enum Direction {
        case left, bottom, right, top
        
        var coordinate: Point {
            switch self {
            case .left:
                return (-1, 0)
            case .bottom:
                return (0, 1)
            case .right:
                return (1, 0)
            case .top:
                return (0, -1)
            }
        }
        
        var next : Direction {
            switch self {
            case .left:
                return .bottom
            case .bottom:
                return .right
            case .right:
                return .top
            case .top:
                return .left
            }
        }
        
    }
}
