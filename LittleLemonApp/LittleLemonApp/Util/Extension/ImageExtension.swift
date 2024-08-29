//
//  ImageExtension.swift
//  LittleLemonApp
//
//  Created by JRA on 21.08.2024.
//

import SwiftUI

extension Image {
    
    var template: Image {
        return renderingMode(.template)
    }
    
    func templateIcon(size: Size! = .medium) -> some View {
        return template.resizable().frame(width: size.rawValue, height: size.rawValue).aspectRatio(contentMode: .fit)
    }
    
}
