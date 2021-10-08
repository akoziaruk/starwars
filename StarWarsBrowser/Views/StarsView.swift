//
//  StarsBackgroundView.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/8/21.
//

import UIKit

class StarsView: UIView {
    private let starsCount = 100
    public let diameterRange: ClosedRange<Int>!
    
    init(diameterRange: ClosedRange<Int>) {
        self.diameterRange = diameterRange
        super.init(frame: CGRect())
        self.isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.clear(rect)
        context.setFillColor(UIColor.white.withAlphaComponent(0.4).cgColor)
        
        for _ in 0...starsCount {
            let diameter = CGFloat.random(in: 0...2.5)
            let starRect = CGRect(x: CGFloat.random(in: 0...rect.size.width),
                                  y: CGFloat.random(in: 0...rect.size.height),
                                  width: diameter,
                                  height: diameter)
            
            context.setShadow(offset: CGSize(width: 0,height: 0), blur: 3, color: UIColor.white.cgColor)
            context.fillEllipse(in: starRect)
        }
    
    }
    
}

