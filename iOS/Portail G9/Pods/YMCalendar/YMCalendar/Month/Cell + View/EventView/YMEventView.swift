//
//  YMEventView.swift
//  YMCalendar
//
//  Created by Yuma Matsune on 2017/03/06.
//  Copyright © 2017年 Yuma Matsune. All rights reserved.
//

import Foundation
import UIKit

open class YMEventView: UIView, ReusableObject {
    
    public var reuseIdentifier: String = ""
    
    public var selected: Bool = false
    
    public var visibleHeight: CGFloat = 0
    public var labelTitle : UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        clipsToBounds = true
        
        self.subviews.map { $0.removeFromSuperview() }
        labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 18))
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 3
        labelTitle.text = ""
        labelTitle.textColor = .black
        labelTitle.font = labelTitle.font.withSize(6)
        self.addSubview(labelTitle)
    }
    
    public func prepareForReuse() {
        selected = false
    }
}
