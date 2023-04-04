//
//  CircularProgressBar.swift
//  Sloth
//
//  Created by JAEHA JU on 2023/04/04.
//

import UIKit

@IBDesignable
class CircularProgressBar: UIView {
    
    @IBInspectable var lineWidth: CGFloat = 3
    let fullAngle: CGFloat = .pi * 2
    let borderSize: CGFloat = 0.1
    var splitAngle: CGFloat = 0.0

    var value: Double? {
        didSet {
            guard let _ = value else { return }
            setProgress(self.bounds)
        }
    }
    
    func setProgress(_ rect: CGRect) {
        guard let value = self.value else {
            return
        }
        splitAngle = fullAngle * borderSize

        self.subviews.forEach { $0.removeFromSuperview() }
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let bezierPath = UIBezierPath()

        bezierPath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midX - ((lineWidth - 1) / 2), startAngle: .pi / 2 + splitAngle, endAngle: (.pi * 5 / 2) - (fullAngle * value), clockwise: true)
        
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineCap = .round

        let color: UIColor = .systemBlue

        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth

        self.layer.addSublayer(shapeLayer)
    }
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midX - ((lineWidth - 1) / 2), startAngle: .pi / 2 + splitAngle, endAngle: .pi * 5 / 2 - splitAngle, clockwise: true)
        bezierPath.lineWidth = 1
        UIColor.systemGray4.set()
        bezierPath.stroke()
    }
}
