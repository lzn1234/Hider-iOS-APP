//
//  GuideViewController.swift
//  Voice_copy
//
//  Created by putao on 2022/5/31.
//

import UIKit

class GuideViewController: UIViewController {
    
    let numOfPages = 3
    let currentPageIndex = 1
    var scrollView = UIScrollView()
    
    var imgaeNames = ["guide_bg_1", "guide_bg_2", "guide_bg_3"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        initView()
    }
    
    // 初始化视图
    func initView(){
        
        let screenBounds = UIScreen.main.bounds
        
        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSize(width: screenBounds.width * 3, height: screenBounds.height)
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        
        for i in 0...(numOfPages - 1) {
            var imageView = UIImageView(frame: CGRect(x: screenBounds.width * CGFloat(i), y: 0, width: screenBounds.width, height: screenBounds.height))
            imageView.image = UIImage(named: self.imgaeNames[i])
            scrollView.addSubview(imageView)
            
        }
    }
}
