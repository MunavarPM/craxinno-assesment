//
//  CustomCardShape.swift
//  AgendaUsingJSON
//
//  Created by MUNAVAR PM on 27/11/23.
//

import Foundation


struct CustomCardShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            let pt1 = CGPoint(x: 0, y: 0)
            let pt2 = CGPoint(x: rect.width, y: 0)
            
            let pt3 = CGPoint(x: rect.width, y: rect.height - 30)
            let pt4 = CGPoint(x: 0, y: rect.height)
            path.move (to: pt4)
            path.addArc (tangent1End: pt1, tangent2End: pt2, radius: 40)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 40)
            path.addArc (tangent1End: pt3, tangent2End: pt4, radius: 40)
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 40)
        }
    }
}
