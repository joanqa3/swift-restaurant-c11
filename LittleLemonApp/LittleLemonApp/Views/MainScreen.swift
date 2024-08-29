//
//  MainScreen.swift
//
//  by JRA on 19.08.2024.
//

import SwiftUI

struct MainScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var userProfileVM = UserProfileViewModel()
    //@State var isLoggedIn = false
    //@State static var isLoggedIn = false
    //@Binding var isLoggedIn: Bool // Cambiar a Binding para reflejar cambios
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Header()
                if isLoggedIn {
                    MenuLista()
                    //Spacer()
                    //Text("Ya estas dentro")
                    //    .font(.footnote)
                } else {
                    RegisterView()
                    //Spacer()
                    //Text("No estas registrado o logeado")
                    //    .font(.footnote)
                }
                //Spacer()
                //Footer()
                //Spacer(minLength: 40)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            //.ignoresSafeArea(.all, edges: .top)
        }
        .onAppear {
            // Actualizar el valor de isLoggedIn cuando la vista aparezca
            isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
        }
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        //@State var isLoggedIn = false
        
        MainScreen()
            //.environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .preferredColorScheme(.light)
            .previewDisplayName("Light")
        
        MainScreen()
            //.environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
