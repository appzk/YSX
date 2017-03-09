//
//  WPSegmentedControl.swift
//  Wallpaper
//
//  Created by Lib on 2017/1/23.
//  Copyright © 2017年 adirects. All rights reserved.
//

import UIKit

@objc public protocol LBSegmentedControlDelegate: NSObjectProtocol {
    /// item 被点击
    @objc optional func segmentedControl(segment: LBSegmentedControl, didSelectedItem count: Int) -> Void
}

public class LBSegmentedControl: UIView {
    
    // 动画时长
    fileprivate let duration: TimeInterval = 0.5
    
    // MARK:    -- variable --
    /// 指示器高度
    fileprivate let promptH: CGFloat = 2
    /// Tag值
    fileprivate let kTag: Int = 2000
    
    // MARK:    -- property --
    /// 指示器
    fileprivate var promptView: UIView!
    /// 代理
    weak var delegate: LBSegmentedControlDelegate?
    
    fileprivate var _selectedColor: UIColor = UIColor.init(red: 40 / 255, green: 150 / 255, blue: 200 / 255, alpha: 1)
    /// 选中颜色
    var selectedColor: UIColor {
        get {
            return _selectedColor
        }
        set {
            _selectedColor = newValue
            setup()
        }
    }
    
    fileprivate var _items:Array<String> = []
    /// item
    var items: Array<String> {
        get {
            return _items;
        }
        set {
            _items = newValue
            setup()
        }
    }
    
    // MARK:    -- init --
    init(frame: CGRect, items: Array<String>) {
        super.init(frame: frame)
        self.items = items
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK:    -- setup --
    fileprivate func setup() -> Void {
        if items == [] {return}
        
        // 清除subViews
        for view in subviews {
            view.removeFromSuperview()
        }
        
        for idx in 0 ... items.count - 1 {
            let width = self.frame.size.width
            let itemW = width / CGFloat(items.count)
            let height = self.frame.size.height - promptH
            
            let itemBtn = UIButton.init(frame: CGRect.init(x: CGFloat(idx) * itemW, y: 0, width: itemW, height: height))
            itemBtn.setTitle(items[idx], for: UIControlState.normal)
            itemBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            itemBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
            itemBtn.setTitleColor(selectedColor, for: UIControlState.selected)
            itemBtn.addTarget(self, action: #selector(btnClick(btn:)), for: UIControlEvents.touchUpInside)
            if idx == 0 {
                itemBtn.isSelected = true
                let maxY = itemBtn.frame.origin.y + itemBtn.frame.size.height
                
                promptView = UIView.init(frame: CGRect.init(x: 0, y: maxY, width: itemW, height: promptH))
                promptView?.backgroundColor = selectedColor
            }
            
            itemBtn.tag = kTag + idx
            
            addSubview(itemBtn)
            addSubview(promptView!)
        }
    }
    
    // MARK:    -- tapAction --
    @objc fileprivate func btnClick(btn: UIButton) -> Void {
        
        for idx in 0 ... subviews.count - 1 {
            if subviews[idx] == promptView {
                return
            }
            let view = subviews[idx] as! UIButton
            if btn == view {
                btn.isSelected = true
                promptViewAnimate(btn: btn, promptFrame: (self.promptView?.frame)!)
            }else {
                view.isSelected = false
            }
            if idx == 0 {
                delegate?.segmentedControl!(segment: self, didSelectedItem: btn.tag - kTag)
            }
        }
    }

    // MARK:    -- 指示器动画 --
    fileprivate func promptViewAnimate(btn: UIButton, promptFrame: CGRect) -> Void {
        // 改变指示器位置
        var width: CGFloat?
        var x: CGFloat?
        
        let newX = btn.frame.origin.x
        let oldX = promptFrame.origin.x
        
        if newX > oldX {
            x = oldX
            width = newX + btn.frame.size.width - x!
            
        }else if newX < oldX {
            x = newX
            width = oldX + promptFrame.size.width - x!
        }else {
            width = btn.frame.size.width
            x = newX
        }
        let maxY = btn.frame.origin.y + btn.frame.size.height
        UIView.animate(withDuration: duration, animations: {
            
            self.promptView?.frame = CGRect.init(x: x!, y: maxY, width: width!, height: self.promptH)
        }) { (isAnimations) in
            self.promptView?.frame = CGRect.init(x: newX, y: maxY, width: btn.frame.size.width, height: self.promptH)
        }
        
    }
    
    /// 更新指示器
    /// :param: index -- 更新到的Item的编号
    public func updatePromptView(count: Int) -> Void {
        let btn = viewWithTag(count + kTag) as! UIButton
        btnClick(btn: btn)
    }
}
