//
//  PageTitleView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 06/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleViewIndex(titleView: PageTitleView,selectedIndex index: Int)
}

let kScrollLineH:CGFloat = 2

class PageTitleView: UIView {
    
    //MARK:- 定义属性
    private var titles : [String]
    private var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    //MARK:- 懒加载
    private lazy var titleLabels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        return scrollView
    }()
    
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.red
        return scrollLine
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect,titles:[String] ){
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    private func setupUI(){
        //1. 添加uiscollview
        self.addSubview(scrollView)
        scrollView.frame = bounds
        
        //2. 添加label
        setupTitleLabels()
        
        //3. 设置底线和滚动滑块
        setupLine()
    }
    
    private func setupTitleLabels(){
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 15.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2. 添加scrollline
        //获取第一label
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.red
        
        //设置scrollline属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK:- 监听点击
extension PageTitleView{
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        //1. 获取当前label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        //2. 获取之前label，并保存最新下标
        let exLabel = titleLabels[currentIndex]
        currentIndex = currentLabel.tag
        
        //3. 改变字体颜色
        exLabel.textColor = UIColor.darkGray
        currentLabel.textColor = UIColor.red
        
        //4. 滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })

        //5. 通知代理
        delegate?.pageTitleViewIndex(titleView: self, selectedIndex: currentIndex)
        
    }
}

//MARK:- 对外暴露方法
extension PageTitleView{
    func setPageTitleView(lineOffsetX: CGFloat, newLabelIndex: Int){
        scrollLine.frame.origin.x = lineOffsetX
        if newLabelIndex != currentIndex{
            let newLabel = titleLabels[newLabelIndex]
            let exLabel = titleLabels[currentIndex]
            currentIndex = newLabel.tag
            newLabel.textColor = UIColor.red
            exLabel.textColor = UIColor.darkGray
        }
    }
}











