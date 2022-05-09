//
//  MyAuthorizationViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 20/4/2022.
//

import UIKit
import AuthenticationServices

@IBDesignable
class MyAuthorizationAppleIDButton: UIButton, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // unique ID for each user, this uniqueID will always be returned
            let userID = appleIDCredential.user

            // optional, might be nil
            let email = appleIDCredential.email

            // optional, might be nil
            let givenName = appleIDCredential.fullName?.givenName

            // optional, might be nil
            let familyName = appleIDCredential.fullName?.familyName

            // optional, might be nil
            let nickName = appleIDCredential.fullName?.nickname

            /*
                useful for server side, the app can send identityToken and authorizationCode
                to the server for verification purpose
            */
            var identityToken : String?
            if let token = appleIDCredential.identityToken {
                identityToken = String(bytes: token, encoding: .utf8)
            }

            var authorizationCode : String?
            if let code = appleIDCredential.authorizationCode {
                authorizationCode = String(bytes: code, encoding: .utf8)
            }

          // do what you want with the data here
        }
    }
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window!
    }
    

    //var
    private var authorizationButton: ASAuthorizationAppleIDButton!
    
    @IBInspectable
    var cornerRadius: CGFloat = 6.0
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        // Create ASAuthorizationAppleIDButton
        authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
        authorizationButton.cornerRadius = cornerRadius
        // Set selector for touch up inside event so that can forward the event to MyAuthorizationAppleIDButton
        authorizationButton.addTarget(self, action: #selector(authorizationAppleIDButtonTapped(_:)), for: .touchUpInside)
        
        // Show authorizationButton
        addSubview(authorizationButton)

        // Use auto layout to make authorizationButton follow the MyAuthorizationAppleIDButton's dimension
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            authorizationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            authorizationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
            authorizationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
        ])
    }
    @objc func authorizationAppleIDButtonTapped(_ sender: Any) {
        // Forward the touch up inside event to MyAuthorizationAppleIDButton
        sendActions(for: .touchUpInside)
        let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            // request full name and email from the user's Apple ID
            request.requestedScopes = [.fullName, .email]

            // pass the request to the initializer of the controller
            let authController = ASAuthorizationController(authorizationRequests: [request])
          
            // similar to delegate, this will ask the view controller
            // which window to present the ASAuthorizationController
            authController.presentationContextProvider = self
          
              // delegate functions will be called when user data is
            // successfully retrieved or error occured
            authController.delegate = self
            
            // show the Sign-in with Apple dialog
            authController.performRequests()
    }
    
}



