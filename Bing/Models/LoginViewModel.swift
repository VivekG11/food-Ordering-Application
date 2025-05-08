//
//  LoginViewModel.swift
//  Bing
//
//  Created by Vivek Guntuku on 19/03/25.
//
import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel {
    
    var email : String = ""
    var password : String = ""
    
    func validateFields() ->(isValid : Bool , errorMessage : String?){
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "please enter an email address")
        }
        
        if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return(false, "please enter a password")
        }
        
        if !isValidEmail(email){
            return(false, "please enter a valid email address")
        }
        
        return(true,nil)
        
    }
    
    private func isValidEmail(_ email: String) -> Bool{
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@binghamton\\.edu$"
       // let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        
    }
    
    func login(completion: @escaping (Bool, String?) -> Void){
        let validationResult = validateFields()
        
        if !validationResult.isValid {
                   completion(false, validationResult.errorMessage)
                   return
               }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error{
                completion(false, error.localizedDescription)
                return
            }
            
            completion(true, nil)
            
        }
    }
}
