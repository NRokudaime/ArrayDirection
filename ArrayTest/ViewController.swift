//
//  ViewController.swift
//  ArrayTest
//
//  Created by Vladislav Antonov on 17/02/2017.
//  Copyright © 2017 NRokudaime. All rights reserved.
//
//Есть матрица 2n-1 x 2n-1, заполненная случайными значениями.
//Надо вывести их на экран в ряд, начиная из центра по спирали: влево - вниз - вправо - вверх и т.д.
//Пример
//Если матрица:
//1 2 3
//4 5 6
//7 8 9
//То результат:
//5 4 7 8 9 6 3 2 1
//Решение должно быть для общего случая с любым n, написано на C/Objective-C/Swift

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBInspectable var inputValue: Int = 5 {
        didSet{
            if inputValue < 1 {
                inputValue = 1
            }
        }
    }
    
    var writter: ArrayWritter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var arrayForTest:Array<Array<Int>> = [[]]
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
                
        writter = ArrayWritter(inputArray: arrayForTest, inputValue: inputValue)
        
        writter?.spiralString { [weak self] (text) in
            self?.outputTextView.text = text
        }
    }

}

