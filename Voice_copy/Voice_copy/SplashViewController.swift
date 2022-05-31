//
//  SplashViewController.swift
//  Voice_copy
//
//  Created by putao on 2022/5/31.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        checkTerm()
    }
    
    func checkTerm() {
        let guideVC = GuideViewController()
        guideVC.modalPresentationStyle = .fullScreen
        self.present(guideVC, animated: true)
    }
}
