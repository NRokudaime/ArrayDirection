//
//  ViewController.swift
//  ArrayTest
//
//  Created by Vladislav Antonov on 17/02/2017.
//  Copyright © 2017 NRokudaime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    typealias Point = (collumn: Int, line: Int)
    @IBInspectable var inputValue: Int = 3
    var arrayForTest:Array<Array<Int>> = [[]]
    var outputString = ""
    
    func move(collumPos: Int, linePos: Int, direction: Direction) -> Point {
        outputString.append("\(arrayForTest[linePos][collumPos]) ")
        arrayForTest[linePos][collumPos] = -1
        return (collumPos + direction.coordinate.collumn, linePos + direction.coordinate.line)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arraySize = 2 * inputValue - 1
        var inputText = ""
        for line in (0..<arraySize) {
            if line > 0 {
                arrayForTest.append([])
            }
            for _ in (0..<arraySize) {
                arrayForTest[line].append(Int(arc4random() % 99))
            }
            inputText.append("\(arrayForTest[line].map({ String(format: "%02d", $0) }).joined(separator: " "))\n")
        }
        inputTextView.text = inputText
        
        let centerIndex = inputValue - 1
        outputTextView.text = outputTextView.text + "\nCenter point: \(arrayForTest[centerIndex][centerIndex])"
        
        outputString = "\(arrayForTest[centerIndex][centerIndex]) "
        var linePos = centerIndex
        var collumPos = centerIndex - 1
        var direction: Direction = .bottom
        
        while (collumPos >= 0 && linePos >= 0) {
            let newPoints = move(collumPos: collumPos, linePos: linePos, direction: direction)
            collumPos = newPoints.collumn
            linePos = newPoints.line
            
            if abs(centerIndex - linePos) == abs(centerIndex - collumPos) {
                if arrayForTest[linePos + direction.next.coordinate.line][collumPos + direction.next.coordinate.collumn] == -1 {
                    let newPoints = move(collumPos: collumPos, linePos: linePos, direction: direction)
                    collumPos = newPoints.collumn
                    linePos = newPoints.line
                    
                }
                direction = direction.next
            }
        }
        
        outputTextView.text = outputTextView.text + "\n\(outputString)"
        
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

