//
//  ViewExtension.swift
//  LittleLemonApp
//
//  Created by JRA on 21.08.2024.
//

import SwiftUI

extension View {

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
        
    func enable(_ enable: Bool) -> some View {
        return opacity(enable ? 1 : UIConstants.kShadowOpacity).disabled(!enable)
    }
    
    // Brujería de la buena
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }

    // MARK: iOS 15
    
    func hideTableSeparator() -> some View {
        if #available(iOS 15, *) {
            return AnyView(listRowSeparator(.hidden).listRowInsets(EdgeInsets()))
        } else {
            return AnyView(listRowInsets(EdgeInsets()))
        }
    }
    
}

private struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
