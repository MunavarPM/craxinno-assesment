//
//  CustomCardShape.swift
//  AgendaUsingJSON
//
//  Created by MUNAVAR PM on 27/11/23.
//

import SwiftUI


struct CustomCardShape: Shape {
    func path(in rect: CGRect) -> Path {
        let padding: CGFloat = 16
        return Path { path in
            let pt1 = CGPoint(x: padding, y: 0)
            let pt2 = CGPoint(x: rect.width - padding, y: 0)
            
            let pt3 = CGPoint(x: rect.width - padding, y: rect.height)
            let pt4 = CGPoint(x: padding, y: rect.height)
            path.move (to: pt4)
            path.addArc (tangent1End: pt1, tangent2End: pt2, radius: 20)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 0)
            path.addArc (tangent1End: pt3, tangent2End: pt4, radius: 0)
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 20)
        }
    }
}
#Preview(body: {
    CustomCardShape()
        .frame(width: UIScreen.main.bounds.width, height: 100)
})
