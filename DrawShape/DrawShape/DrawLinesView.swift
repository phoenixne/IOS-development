//
//  DrawLinesView.swift
//  DrawShape
//
//  Created by phoenix on 8/15/15.
//  Copyright (c) 2015 home. All rights reserved.
//

import UIKit

class DrawLinesView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var context = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(context, 100, 100)
        CGContextAddLineToPoint(context, 100, 200)
        CGContextAddLineToPoint(context, 200, 200)
        // CGContextStrokePath(context)
        
        
        CGContextMoveToPoint(context, 200, 300)
        CGContextAddLineToPoint(context, 100, 100)
        // CGContextStrokePath(context)
        
        CGContextMoveToPoint(context, 200, 200)
        CGContextAddLineToPoint(context, 200, 300)
        
        CGContextSetRGBStrokeColor(context, 0, 1, 1, 1)
        //        CGContextSetRGBFillColor(context, 1, 0, 1, 0)
        CGContextSetLineWidth(context, 6)
        
        CGContextStrokePath(context)
        
    }
    
    
}