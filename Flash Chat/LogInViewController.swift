//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit

import Firebase
class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {

        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user,error) in
            if error != nil
            {
             
                let alert = UIAlertController(title: "Error!", message:"Invalid email or password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert,animated: true,completion: nil)
            }
            else
            {
                        print("successfully login")
                       self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
        
    }
    


    
}  
