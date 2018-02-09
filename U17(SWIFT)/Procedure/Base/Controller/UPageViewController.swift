//
//  UPageViewController.swift
//  U17(SWIFT)
//
//  Created by apple on 2018/2/8.
//  Copyright © 2018年 yangchao. All rights reserved.
//

import UIKit
import HMSegmentedControl

enum UPageStyle {
    case none
    case navigationBarSegment
    case topTabBar
}

class UPageViewController: BaseViewController {
    
    var pageStyle : UPageStyle!
    
    
//上边分页器
    lazy var segmented : HMSegmentedControl = {
       let segmented = HMSegmentedControl()
        segmented.addTarget(self, action:#selector(segmentControllChange(segment:)), for: .valueChanged)
        return segmented
    }()
    
    lazy var pageVC : UIPageViewController = {
       let pageVC = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageVC
    }()
    
    private var vcs : [UIViewController]!
    private var titles : [String]!
    private var currentSelectIndex : Int = 0
    
    convenience init(titles:[String]=[], vcs:[UIViewController]=[],pageStyle:UPageStyle = .none){
        self.init()
        self.titles = titles
        self.vcs = vcs
        self.pageStyle = pageStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func segmentControllChange(segment:HMSegmentedControl){
        let index = segment.selectedSegmentIndex
        if currentSelectIndex != index {
            let target:[UIViewController] = [vcs[index]]
            let direction:UIPageViewControllerNavigationDirection = currentSelectIndex > index ? .reverse : .forward
            pageVC.setViewControllers(target, direction: direction, animated: false) { [weak self] (finish) in
                self?.currentSelectIndex = index
            }
        }
    }
    
    override func configUI() {
        guard let _:[UIViewController] = vcs else {
            return
        }
        addChildViewController(pageVC)
        view.addSubview(pageVC.view)
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.setViewControllers([vcs[0]], direction: .forward, animated: false, completion: nil)
        switch pageStyle {
        case .none:
//让当前视图 的 上下左右(top,left,bottom,right) 等于 Superview
            pageVC.view.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        case .navigationBarSegment:
            segmented.backgroundColor = UIColor.clear
            segmented.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white.withAlphaComponent(0.5),NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
            segmented.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
            segmented.selectionIndicatorLocation = .none
            navigationItem.titleView = segmented
            segmented.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 120, height: 40)
            pageVC.view.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        case .topTabBar:
            segmented.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                           NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
            segmented.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.init(red: 127/255.0, green: 221/255.0, blue: 146/255.0, alpha: 1),
                                                   NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
            segmented.selectionIndicatorLocation = .down
            segmented.selectionIndicatorColor = UIColor.init(red: 127/255.0, green: 221/255.0, blue: 146/255.0, alpha: 1)
            segmented.selectionIndicatorHeight = 2
            segmented.borderType = .bottom
            segmented.borderColor = UIColor.lightGray
            segmented.borderWidth = 0.5
            
            view.addSubview(segmented)
            segmented.snp.makeConstraints{
                $0.top.left.right.equalToSuperview()
                $0.height.equalTo(40)
            }
            
            pageVC.view.snp.makeConstraints{
                $0.top.equalTo(segmented.snp.bottom)
                $0.left.right.bottom.equalToSuperview()
            }
        default:
            break
        }
        guard let titles = titles else {
            return
        }
        segmented.sectionTitles = titles
        currentSelectIndex = 0
        segmented.selectedSegmentIndex = currentSelectIndex
    }

}


extension UPageViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    //上一页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.index(of: viewController) else {
            return nil
        }
        let beforeIndex = index - 1
        guard beforeIndex>0  else {
            return nil
        }
        return vcs[beforeIndex]
    }
    //下一页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.index(of: viewController) else {
            return nil
        }
        let afterIndex = index + 1
        guard afterIndex <= vcs.count-1  else {
            return nil
        }
        return vcs[afterIndex]
    }
    //结束
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewcontroller = pageViewController.viewControllers?.last,
            let index = vcs.index(of: viewcontroller) else {
            return
        }
        currentSelectIndex = index
        segmented.setSelectedSegmentIndex(UInt(index), animated: true)
        guard titles != nil && pageStyle == .none else { return }
        navigationItem.title = titles[index]
    }
}







