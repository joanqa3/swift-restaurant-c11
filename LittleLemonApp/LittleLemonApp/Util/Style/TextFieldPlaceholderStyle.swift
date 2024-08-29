//
//  TextFieldPlaceholderStyle.swift
//  LittleLemonApp
//
//  Created by JRA on 21.08.2024.
//

import SwiftUI

struct TextFieldPlaceholderStyle: ViewModifier {
    
    var showPlaceHolder: Bool
    var placeholder: LocalizedStringKey

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder).font(size: .body).foregroundColor(Color.textColor.opacity(UIConstants.kViewOpacity))
            }
            content
        }
    }
}
