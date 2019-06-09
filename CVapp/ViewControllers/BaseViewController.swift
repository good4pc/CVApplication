//
//  BaseViewController.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

protocol MenuButtonDelegate: NSObjectProtocol {
    func toggleMenuBar()
}

class BaseViewController: UIViewController,MenuButtonDelegate,MenuViewControlDelegate {
    
    var menuViewController: MenuViewController!
    var centerController: UIViewController!
    var cvViewController: CVViewController!
    var isExpanded: Bool = false
    fileprivate func addMainViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        cvViewController = storyBoard.instantiateViewController(withIdentifier: "CVViewController") as? CVViewController
        centerController = UINavigationController(rootViewController: cvViewController)
        cvViewController.delegate = self
        self.view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    override func viewDidLoad() {
        addMainViewController()
        if menuViewController == nil {
            menuViewController = MenuViewController()
            menuViewController.delegate = self
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
        }
        
    }
    
    func closeView(with rowSelected: Int) {
        switch rowSelected {
        case 0 :
            cvViewController.reloadView(viewShowingType: .PersonalDetails)
        case 1:
            cvViewController.reloadView(viewShowingType: .ProjectsHandled)
        case 2:
            cvViewController.reloadView(viewShowingType: .AcademicQualification)
        case 3:
            cvViewController.reloadView(viewShowingType: .References)
        default:
             cvViewController.reloadView(viewShowingType: .PersonalDetails)
        }
        toggleMenuBar()
    }
    
    func toggleMenuBar() {
        
        if !isExpanded {
            UIView.animate(withDuration: menuBarAnimationSpeed) {
                self.centerController.view.frame.origin.x = self.view.frame.size.width - 100
            }
        }
        else {
            UIView.animate(withDuration: menuBarAnimationSpeed) {
                self.centerController.view.frame.origin.x = 0
            }
        }
        isExpanded = !isExpanded
        
    }
}
