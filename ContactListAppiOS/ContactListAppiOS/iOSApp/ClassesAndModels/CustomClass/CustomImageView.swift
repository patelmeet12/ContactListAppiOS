//
//  CustomImageView.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 23/01/23.
//

import Foundation
import UIKit

@IBDesignable class CustomImageView: UIImageView {
    
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
    }
}
