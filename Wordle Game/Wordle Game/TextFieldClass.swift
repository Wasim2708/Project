//
//  TextFieldClass.swift
//  Wordle Game
//
//  Created by wasim-zstk238 on 07/07/22.
//

import Foundation
import UIKit

extension ViewController  {
    func setTextFieldDelegates() {
        tf11.delegate = self
        tf12.delegate = self
        tf13.delegate = self
        tf14.delegate = self
        tf15.delegate = self
        tf21.delegate = self
        tf22.delegate = self
        tf23.delegate = self
        tf24.delegate = self
        tf25.delegate = self
        tf31.delegate = self
        tf32.delegate = self
        tf33.delegate = self
        tf34.delegate = self
        tf35.delegate = self
        tf41.delegate = self
        tf42.delegate = self
        tf43.delegate = self
        tf44.delegate = self
        tf45.delegate = self
        tf51.delegate = self
        tf52.delegate = self
        tf53.delegate = self
        tf54.delegate = self
        tf55.delegate = self
        tf61.delegate = self
        tf62.delegate = self
        tf63.delegate = self
        tf64.delegate = self
        tf65.delegate = self
      
    }
    
    func setTagNumbers() {
        tf11.tag = 1
        tf12.tag = 2
        tf13.tag = 3
        tf14.tag = 4
        tf15.tag = 5
        tf21.tag = 6
        tf22.tag = 7
        tf23.tag = 8
        tf24.tag = 9
        tf25.tag = 10
        tf31.tag = 11
        tf32.tag = 12
        tf33.tag = 13
        tf34.tag = 14
        tf35.tag = 15
        tf41.tag = 16
        tf42.tag = 17
        tf43.tag = 18
        tf44.tag = 19
        tf45.tag = 20
        tf51.tag = 21
        tf52.tag = 22
        tf53.tag = 23
        tf54.tag = 24
        tf55.tag = 25
        tf61.tag = 26
        tf62.tag = 27
        tf63.tag = 28
        tf64.tag = 29
        tf65.tag = 30
        tf11.becomeFirstResponder()
    }
}

