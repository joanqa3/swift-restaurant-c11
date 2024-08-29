//
//  SplashScreenView.swift
//  SplashScreen
//
//  Created by Federico on 20/01/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActiveSplash : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActiveSplash {
            OnboardingView()
            //MainScreen()
        } else {
            ZStack {
                // Fondo amarillo
                //Color.yellow
                //Color.white
                //    .edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        /*Image(systemName: "globe")
                            .font(.system(size: 80))
                            .foregroundColor(.red)*/
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 90)
                        Footer()
                        /*Text("Little Lemon")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                            .foregroundColor(.black.opacity(0.80))*/
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActiveSplash = true
                        }
                    }
                }
                //.background(Color.blue)
            }
            .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .preferredColorScheme(.light)
            .previewDisplayName("Light")
        
        SplashScreenView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}

