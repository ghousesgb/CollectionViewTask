//
//  ViewController.swift
//  EmailValidation
//
//  Created by Test on 13/08/18.
//  Copyright © 2018 DEV. All rights reserved.
//

import UIKit
let limitLength = 12

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        //ToDo: Testing purpose, need to remove below two lines
        emailTextfield.text = "naren@gmail.com"
        passwordTextField.text  = "P@ssw0rd1234"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonSubmit(_ sender: UIButton) {
        
        if(!isValidEmail(email: self.emailTextfield.text)){
            let alertController = UIAlertController(title: "Alert", message: "Please Enter Valid Email.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)

        }
        else if(!isValidPassword(passStr: self.passwordTextField.text)) {

            let alertController = UIAlertController(title: "Alert", message: "Please Enter Valid Password.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

        }
        else{
            /*let alertController = UIAlertController(title: "Success", message: "Login Success.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.performSegue(withIdentifier: "dynamicImageGallery", sender: nil);

            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)*/
            self.performSegue(withIdentifier: "dynamicImageGallery", sender: nil);
        }

    }
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(passStr:String?) -> Bool {
        guard passStr != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{12,}$")
        return passwordTest.evaluate(with: passStr)
    }
}

extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true //backspace is pressed
        }
        if textField == passwordTextField {
            if let password = textField.text, password.count >= limitLength {
                return false
            }
        }
        return true
    }
}
