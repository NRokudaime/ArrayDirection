//
//  ViewController.swift
//  ArrayTest
//
//  Created by Vladislav Antonov on 17/02/2017.
//  Copyright © 2017 NRokudaime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    typealias DirectionPoint = (collumn: Int, line: Int)
    
    @IBInspectable var inputValue: Int = 3

    var arrayForTest:Array<Array<Int>> = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arraySize = 2 * inputValue - 1
        
        for line in (0..<arraySize) {
            if line > 0 {
                arrayForTest.append([])
            }
            for _ in (0..<arraySize) {
                arrayForTest[line].append(Int(arc4random() % 99))
            }
            print(String(describing: arrayForTest[line].map({ String(format: "%02d", $0) })))
        }
        
        print("")
        let centerIndex = inputValue - 1
        print("Center point: \(arrayForTest[centerIndex][centerIndex])")
        
        var outputString = "\(arrayForTest[centerIndex][centerIndex]) "
        var linePos = centerIndex
        var collumPos = centerIndex - 1
        var direction: Direction = .bottom
        
        for _ in (0..<(arraySize * arraySize) - 1) {
            if collumPos < 0 || linePos < 0 {
                break
            }
            outputString.append("\(arrayForTest[linePos][collumPos]) ")
            arrayForTest[linePos][collumPos] = -1
            collumPos = collumPos + direction.coordinate.collumn
            linePos = linePos + direction.coordinate.line
            
            if abs(centerIndex - linePos) == abs(centerIndex - collumPos) {
                if arrayForTest[linePos + direction.next.coordinate.line][collumPos + direction.next.coordinate.collumn] == -1 {
                    outputString.append("\(arrayForTest[linePos][collumPos]) ")
                    collumPos = collumPos + direction.coordinate.collumn
                    linePos = linePos + direction.coordinate.line
                }
                direction = direction.next
            }
        }
        print("")
        print(outputString)
        
    }

    enum Direction {
        case left, bottom, right, top
        
        var coordinate: DirectionPoint {
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

