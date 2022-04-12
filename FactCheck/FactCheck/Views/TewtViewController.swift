//
//  TewtViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 12/4/2022.
//

import UIKit

class TewtViewController: UIViewController {

    

    @IBOutlet weak var viewForTabBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        designTableTabBar ()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    func designTableTabBar ()
    {
        viewForTabBar.layer.cornerRadius = viewForTabBar.frame.size.height / 2
        
        viewForTabBar.clipsToBounds = true
        
        
    }
    
   
    
    
}
