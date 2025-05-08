//
//  SignUpViewModel.swift
//  Bing
//
//  Created by Vivek Guntuku on 19/03/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var bNumber: String = ""
    var mobileNumber: String = ""
    
    // MARK: - Validation
    func validateFields() -> (isValid: Bool, errorMessage: String?) {
        // Check if fields are empty
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "Please enter your name")
        }
        
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "Please enter an email address")
        }
        
        if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "Please enter a password")
        }
        
        if confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "Please confirm your password")
        }
        
        if bNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "Please enter your b-number")
        }
        
        if mobileNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "Please enter your mobile number")
        }
        
        // Check if email is valid
        if !isValidEmail(email) {
            return (false, "Please enter a valid email address")
        }
        
        // Check if passwords match
        if password != confirmPassword {
            return (false, "Passwords do not match")
        }
        
        // Check password strength
        if !isStrongPassword(password) {
            return (false, "Password should be at least 8 characters with uppercase, lowercase, and numbers")
        }
        
        // Check if mobile number is valid
        if !isValidMobileNumber(mobileNumber) {
            return (false, "Please enter a valid 10-digit mobile number")
        }
        
        return (true, nil)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@binghamton\\.edu$"
       // let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isStrongPassword(_ password: String) -> Bool {
        // Password should be at least 8 characters with uppercase, lowercase, and numbers
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    private func isValidMobileNumber(_ number: String) -> Bool {
        let mobileRegEx = "^[0-9]{10}$"
        let mobilePred = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return mobilePred.evaluate(with: number)
    }
    
    // MARK: - Firebase Authentication
    func signUp(completion: @escaping (Bool, String?) -> Void) {
        let validationResult = validateFields()
        
        if !validationResult.isValid {
            completion(false, validationResult.errorMessage)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            
            if let error = error {
                // Sign up failed
                completion(false, error.localizedDescription)
                return
            }
            
            guard let user = result?.user else {
                completion(false, "Failed to create user")
                return
            }
            
            // Store additional user details in Firestore
            let userDetails: [String: Any] = [
                "uid": user.uid,
                "name": self.name,
                "email": self.email,
                "bNumber": self.bNumber,
                "mobileNumber": self.mobileNumber,
                "createdAt": Timestamp()
            ]
            
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData(userDetails) { error in
                if let error = error {
                    completion(false, "Failed to save user details: \(error.localizedDescription)")
                } else {
                    completion(true, nil)
                    print("user data Saved Succesfully .....")
                }
            }
        }
    }
}
