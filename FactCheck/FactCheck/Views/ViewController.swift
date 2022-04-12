//
//  ViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 12/4/2022.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    let animatinView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetupAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            
              self.performSegue(withIdentifier: "leadingToOnboarding", sender: self)
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

