//
//  SideMenuMainContainerView.swift
//  SideMenu
//
//  Created by Indrajit-mac on 09/05/19.
//  Copyright © 2019 Indrajit. All rights reserved.
//

import UIKit

class SideMenu:UIViewController{
    enum SlideOutState {
        case bothCollapsed
        case leftPanelExpanded
        case rightPanelExpanded
    }
    
    
    var centerNavigationController: UINavigationController?
    var leftViewController: SideMenuLeftRightView?
    var rightViewController: SideMenuLeftRightView?
    var enableSwipeToOpen:Bool = true
    let sizeMenuWidth: CGFloat = 200
    var currentState: SlideOutState = .bothCollapsed
    
    fileprivate lazy var disableView:UIView={
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.rightPanGestireRecogizer))
        rightGesture.direction = .right
        view.addGestureRecognizer(rightGesture)
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.leftPanGestireRecogizer))
        leftGesture.direction = .left
        view.addGestureRecognizer(leftGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureRecognzer))
        view.addGestureRecognizer(tapGesture)
        
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if let centerNavigation = centerNavigationController,let centerNavigationView = centerNavigation.view{
            
            
            
            self.view.addSubview(centerNavigationView)
            addChild(centerNavigation)
            centerNavigation.didMove(toParent: self)
            
            if let leftView = leftViewController,let leftViewView = leftView.view{
                centerNavigationView.addSubview(leftViewView)
                addChild(leftView)
                leftView.didMove(toParent: self)
                
                leftViewView.translatesAutoresizingMaskIntoConstraints = false
                leftViewView.topAnchor.constraint(equalTo: centerNavigationView.topAnchor, constant: 0).isActive = true
                leftViewView.bottomAnchor.constraint(equalTo: centerNavigationView.bottomAnchor, constant: 0).isActive = true
                leftViewView.rightAnchor.constraint(equalTo: centerNavigationView.leftAnchor, constant: 0).isActive = true
                leftViewView.widthAnchor.constraint(equalToConstant: self.sizeMenuWidth).isActive = true
         
            }
            
            if let rightView = rightViewController,let rigtViewView = rightView.view{
                centerNavigationView.addSubview(rigtViewView)
                addChild(rightView)
                rightView.didMove(toParent: self)
                
                rigtViewView.translatesAutoresizingMaskIntoConstraints = false
                rigtViewView.topAnchor.constraint(equalTo: centerNavigationView.topAnchor, constant: 0).isActive = true
                rigtViewView.bottomAnchor.constraint(equalTo: centerNavigationView.bottomAnchor, constant: 0).isActive = true
                rigtViewView.leftAnchor.constraint(equalTo: centerNavigationView.rightAnchor, constant: 0).isActive = true
                rigtViewView.widthAnchor.constraint(equalToConstant: self.sizeMenuWidth).isActive = true
              
                
            }
          
            if enableSwipeToOpen{
                let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.leftPanGestireRecogizer))
                leftGesture.direction = .left
                centerNavigationView.addGestureRecognizer(leftGesture)
                
                let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.rightPanGestireRecogizer))
                rightGesture.direction = .right
                centerNavigationView.addGestureRecognizer(rightGesture)
            }
            
        }
        
        
        
    }
    
    
    
   fileprivate func manageLeftSideMenuVisibility(show:Bool){
        if let _value = centerNavigationController?.view,let leftView = leftViewController,let leftViewView = leftView.view,let appDelegate = UIApplication.shared.delegate as? AppDelegate,let window = appDelegate.window{
            self.currentState = show ? .leftPanelExpanded : .bothCollapsed
            if show{
               
                window.addSubview(disableView)
                disableView.topAnchor.constraint(equalTo: window.topAnchor, constant: 0).isActive = true
                disableView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0).isActive = true
                disableView.leftAnchor.constraint(equalTo: leftViewView.rightAnchor, constant: 0).isActive = true
                disableView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            }
            
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                _value.frame.origin.x = show ? self.sizeMenuWidth : 0
            }, completion: { (bool) in
          
                if bool,!show{
                    self.disableView.removeFromSuperview()
                }
            })
            
        }
        
    }
    
 
   fileprivate func manageRightSideMenuVisibility(show:Bool){
        self.currentState = show ? .rightPanelExpanded : .bothCollapsed
        if let _value = centerNavigationController?.view,let rightView = rightViewController,let rigtViewView = rightView.view,let appDelegate = UIApplication.shared.delegate as? AppDelegate,let window = appDelegate.window{
            
            if show{
                if show{
                    rigtViewView.addSubview(disableView)
                    disableView.topAnchor.constraint(equalTo: window.topAnchor, constant: 0).isActive = true
                    disableView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0).isActive = true
                    disableView.rightAnchor.constraint(equalTo: rigtViewView.leftAnchor, constant: 0).isActive = true
                    disableView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
             
                }
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                _value.frame.origin.x = show ? -self.sizeMenuWidth : 0
               
            }, completion: { (bool) in
                if bool,!show{
                    self.disableView.removeFromSuperview()
                }
            })
            
          
        }
        
    }
    
    @objc fileprivate func leftPanGestireRecogizer(gesture:UISwipeGestureRecognizer){
        if self.currentState == .bothCollapsed{
            self.manageRightSideMenuVisibility(show: true)
         }else if self.currentState == .leftPanelExpanded{
            self.manageLeftSideMenuVisibility(show: false)
        }
        
    }
    
    @objc fileprivate func rightPanGestireRecogizer(gesture:UISwipeGestureRecognizer){
        if self.currentState == .bothCollapsed{
            self.manageLeftSideMenuVisibility(show: true)
        }else if self.currentState == .rightPanelExpanded{
            self.manageRightSideMenuVisibility(show: false)
        }
    }
    
    @objc fileprivate func tapGestureRecognzer(gesture:UITapGestureRecognizer){
        self.hide()
    }
    
    
    
    func showLeftSide(){
        self.manageLeftSideMenuVisibility(show: true)
    }
    func showRightSide(){
        self.manageRightSideMenuVisibility(show: true)
    }
    func hide(){
        self.manageRightSideMenuVisibility(show: false)
        self.manageLeftSideMenuVisibility(show: false)
    }
    
}

class SideMenuLeftRightView: UIViewController {
    
}

