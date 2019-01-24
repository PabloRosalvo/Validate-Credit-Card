//
//  ViewController.swift
//  Validation Fields
//
//  Created by Pablo Rosalvo on 23/01/19.
//  Copyright © 2019 Pablo Rosalvo. All rights reserved.
//

import UIKit
import JMMaskTextField_Swift

class ViewController: UIViewController {
    @IBOutlet weak var numberCardTextField: JMMaskTextField!
    @IBOutlet weak var nameCardTextField: JMMaskTextField!
    @IBOutlet weak var expirationDateTextField: JMMaskTextField!
    @IBOutlet weak var cvvCardTextField: JMMaskTextField!
    @IBOutlet weak var continueButton: UIButton!
    var gradientLayer = CAGradientLayer()
    var isValidCreditCard = false
    var isValidName = false
    var isValidCvv = false
    var isValidDate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberCardTextField.maskString = "0000 0000 0000 0000"
        expirationDateTextField.maskString = "00/0000"
        cvvCardTextField.maskString = "000"
        
        nameCardTextField.delegate = self
        numberCardTextField.delegate = self
        expirationDateTextField.delegate = self
        cvvCardTextField.delegate = self
        
        continueButton.isEnabled = false
        continueButton.alpha = 0.3
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
        let gradient = StyleGuide.getGradientButton(viewToApply: continueButton)
        continueButton.layer.insertSublayer(gradient, at: 0)
    }
    
    func checkIsButtonEnabled () {
        if isValidName && isValidCreditCard && isValidDate && isValidCvv {
            continueButton.isEnabled = true
            continueButton.alpha = 1.0
        } else {
            continueButton.isEnabled = false
            continueButton.alpha = 0.3
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == nameCardTextField {
            let trimmingFullName = replacementText.trimmingCharacters(in: .whitespacesAndNewlines)
            let fullNameArr = trimmingFullName.components(separatedBy: " ")
            
            if fullNameArr.count > 1 {
                isValidName = true
                self.checkIsButtonEnabled()
            } else {
                isValidName = false
                self.checkIsButtonEnabled()
            }
        }
        
        if textField == numberCardTextField {
            if replacementText.count >= 19 {
                isValidCreditCard = true
                self.checkIsButtonEnabled()
            } else {
                isValidCreditCard = false
                self.checkIsButtonEnabled()
            }
        }
        
        if textField == expirationDateTextField {
            if replacementText.count >= 7 {
                isValidDate = true
                self.checkIsButtonEnabled()
            } else {
                isValidDate = false
                self.checkIsButtonEnabled()
            }
        }
        
        if textField == cvvCardTextField {
            if replacementText.count >= 3 {
                isValidCvv = true
                self.checkIsButtonEnabled()
            } else {
                isValidCvv = false
                self.checkIsButtonEnabled()
            }
        }
        return true
    }
}
