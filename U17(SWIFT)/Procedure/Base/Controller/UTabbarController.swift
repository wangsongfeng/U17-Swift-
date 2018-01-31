//
//  UTabbarController.swift
//  U17(SWIFT)
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 yangchao. All rights reserved.
//

import UIKit

class UTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        let HomeControl = HomeViewController()
        
        addChildViewController(HomeControl, title: "首页", image: UIImage.init(named: "tab_home"), selecteImage: UIImage.init(named: "tab_home_S"))
        /// 分类
        let classVC = CateListController()
        addChildViewController(classVC, title: "分类", image: UIImage(named: "tab_class"), selecteImage: UIImage(named: "tab_class_S"))
        /// 书架
        let bookVC = BooksController()
        addChildViewController(bookVC, title: "书架", image: UIImage(named: "tab_book"), selecteImage: UIImage(named: "tab_book_S"))
        /// 我的
        let mineVC = MineController()
        addChildViewController(mineVC, title: "我的", image:  UIImage(named: "tab_mine"), selecteImage: UIImage(named: "tab_mine_S"))
    }
    
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage?, selecteImage:UIImage?) -> Void {
        childController.title = title
        childController.tabBarItem = UITabBarItem.init(title: nil, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selecteImage?.withRenderingMode(.alwaysOriginal))
        
        //判断机型 .phone .pad
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        addChildViewController(childController)
    }
    
    
   
}

//extension UTabbarController {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        guard let select = selectedViewController else { return .lightContent }
//        return select.preferredStatusBarStyle
//    }
//}


