//
//  ViewController.swift
//  VerticalText
//
//  Created by Santi González on 24/02/2015.
//  Copyright (c) 2015 sangonz. All rights reserved.
//
//
//  This is a quick-and-dirty project for demonstration purposes only.
//  The code does not follow good coding practices. Don't use it in production code as-is.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var verticalTextView: VerticalTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let container = VerticalTextContainer(size: verticalTextView.bounds.size)
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(container)
        layoutManager.textStorage = textView.textStorage
        verticalTextView.layoutManager = layoutManager
    }
}


class VerticalTextContainer: NSTextContainer {
    
    override func lineFragmentRectForProposedRect(proposedRect: CGRect, atIndex characterIndex: Int, writingDirection baseWritingDirection: NSWritingDirection, remainingRect: UnsafeMutablePointer<CGRect>) -> CGRect {
        
        remainingRect.memory = CGRectZero
        
        // Return a rect whose width is the current height
        return CGRectMake(0, proposedRect.origin.y, self.size.height, proposedRect.size.height)
    }
}


class VerticalTextView: UIView {
    
    var layoutManager: NSLayoutManager?
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext();
        
        // Enumerate all the line fragments in the text
        layoutManager?.enumerateLineFragmentsForGlyphRange(NSMakeRange(0, layoutManager!.numberOfGlyphs), usingBlock: {
            (lineRect: CGRect, usedRect: CGRect, textContainer: NSTextContainer!, glyphRange: NSRange, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            
            CGContextSaveGState(context)
            
            // Lay the text vertically, reading top-left to bottom-right
            CGContextScaleCTM(context, -1, 1)
            CGContextRotateCTM(context, CGFloat(M_PI_2))
            
            // Flip text line fragment along X axis
            CGContextTranslateCTM(context, 0, lineRect.origin.y)
            CGContextScaleCTM(context, 1, -1)
            CGContextTranslateCTM(context, 0, -(lineRect.origin.y + lineRect.size.height))
            
            // Draw the line fragment
            self.layoutManager?.drawGlyphsForGlyphRange(glyphRange, atPoint: CGPointMake(0, 0))
            
            CGContextRestoreGState(context);
        })
    }
}
