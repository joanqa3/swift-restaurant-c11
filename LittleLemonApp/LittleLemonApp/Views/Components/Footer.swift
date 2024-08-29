//
//  Footer.swift
//  LittleLemonApp
//
//  Created by Joan Roca on 23/8/24.
//

import SwiftUI

struct Footer: View {
    // Obtener el nombre y la versión de la app desde el Info.plist
    var appName: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? Constants.kAppName
    }
    
    var appVersion: String {
        /*if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
           let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            return "v\(version) (\(build))"
        }*/
        return Constants.kAppVersion
    }
    
    var body: some View {
        VStack {
            //Spacer()
            HStack {
                //Text(appName)
                //    .font(.footnote)
                //Spacer()
                Text(appVersion)
                    .font(.footnote)
            }
            .padding()
            //.background(Color.yellow)
            .foregroundColor(.gray)
        }
    }
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Footer()
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Light")
            
            Footer()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Dark")
        }
    }
}

