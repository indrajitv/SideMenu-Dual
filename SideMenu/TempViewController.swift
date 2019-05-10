//
//  ViewController.swift
//  SideMenu
//
//  Created by Indrajit-mac on 09/05/19.
//  Copyright © 2019 Indrajit. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

    lazy var button:UIButton={
        let button = UIButton(type: .system)
        button.setTitle("Open", for: .normal)
        button.addTarget(self, action: #selector(self.buttonSideMenuClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        
        
        self.view.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = self.view.center
        
        
        let sideMenu = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(self.openSideMenu))
        navigationItem.leftBarButtonItem = sideMenu
        
    }
    
    
    
    @IBAction func buttonSideMenuClicked(_ sender: UIButton) {
        
        self.navigationController?.pushViewController(TempViewController1(), animated: true)
        
    }
    

    
    
    @objc func openSideMenu(){
        if let delegate = UIApplication.shared.delegate as? AppDelegate{
            delegate.sideMenu?.showLeftSide()
            
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
                delegate.sideMenu?.hide()
            }
        }
    }

}



class TempViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray
    }

}

