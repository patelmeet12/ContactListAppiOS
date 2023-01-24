//
//  CustomView.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 24/01/23.
//

import Foundation
import UIKit

@IBDesignable class CustomView: UIView {
    
    @IBInspectable var isCircleImage: Bool = false {
        didSet {
            layer.cornerRadius = (frame.width + frame.height) / 4
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var bottomLeftRightCornerRadious: CGFloat = 0.0
    @IBInspectable var topLeftRightCornerRadious: CGFloat = 0.0
    @IBInspectable var topLeftRightBottomLeftCornerRadious: CGFloat = 0.0
    
    @IBInspectable var bottomRightCornerRadious: CGFloat = 0.0
    @IBInspectable var topRightCornerRadious: CGFloat = 0.0
    
    @IBInspectable var isDashedLine: Bool = false
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isCircleImage {
            layer.cornerRadius = (frame.width + frame.height) / 4
        }
        
        if bottomLeftRightCornerRadious > 0.0 {
            
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: bottomLeftRightCornerRadious, height: bottomLeftRightCornerRadious)).cgPath
            
            rectShape.shadowColor = shadowColor.cgColor
            rectShape.shadowOffset = shadowOffset
            rectShape.shadowOpacity = shadowOpacity
            rectShape.shadowRadius = shadowRadius
            
            //Here I'm masking the textView's layer with rectShape layer
            self.layer.mask = rectShape
        }
        
        if topLeftRightCornerRadious > 0.0 {
            
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,  .topRight], cornerRadii: CGSize(width: topLeftRightCornerRadious, height: topLeftRightCornerRadious)).cgPath
            
            rectShape.shadowColor = shadowColor.cgColor
            rectShape.shadowOffset = shadowOffset
            rectShape.shadowOpacity = shadowOpacity
            rectShape.shadowRadius = shadowRadius
            
            //Here I'm masking the textView's layer with rectShape layer
            self.layer.mask = rectShape
        }
        
        if topRightCornerRadious > 0.0 {
            
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: topRightCornerRadious, height: topRightCornerRadious)).cgPath
            
            rectShape.shadowColor = shadowColor.cgColor
            rectShape.shadowOffset = shadowOffset
            rectShape.shadowOpacity = shadowOpacity
            rectShape.shadowRadius = shadowRadius
            
            //Here I'm masking the textView's layer with rectShape layer
            self.layer.mask = rectShape
        }
        if bottomRightCornerRadious > 0.0 {
            
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: bottomRightCornerRadious, height: bottomRightCornerRadious)).cgPath
            
            rectShape.shadowColor = shadowColor.cgColor
            rectShape.shadowOffset = shadowOffset
            rectShape.shadowOpacity = shadowOpacity
            rectShape.shadowRadius = shadowRadius
            
            //Here I'm masking the textView's layer with rectShape layer
            self.layer.mask = rectShape
        }
        
        if topLeftRightBottomLeftCornerRadious > 0.0 {
            
            self.layoutIfNeeded()
            let shadowLayer = CAShapeLayer()
            let size = CGSize(width: topLeftRightBottomLeftCornerRadious, height: topLeftRightBottomLeftCornerRadious)
            let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,  .topRight, .bottomLeft], cornerRadii: size).cgPath //1
            shadowLayer.path = cgPath //2
            shadowLayer.borderWidth = 1
            shadowLayer.borderColor = self.shadowColor.cgColor
            shadowLayer.fillColor = self.backgroundColor?.cgColor //3
            self.backgroundColor = .clear
            self.layer.insertSublayer(shadowLayer, at: 0)
        }
        if isDashedLine {
            let borderLayer = CAShapeLayer()
            
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.lineDashPattern = [4, 4]
            borderLayer.frame = bounds
            borderLayer.fillColor = nil
            borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            
            borderLayer.shadowColor = shadowColor.cgColor
            borderLayer.shadowOffset = shadowOffset
            borderLayer.shadowOpacity = shadowOpacity
            borderLayer.shadowRadius = shadowRadius
            
            layer.insertSublayer(borderLayer, at: 0)
        }
    }
}
