//
//  ViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 12/4/2022.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    
    let animatinView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetupAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            if (UserDefaults.standard.string(forKey: "role")=="Personal" && UserDefaults.standard.string(forKey: "remrberMe") == "true"){
                print("personnel")
                self.performSegue(withIdentifier: "HomeFactCheckSeguePersonal", sender: nil)
            }else if(UserDefaults.standard.string(forKey: "role")=="Agency" && UserDefaults.standard.string(forKey: "remrberMe") == "true"){
                self.performSegue(withIdentifier: "HomeFactCheckSegueAgency", sender: nil)
            }else {
              self.performSegue(withIdentifier: "leadingToOnboarding", sender: self)
         }
        })
    }

    private func SetupAnimation(){
        animatinView.animation = Animation.named("loading screen")
        animatinView.frame = CGRect(x: 0, y: 0, width: 280, height: 250)
        animatinView.center = view.center
        animatinView.contentMode = .scaleAspectFit
        animatinView.loopMode = .loop
        animatinView.play()
        view.addSubview(animatinView)
    }
    
    //ibAction
    
}

