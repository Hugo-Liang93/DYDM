//
//  PageTitleView.swift
//  DYDM
//
//  Created by 梁文辉 on 2019/4/29.
//  Copyright © 2019 梁文辉. All rights reserved.
//

import UIKit

// 表示只能修饰类
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView: PageTitleView ,selectedIndex : Int)
}

private let kScollLineH : CGFloat = 2

class PageTitleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    weak var delegate : PageTitleViewDelegate?
    
    private var titles : [String]
    private var currentLabelIndex : Int = 0
    lazy private var titlesLabel : [UILabel] = [UILabel]()
    
    // 懒加载属性
    lazy private var scrollView : UIScrollView = {
        let scollView = UIScrollView()
        // scollView.adjustedContentInset
        //scollView.showsHorizontalScrollIndicator = false
        scollView.scrollsToTop = false
        scollView.bounces = false
        return scollView
    }()
    
    // 下面的那条横杠
    lazy private var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        return scrollLine
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    // 如果重写了init(frame） 需要实现init?(coder aDecoder
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //super.init(coder: aDecoder)
        //self.setupUI()
    }
    
}


extension PageTitleView {
    
    private func setupUI() {
        // 添加uiscollvi ew控件最好使用懒加载
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        
        //设置底线和滚动滑块
        setupButtomMenuAndScollLine()
    }
    
    private func setupTitleLabels() {
        // 确定label frame
        let labelW : CGFloat = bounds.width / CGFloat(titles.count)
        let labelH : CGFloat = bounds.height - kScollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            // 修改了
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textAlignment = .center
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titlesLabel.append(label)
            label.isUserInteractionEnabled = true
            let tagGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tagGestureRecognizer)
        }
    }
    
    private func setupButtomMenuAndScollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        guard let fristLabel = titlesLabel.first else {return}
        // 添加scollLine
        scrollView.addSubview(scrollLine)
        
        fristLabel.textColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height - kScollLineH, width: fristLabel.frame.width, height: kScollLineH)
    }
}

extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        guard let currentLabel = tapGes.view as? UILabel else {return}
        let oldLabel = titlesLabel[currentLabelIndex]
        currentLabel.textColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        oldLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        currentLabelIndex = currentLabel.tag
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLabelIndex)
    }
}
