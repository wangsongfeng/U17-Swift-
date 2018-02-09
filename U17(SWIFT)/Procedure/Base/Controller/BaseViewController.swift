//
//  BaseViewController.swift
//  U17(SWIFT)
//
//  Created by apple on 2018/2/8.
//  Copyright © 2018年 yangchao. All rights reserved.
//

import UIKit
import SnapKit
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        //拒绝系统自动给scrollView 布局，当有导航栏或tabbar时候，

        if #available(iOS 11.0, *){
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    func configUI() -> () {
        
    }
    
    func configNavigationBar() -> Void {
        guard let navi = navigationController else {
            return
        }
        if navi.visibleViewController == self {
            navi.barStyle(style: .theme)
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "nav_back_white"), style: UIBarButtonItemStyle.done, target: self, action: #selector(pressBack))
            }
        }
    }
    
    @objc func pressBack() -> Void {
        navigationController?.popViewController(animated: true)
    }
    
}

extension BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}



