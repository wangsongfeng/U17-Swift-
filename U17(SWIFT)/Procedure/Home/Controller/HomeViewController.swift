//
//  HomeViewController.swift
//  U17(SWIFT)
//
//  Created by apple on 2018/1/26.
//  Copyright © 2018年 yangchao. All rights reserved.
//

import UIKit

class HomeViewController: UPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func configNavigationBar() {
        super.configNavigationBar()
        let image = UIImage.init(named: "nav_search")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: image?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItemStyle.done, target: self, action: #selector(selectAction))
    }
    
    @objc private func selectAction() {
        
    }

}
