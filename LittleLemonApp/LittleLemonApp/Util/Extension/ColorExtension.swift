//
//  ColorExtension.swift
//  LittleLemonApp
//
//  Created by JRA on 21.08.2024.
//

import SwiftUI

extension Color {
    
    // Colors
    
    static let primaryColor = Color("AccentColor")
    static let secondaryColor = Color("SecondaryColor")
    static let lightColor = Color("LightColor")
    static let darkColor = Color("DarkColor")
    static let textColor = Color("TextColor")
    static let backgroundColor = Color("BackgroundColor")
    static let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    static let liveColor = Color("LiveColor")
    /*
    static let primaryColor1 = Color(#colorLiteral(red: 0.2862745225, green: 0.3686274588, blue: 0.3411764801, alpha: 1))
    static let primaryColor2 = Color(#colorLiteral(red: 0.9568627477, green: 0.8078432088, blue: 0.07843137532, alpha: 1))
    
    static let secondaryColor1 = Color(#colorLiteral(red: 0.989240706, green: 0.5802358389, blue: 0.4141188264, alpha: 1))
    static let secondaryColor2 = Color(#colorLiteral(red: 1, green: 0.8488721251, blue: 0.7164030075, alpha: 1))
    
    static let highlightColor1 = Color(#colorLiteral(red: 0.9276351333, green: 0.9375831485, blue: 0.9331009984, alpha: 1))
    static let highlightColor2 = Color(#colorLiteral(red: 0.1999999881, green: 0.1999999881, blue: 0.1999999881, alpha: 1))
    
    static let grayColor1 = Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
    static let grayColor2 = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    */
     
    // Util
    
    var uiColor: UIColor {
        return UIColor(self)
    }
    
}
