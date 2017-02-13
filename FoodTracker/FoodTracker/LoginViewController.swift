//
//  LoginViewController.swift
//  FoodTrackerSignupViewController
//
//  Created by Alex Bearinger on 2017-02-13.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var incorrectInfoLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func saveButton(_ sender: Any) {
        guard (usernameTextField.text as String!) != nil else{
            self.incorrectInfoLabel.isHidden = false
            return
        }
        guard (passwordTextField.text as String!) != nil else{
            self.incorrectInfoLabel.isHidden = false
            return
        }
        guard ((passwordTextField.text?.characters.count)! as Int) > 5 else{
            self.incorrectInfoLabel.isHidden = false
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
