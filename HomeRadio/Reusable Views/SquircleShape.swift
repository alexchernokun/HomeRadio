//
//  SquircleShape.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import Foundation
import SwiftUI

struct SquircleShape: Shape {
    var size: CGFloat = .infinity
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: size / 2))
        path.addCurve(
            to: CGPoint(x: size / 2, y: 0),
            control1: CGPoint(x: 0, y: size * 0.0875),
            control2: CGPoint(x: size * 0.0875, y: 0)
        )
        
        path.addCurve(
            to: CGPoint(x: size, y: size / 2),
            control1: CGPoint(x: size * 0.9125, y: 0),
            control2: CGPoint(x: size, y: size * 0.0875)
        )
        
        path.addCurve(
            to: CGPoint(x: size / 2, y: size),
            control1: CGPoint(x: size, y: size * 0.9125),
            control2: CGPoint(x: size * 0.9125, y: size)
        )
        
        path.addCurve(
            to: CGPoint(x: 0, y: size / 2),
            control1: CGPoint(x: size * 0.0875, y: size),
            control2: CGPoint(x: 0, y: size * 0.9125)
        )
        
        return path
    }
}
