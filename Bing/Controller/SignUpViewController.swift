//
//  SignUpViewController.swift
//  Bing
//
//  Created by Vivek Guntuku on 06/03/25.
//
import UIKit

class SignUpViewController : UIViewController {
    
    private let signUpLabel : UILabel = {
        let signUpLabel = UILabel()
        signUpLabel.text = "REGISTER"
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.textAlignment = .center
       // signUpLabel.layer.borderColor = UIColor.black.cgColor
       // signUpLabel.layer.borderWidth = 1
        signUpLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        signUpLabel.adjustsFontForContentSizeCategory = true
        return signUpLabel
    }()
    
    private let nameField : UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Enter Full Name"
        nameField.textColor = .darkGray
        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.layer.borderWidth = 0.3
        nameField.layer.masksToBounds = true
        nameField.layer.cornerRadius = 5
        return nameField
    }()
    
    private let bNumField : UITextField = {
        let bNumField = UITextField()
        bNumField.translatesAutoresizingMaskIntoConstraints = false
        bNumField.placeholder = "Enter B-Number"
        bNumField.textColor = .darkGray
        bNumField.layer.borderColor = UIColor.black.cgColor
        bNumField.layer.borderWidth = 0.3
        bNumField.layer.masksToBounds = true
        bNumField.layer.cornerRadius = 5
        return bNumField
    }()
    
    private let mobileNumField : UITextField = {
        let mobileNumField = UITextField()
        mobileNumField.translatesAutoresizingMaskIntoConstraints = false
        mobileNumField.placeholder = "Enter Mobile Number"
        mobileNumField.textColor = .darkGray
        mobileNumField.layer.borderColor = UIColor.black.cgColor
        mobileNumField.layer.borderWidth = 0.3
        mobileNumField.layer.masksToBounds = true
        mobileNumField.layer.cornerRadius = 5
        return mobileNumField
    }()
    
    private let emailField : UITextField = {
        let emailField = UITextField()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.placeholder = "Enter Email"
        emailField.textColor = .darkGray
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.layer.borderWidth = 0.3
        emailField.layer.masksToBounds = true
        emailField.layer.cornerRadius = 5
        return emailField
    }()
    
    private let passwordField : UITextField = {
        let passwordField = UITextField()
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.placeholder = "Enter Password"
        passwordField.textColor = .darkGray
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.layer.borderWidth = 0.3
        passwordField.layer.masksToBounds = true
        passwordField.layer.cornerRadius = 5
        return passwordField
    }()
    
    private let confirmPwdField : UITextField = {
        let confirmPwdField = UITextField()
        confirmPwdField.translatesAutoresizingMaskIntoConstraints = false
        confirmPwdField.placeholder = "Confirm Password"
        confirmPwdField.textColor = .darkGray
        confirmPwdField.layer.borderColor = UIColor.black.cgColor
        confirmPwdField.layer.borderWidth = 0.3
        confirmPwdField.layer.masksToBounds = true
        confirmPwdField.layer.cornerRadius = 5
        return confirmPwdField
    }()
    
    private let signUpButton : UIButton = {
        let signUpButton = UIButton()
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.backgroundColor = .systemGreen
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.setTitle("Sign-Up", for: .normal)
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = 5
        return signUpButton
    }()
    
    
    private let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        
        view.addSubview(signUpLabel)
        view.addSubview(nameField)
        view.addSubview(bNumField)
        view.addSubview(mobileNumField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmPwdField)
        view.addSubview(signUpButton)
        
        
        signUpButton.addTarget(self, action: #selector(signUpBtnAction), for: .touchUpInside)
        
        signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height)/8).isActive = true
        signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpLabel.widthAnchor.constraint(equalToConstant: (view.frame.width)/2).isActive = true
        signUpLabel.heightAnchor.constraint(equalToConstant: (view.frame.height)/34).isActive = true
        
        nameField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: (view.frame.height)/10).isActive = true
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.widthAnchor.constraint(equalToConstant: (view.frame.width)/1.150).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: (view.frame.height)/34).isActive = true
        
        bNumField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: (view.frame.height)/40).isActive = true
        bNumField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bNumField.widthAnchor.constraint(equalToConstant: (view.frame.width)/1.150).isActive = true
        bNumField.heightAnchor.constraint(equalToConstant: (view.frame.height)/34).isActive = true
        
        mobileNumField.topAnchor.constraint(equalTo: bNumField.bottomAnchor, constant: (view.frame.height)/40).isActive = true
        mobileNumField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mobileNumField.widthAnchor.constraint(equalToConstant: (view.frame.width)/1.150).isActive = true
        mobileNumField.heightAnchor.constraint(equalToConstant: (view.frame.height)/34).isActive = true
        
        emailField.topAnchor.constraint(equalTo: mobileNumField.bottomAnchor, constant: (view.frame.height)/40).isActive = true
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: (view.frame.width)/1.150).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: (view.frame.height)/34).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: (view.frame.height)/40).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: (view.frame.width)/1.150).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: (view.frame.height)/34).isActive = true
        
        confirmPwdField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: (view.frame.height)/40).isActive = true
        confirmPwdField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmPwdField.widthAnchor.constraint(equalToConstant: (view.frame.width)/1.150).isActive = true
        confirmPwdField.heightAnchor.constraint(equalToConstant: (view.frame.height)/34).isActive = true
        
        signUpButton.topAnchor.constraint(equalTo: confirmPwdField.bottomAnchor, constant: (view.frame.height)/10).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: (view.frame.width)/2).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: (view.frame.height)/30).isActive = true
        
        
    }
    
    @objc func signUpBtnAction(){
        viewModel.name = nameField.text ?? ""
        viewModel.bNumber = bNumField.text ?? ""
        viewModel.mobileNumber = mobileNumField.text ?? ""
        viewModel.email = emailField.text ?? ""
        viewModel.password = passwordField.text ?? ""
        viewModel.confirmPassword = confirmPwdField.text ?? ""
        
        
        viewModel.signUp{ [weak self] (success, errorMessage) in
            guard let self = self else {return}
            
            if success{
                self.showAlert(title: "Success", message: "Account created successfully")
                self.navigationController?.popViewController(animated: true)
            }else {
                self.showAlert(title: "SignUP failed", message: errorMessage ?? "Unknown error occured")
            }
            
        }
        
        
        if let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController {
           // navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen
           // navigationController?.present(vc, animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true, completion: nil)
    }
    
}
