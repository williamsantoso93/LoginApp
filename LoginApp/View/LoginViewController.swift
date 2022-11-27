//
//  ViewController.swift
//  LoginApp
//
//  Created by William Santoso on 27/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let viewModel: LoginViewModelProtocol = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeScreen" {
            if let vc = segue.destination as? HomeViewController {
                vc.email = emailTextField.text ?? ""
            }
        }
    }

    @IBAction func loginAction(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        let user = User(
            email: email,
            password: password
        )
        
        viewModel.login(user: user) { token, networkError in
            if let networkError {
                var message: String = ""
                switch networkError {
                case .errorMessage(let errorMessage):
                    message = errorMessage
                case .noData, .badUrl, .decodingError, .encodingError:
                    message = "Network error"
                }
                
                let alertContoller = UIAlertController (title: "Error" , message: message , preferredStyle: .alert)
                alertContoller.addAction(UIAlertAction(title: "OK", style: .default , handler: nil))
                self.present(alertContoller, animated: true)
                
                return
            }
            
            guard let token, !token.isEmpty else {
                return
            }
            
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.performSegue(withIdentifier: "homeScreen", sender: self)
        }
    }    
}

