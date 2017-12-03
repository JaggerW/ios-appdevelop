//
//  Banner.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 30/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class Banner: UIView {
    
    private var images: [String]
    private var timer: Timer!
    private var pagecontrol = UIPageControl()
    
//MARK:- 懒加载
    //懒加载scrollview
    private lazy var scrollView: UIScrollView = {
        let rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let scrollView = UIScrollView(frame: rect)
        scrollView.showsHorizontalScrollIndicator = false
        //scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(images.count), height: scrollView.frame.height)
        scrollView.delegate = self
        return scrollView
        
    }()
    
    
//MARK:- 自定义构造函数
    init(frame: CGRect,images: [String]) {
        self.images = images
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- 设置UI
extension Banner {
    private func setupUI(){
        //1. 添加scrollview
        self.addSubview(scrollView)
        
        //2. 添加image
        imagescrollinit()
        
        //3. 添加pagecontrol
        setupPagecontrol()
        
        //4. 配置scrollview自动翻页
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.autoscroll), userInfo: nil, repeats: true)
        setpriority()
    }
    
    //设置pagecontrol
    private func setupPagecontrol(){
        let rect = CGRect(x: self.frame.width / 2, y: scrollView.frame.height / 5 * 4, width: 0, height: scrollView.frame.height / 4)
        pagecontrol = UIPageControl(frame: rect)
        pagecontrol.currentPage = 0
        pagecontrol.numberOfPages = images.count
        pagecontrol.currentPageIndicatorTintColor = UIColor.white
        pagecontrol.pageIndicatorTintColor = UIColor.lightGray
        self.addSubview(pagecontrol)
    }
    //设置image
    private func imagescrollinit(){
        
        for i in 0...(images.count - 1){
            let x = CGFloat(i) * scrollView.frame.width
            let rect = CGRect(x: x, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            let image = UIImageView(frame: rect)
            image.image = UIImage(named: images[i])
            scrollView.addSubview(image)
        }
    }
    //自动翻页函数
    @objc func autoscroll(){
        
        var page:Int = pagecontrol.currentPage
        if page == images.count - 1{
            page = 0
        }
        else{
            page += 1
        }
        let offsetx = CGFloat(page) * scrollView.frame.size.width
        let offset = CGPoint(x: offsetx, y: 0)
        scrollView.setContentOffset(offset, animated: true)
        
    }
    
    //设置pagecontrol页码
    private func pagenumctrl(){
        var offsetx = scrollView.contentOffset.x
        offsetx += scrollView.frame.size.width / 2
        let num = offsetx / scrollView.frame.size.width
        pagecontrol.currentPage = Int(num)
    }
    
    private func setpriority(){
        //获取当前的消息循环对象
        let runloop:RunLoop = RunLoop.current
        runloop.add(timer, forMode: RunLoopMode.commonModes)
        
    }
    
}

//MARK:- 设置scrollview的delegate
extension Banner: UIScrollViewDelegate{
    //scroll delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pagenumctrl()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //开始拖拽时停止计时器，该计时器即被丢弃
        timer!.invalidate()
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //拖拽结束后开启一个新的定时器
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(Banner.autoscroll), userInfo: nil, repeats: true)
        setpriority()
    }
}

























