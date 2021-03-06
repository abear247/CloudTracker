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
        let defaults = UserDefaults.standard
        guard (usernameTextField.text! as String) == (defaults.value(forKey: "username") as? String) else{
            self.incorrectInfoLabel.isHidden = false
            return
        }
        guard (passwordTextField.text! as String) == (defaults.value(forKey: "password") as? String) else{
            self.incorrectInfoLabel.isHidden = false
            return
        }
        
        let postData = [
            "username": usernameTextField.text ?? "",
            "password": passwordTextField.text ?? ""
        ]
        
        guard let postJSON = try? JSONSerialization.data(withJSONObject: postData, options: []) else {
            print("could not serialize json")
            return
        }
        
        let req = NSMutableURLRequest(url: URL(string:"http://159.203.243.24:8000/login")!)
        
        req.httpBody = postJSON
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: req as URLRequest) { (data, resp, err) in
            
            guard let data = data else {
                print("no data returned from server \(err)")
                return
            }
            
            guard let resp = resp as? HTTPURLResponse else {
                print("no response returned from server \(err)")
                return
            }
            
            guard let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:[String:String]] else {
                print("data returned is not json, or not valid")
                return
            }
            
            guard resp.statusCode == 200 else {
                // handle error
                print("an error occurred")
                return
            }
            
            // do something with the data returned (decode json, save to user defaults, etc.)
            let defaults = UserDefaults.standard
            defaults.set(self.usernameTextField.text!, forKey: "username")
            defaults.set(self.passwordTextField.text!, forKey: "password")
            defaults.set(rawJSON["user"], forKey: "user")
            self.dismiss(animated: true, completion: nil)
        }
        task.resume()
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
