//
//  UNavigationController.swift
//  U17(SWIFT)
//
//  Created by apple on 2018/2/7.
//  Copyright © 2018年 yangchao. All rights reserved.
//

import UIKit

class UNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取系统的 侧滑返回的支持
        guard let interactionGes = interactivePopGestureRecognizer else {
            return
        }
        
        guard let targetView = interactionGes.view else {
            return
        }
        
        guard let internalTargets = interactionGes.value(forKeyPath: "targets") as? [NSObject] else {
            return
        }
        
        guard let internalTarget = internalTargets.first?.value(forKey: "target") else {
            return
        }

        let action = Selector(("handleNavigationTransition:"))
        
        let fullScreenGesture = UIPanGestureRecognizer.init(target: internalTarget, action: action)
        fullScreenGesture.delegate = self
        
        targetView.addGestureRecognizer(fullScreenGesture)
        
        interactionGes.isEnabled = false
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
}
extension UNavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = topViewController else { return .lightContent }
        return topVC.preferredStatusBarStyle
    }
}
extension UNavigationController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count != 1 && (value(forKey: "_isTransitioning") as? Bool)!
    }
}

//设置全局的 导航控制器的导航栏样式

enum UNavigationBarStyle {
    case theme
    case clear
    case white
}

extension UINavigationController {
    func barStyle(style : UNavigationBarStyle) -> Void {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage.init(named: "nav_bg"), for: .default)
            navigationBar.shadowImage = UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .white:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIColor.white.imageColor(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
    }
}




