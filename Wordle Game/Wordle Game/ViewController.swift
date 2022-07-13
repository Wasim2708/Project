//
//  ViewController.swift
//  Wordle Game
//
//  Created by wasim-zstk238 on 07/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var notWordList: UITextField!
    @IBOutlet weak var tf11: UITextField!
    @IBOutlet weak var tf12: UITextField!
    @IBOutlet weak var tf13: UITextField!
    @IBOutlet weak var tf14: UITextField!
    @IBOutlet weak var tf15: UITextField!
    @IBOutlet weak var tf21: UITextField!
    @IBOutlet weak var tf22: UITextField!
    @IBOutlet weak var tf23: UITextField!
    @IBOutlet weak var tf24: UITextField!
    @IBOutlet weak var tf25: UITextField!
    @IBOutlet weak var tf31: UITextField!
    @IBOutlet weak var tf32: UITextField!
    @IBOutlet weak var tf33: UITextField!
    @IBOutlet weak var tf34: UITextField!
    @IBOutlet weak var tf35: UITextField!
    @IBOutlet weak var tf41: UITextField!
    @IBOutlet weak var tf42: UITextField!
    @IBOutlet weak var tf43: UITextField!
    @IBOutlet weak var tf44: UITextField!
    @IBOutlet weak var tf45: UITextField!
    @IBOutlet weak var tf51: UITextField!
    @IBOutlet weak var tf52: UITextField!
    @IBOutlet weak var tf53: UITextField!
    @IBOutlet weak var tf54: UITextField!
    @IBOutlet weak var tf55: UITextField!
    @IBOutlet weak var tf61: UITextField!
    @IBOutlet weak var tf62: UITextField!
    @IBOutlet weak var tf63: UITextField!
    @IBOutlet weak var tf64: UITextField!
    @IBOutlet weak var tf65: UITextField!
    
    var currentAnswer:[String] = []
    var currentString = ""
    var randomNumber = 0
    var userWon = false
    var wordMisSpelled = false
    var allTextFields:[UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        randomNumber = Int.random(in: 0..<50)
        currentString = FiveLetterWords.AllWords[randomNumber]
        currentAnswer = currentString.map {String($0.uppercased())}
        setTextFieldDelegates()
        setTagNumbers()
        // Do any additional setup after loading the view.
    }
    
    func reloadView() {
        userWon = false
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
    }
    
    
    
}

extension ViewController:UITextFieldDelegate {
    
    // MARK: - TextField Method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        allTextFields.append(textField)
        allTextFields = allTextFields.suffix(5)  // if the user changes the previous value, we have to take last 5 values
        textField.text = string.uppercased()
        if range.length == 0 {
            if let nextTextField = self.view.viewWithTag(textField.tag + 1) as? UITextField { // Change view into UITextFieldr
                if textField.tag % 5 == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {    // should make next field enable only after it checks the previous value
                        if !self.wordMisSpelled {
                            nextTextField.isEnabled = true  // Should make enable, since newfield is disable before
                            nextTextField.becomeFirstResponder()
                        }
                        self.notWordList.isHidden = true
                        self.wordMisSpelled = false
                    }
                    checkTheInput(textField.tag)
                    if userWon {   // if user won, make next field disable and show credits message
                        nextTextField.isEnabled = false
                        nextTextField.resignFirstResponder()
                        displayResutForUser()
                    }
                } else {  // should make next textfield emable quickly
                    nextTextField.isEnabled = true  // Should make enable, since newfield is disable before
                    nextTextField.becomeFirstResponder()
                }
            } else {
                checkTheInput(textField.tag)  // to check answer is correct or wrong
                if !self.wordMisSpelled {
                    displayResutForUser()   // we should display user has won or not
                }
                self.notWordList.isHidden = true
                self.wordMisSpelled = false
            }
        }
        
        return false
    }
    
    
    // MARK: - Input Check Function
    func checkTheInput(_ tagNumber:Int)   {
        var userAnswer = ""
        var tempArray = currentAnswer
        for number in (tagNumber - 4...tagNumber) {
            var temp = number
            if let currentTextField = self.view.viewWithTag(number) as? UITextField {
                currentTextField.isEnabled = false
                userAnswer += currentTextField.text ?? ""
                if number == tagNumber {   // If it is last field, we have to check if the word is spelled correctly or not
                    if wordIsNotSpelledCorrect(userAnswer.lowercased()) {    // if word is misSpelled
                        wordIsMisSpelled(allTextFields)
                    } else {
                        wordIsNotMisSpelled(number, &temp, allTextFields, &tempArray)  // word is spelled correctly
                    }
                }
                else {
                    wordIsNotMisSpelled(number, &temp, allTextFields, &tempArray)
                }
               
            }
            if userAnswer == currentString.uppercased()  {   userWon = true  }  // After user won, set userwon as true and return it
        }
        allTextFields = []
    }
    
    // MARK: - To spell check the word
    func wordIsNotSpelledCorrect(_ userAnswer:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: userAnswer.utf16.count)
        let wordRange = checker.rangeOfMisspelledWord(in: userAnswer, range: range, startingAt: 0, wrap: false, language: "en")
        return wordRange.location != NSNotFound
    }
    
    func wordIsNotMisSpelled(_ number:Int,_ temp:inout Int,_ allTextFields:[UITextField],_ tempArray:inout [String]) {
        if number % 5 == 0 {temp = 4}  // to make 5,10,15 numbers non - negative
        else {temp = (temp % 5) - 1}
        changeTextFieldBackground(allTextFields, temp, &tempArray)
    }
    
    func wordIsMisSpelled(_ allTextFields:[UITextField]) {
        notWordList.isHidden = false
        allTextFields[0].isEnabled = true     // make all text fields empty and first field enable
        for i in 0...4 {
            allTextFields[i].text = ""
            UIView.transition(with: allTextFields[i], duration: 2, options: .transitionCurlUp, animations: {
                allTextFields[i].backgroundColor = .white
            }, completion: {void in  allTextFields[0].becomeFirstResponder()})
        }
        wordMisSpelled = true
    }
    
    // MARK: - Change TextField BackGround Color
    func changeTextFieldBackground(_ allTextFields:[UITextField],_ temp:Int,_ tempArray: inout [String])  {
        if allTextFields[temp].text == tempArray[temp] {
            tempArray[temp] = ""    // to not take same letter again
            UIView.transition(with: allTextFields[temp], duration: 2, options: .transitionCurlDown, animations: {
                allTextFields[temp].backgroundColor = .systemGreen
            }, completion: nil)
        }
        else if tempArray.contains(allTextFields[temp].text ?? "") {
            var index = tempArray.firstIndex(of: allTextFields[temp].text ?? "")!
            if allTextFields[index].text != tempArray[index] {     
                    tempArray[index] = ""     // to not show the specific character again
                    UIView.transition(with: allTextFields[temp], duration: 2, options: .transitionCurlDown, animations: {
                        allTextFields[temp].backgroundColor = .systemYellow
                    }, completion: nil)
            } else {
                    let slicedArray = tempArray[index + 1..<tempArray.count]
                    if slicedArray.contains(allTextFields[temp].text ?? "")  {
                        index = slicedArray.firstIndex(of: allTextFields[temp].text ?? "")!
                        tempArray[index] = ""
                        UIView.transition(with: allTextFields[temp], duration: 2, options: .transitionCurlDown, animations: {
                            allTextFields[temp].backgroundColor = .systemYellow
                        }, completion: nil)
                    } else {
                        UIView.transition(with: allTextFields[temp], duration: 2, options: .transitionCurlDown, animations: {
                            allTextFields[temp].backgroundColor = .lightGray
                        }, completion: nil)
                    }
            }
            
        }
        else {
            UIView.transition(with: allTextFields[temp], duration: 2, options: .transitionCurlDown, animations: {
                allTextFields[temp].backgroundColor = .lightGray
            }, completion: nil)
        }
    }
    
    //MARK: - Show Result for User
    func displayResutForUser() {
        let result = userWon ? "Won":"Lose"
        let message = userWon ? "Hurray, You Found the Tough One":"Sorry,Better Luck Next Time\nThe word is \(currentString.uppercased())"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let alertController = UIAlertController(title: result, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { void in
                self.reloadView()
            }))
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true)
        }
    }
}


// To move textfields
//            if let currentTextField = self.view.viewWithTag(number) as? UITextField {
//                UIView.animate(withDuration: 2, delay: 0) {
//                    currentTextField.frame = currentTextField.frame.offsetBy(dx: -500, dy: 0)
//                }
//            }

