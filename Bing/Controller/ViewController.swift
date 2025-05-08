//
//  ViewController.swift
//  Bing
//
//  Created by Vivek Guntuku on 04/03/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let loginLabel : UILabel = {
        let loginLabel = UILabel()
        loginLabel.text = "LOG IN"
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.textAlignment = .center
      //loginLabel.font = UIFont.boldSystemFont(ofSize: 25)
      //  loginLabel.layer.borderColor = UIColor.black.cgColor
      //  loginLabel.layer.borderWidth = 1
        loginLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        loginLabel.adjustsFontForContentSizeCategory = true
        return loginLabel
    }()
    
    private let nameField : UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Enter Username"
        nameField.textColor = .darkGray
        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.layer.borderWidth = 0.30
        nameField.layer.masksToBounds = true
        nameField.layer.cornerRadius = 5
        return nameField
    }()
    
    private let passwordField : UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Enter Password"
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.textColor = .darkGray
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.layer.borderWidth = 0.30
       // passwordField.isSecureTextEntry = true
        passwordField.layer.masksToBounds = true
        passwordField.layer.cornerRadius = 5
        return passwordField
    }()
    
    private let loginButton : UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .systemGreen
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Contine", for: .normal)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 5
        return loginButton
    }()
    
    private let createBtn : UIButton = {
        let createBtn = UIButton()
        createBtn.translatesAutoresizingMaskIntoConstraints = false
        createBtn.backgroundColor = .clear
        createBtn.setTitleColor(.blue, for: .normal)
        createBtn.setTitle("Don't have an Account? Create", for: .normal)
        createBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        return createBtn
    }()
    
    private let viewModel = LoginViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(loginLabel)
        view.addSubview(nameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createBtn)
        
        nameField.delegate = self
        passwordField.delegate = self
        
        print(view.frame.height)
        print(view.frame.width)
        
        loginButton.addTarget(self, action: #selector(didtapButton), for: .touchUpInside)
        createBtn.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)
        
        let margins = view.layoutMarginsGuide
        
        loginLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: (view.frame.height)/10).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: (view.frame.height)/34).isActive = true
        
        nameField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: (view.frame.height)/40).isActive = true
        nameField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        nameField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: (view.frame.height)/35).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: (view.frame.height)/58).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: (view.frame.height)/35).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: (view.frame.height)/40).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: (view.frame.width)/2).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: (view.frame.height)/37).isActive = true
        
        createBtn.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: (view.frame.height)/60).isActive = true
        createBtn.widthAnchor.constraint(equalToConstant: (view.frame.width)/1.5).isActive = true
        createBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createBtn.heightAnchor.constraint(equalToConstant: (view.frame.height)/43).isActive = true
     
    }
    
    
    @objc private func didtapButton(){
        print("Button Tapped.....")
        viewModel.email = nameField.text ?? ""
        viewModel.password = passwordField.text ?? ""
        
        viewModel.login{[weak self] (success , errorMessage) in
            guard let self = self else {
                return
            }
            
            if success {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                if let vc = sb.instantiateViewController(identifier: "diningHallViewController") as? diningHallViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }else{
                self.showAlert(title: "Login failed", message: "Please enter valid credentials")
            }
            
        }
        
        
    }
    
    @objc private func signUpBtnTapped(){
        print("Signup Button Tapped......")
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController{
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true, completion: nil)
    }


}

