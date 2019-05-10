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
        button.backgroundColor = .blue
        return button
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        
        
        
        let sideMenu = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(self.openSideMenu))
        navigationItem.leftBarButtonItem = sideMenu
        
        
        self.view.addSubview(button)
        button.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
      
        
    }
    
    
    
    @IBAction func buttonSideMenuClicked(_ sender: UIButton) {
        
        self.navigationController?.pushViewController(TempViewController1(), animated: true)
        
    }
    

    
    
    @objc func openSideMenu(){
        if let delegate = UIApplication.shared.delegate as? AppDelegate{
            delegate.sideMenu?.showLeftSide()
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

