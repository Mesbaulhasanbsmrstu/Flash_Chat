//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit

import Firebase
class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        

        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (User, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error!", message:"Invalid email or password.", preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                             self.present(alert,animated: true,completion: nil)
            }
                else  {
                    print("successfully registration")
                self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            }
        }
        
        

        
        
    } 
    
    

