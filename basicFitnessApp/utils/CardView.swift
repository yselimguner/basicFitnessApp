//
//  CardView.swift
//  basicFitnessApp
//
//  Created by Yavuz Selim Güner on 31.08.2025.
//

import Foundation

import UIKit

@IBDesignable
class CardView: UIView {
    
    // MARK: - Border Width
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    // MARK: - Corner Radius
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    // MARK: - Border Color
    @IBInspectable var borderColor: UIColor = .systemGray5 {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    // MARK: - Background Color
    @IBInspectable var fillColor: UIColor = UIColor(named: "mainBackgroundColor") ?? .systemBackground {
        didSet {
            backgroundColor = fillColor
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = fillColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
    }
}
