//
//  Header.swift
//  LittleLemonApp
//
//  Created by JRA on 19.08.2024.
//

import SwiftUI

struct Header: View {
    @State var isLoggedIn = false
    @Environment(\.colorScheme) var colorScheme // Detecta el esquema de color del sistema
    @State private var profileImage: Image? = nil
    
    var body: some View {
        
        let logoName = colorScheme == .dark ? "LogoDark" : "LogoLight" // Selecciona el logo
        
        
        NavigationStack {
            VStack {
                ZStack {
                    //Image("Logo")
                    // Cambia el logo según el modo oscuro o claro
                    
                    HStack {
                        
                        //Image(systemName: "line.horizontal.3")
                        Image("transparent-image")
                            .imageScale(.large)
                            .padding(.leading, 16)
                            .frame(width: 50, height: 50)
                        
                        
                        Spacer()
                        
                        NavigationLink(destination: MainScreen()) {
                            Image(logoName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 50)
                        }
                        
                        Spacer()
                        
                        if isLoggedIn {
                            NavigationLink(destination: UserProfile()) {
                                /*
                                 Image("profile-image-placeholder")
                                 .resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxHeight: 50)
                                 .clipShape(Circle())
                                 .padding(.trailing)
                                 */
                                if let profileImage = profileImage {
                                    profileImage
                                        .resizable()
                                        //.aspectRatio(contentMode: .fit)
                                        //.frame(maxHeight: 50)
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .padding(.trailing)
                                } else {
                                    /*Image("profile-image-placeholder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 50)
                                        .clipShape(Circle())
                                        .padding(.trailing)
                                     */
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color(.systemGray4))
                                        .padding(.trailing)
                                }
                            }
                        } else {
                            /*Image("profile-image-placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 50)
                                .clipShape(Circle())
                                .padding(.trailing)
                             */
                            //Image(systemName: "")
                            Image("transparent-image")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color(.systemGray4))
                                .padding(.trailing)
                        }
                    }
                }
            }
        }
        .frame(maxHeight: 60, alignment: .top)
        //.frame(maxHeight: .infinity, alignment: .top)
        //.padding(.bottom)
        /*.onAppear() {
         if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
         isLoggedIn = true
         } else {
         isLoggedIn = false
         }
         }*/
        //.background(Color.primaryColor1)
        .onAppear {
            isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            if let imageData = UserDefaults.standard.data(forKey: kProfileImage),
               let uiImage = UIImage(data: imageData) {
                profileImage = Image(uiImage: uiImage)
            } else {
                profileImage = nil
            }
        }
    }
}
    
struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            //Header()
            
            Header()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    .preferredColorScheme(.light)
                //.preferredColorScheme(.light)
                .previewDisplayName("Light")
            
            Header()
                /*.environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    .preferredColorScheme(.dark)*/
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
             
        }
    }
}
