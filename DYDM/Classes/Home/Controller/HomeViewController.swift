//
//  HomeViewController.swift
//  DYDM
//
//  Created by 梁文辉 on 2019/4/29.
//  Copyright © 2019 梁文辉. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40
private let titles = ["前期检查","促排","取卵移植","保胎"]

class HomeViewController: UIViewController {
    
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        // 1. 确定 内容的frame
        // 2. 确定 子控制器
        let contentH : CGFloat =  (kScreenH - kStatusBarH - kNavigationBarH) / 3
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height:  contentH)
        var childVC = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVC.append(vc)
        }
        let pageContentView = PageContentView(frame: contentFrame, childVCs: childVC, parentVC: self)
        
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func sgm_safeAreaInset(uiview: UIView) ->  UIEdgeInsets {
        return view.safeAreaInsets;
    }
    
}

// MARK: -- 设置UI界面
extension HomeViewController{
    private func setupUI() {
        // 设置导航栏
        setupNavigationBar()
        print(view.safeAreaInsets)
        // 添加titleView
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        //1.设置左侧
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "sign_login")
        //2.设置右侧
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "circle_icon_right")
        //3.设置中间
        navigationItem.titleView = UISearchBar(frame:CGRect(x:0,y:0,width:180,height:30))
        //4.设置导航栏颜色
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
}

extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        pageContentView.setCurrentIndex(currentIndex: selectedIndex)
    }
}


