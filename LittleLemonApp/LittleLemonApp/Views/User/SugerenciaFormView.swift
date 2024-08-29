//
//  SugerenciaView.swift
//  LittleLemonApp
//
//  Created by Joan Roca on 29/8/24.
//

import SwiftUI

struct SugerenciaFormView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @State private var nombre: String = ""
    @State private var correo: String = ""
    @State private var sugerencia: String = ""
    @State private var mostrarAlerta = false
    
    @State private var nameUserLoged = ""
    @State private var apellidoUserLoged = ""
    @State private var emailLoged = ""
    @State private var nombreConApellido = ""
    
    
    private func enviarSugerencia() {
        // Aquí podrías manejar el envío de la sugerencia, por ejemplo, guardándola localmente o enviándola a un servidor.
        // Para este ejemplo, simplemente mostraremos una alerta de confirmación.
        mostrarAlerta = true
        
        // Limpia los campos después de enviar la sugerencia
        nombre = ""
        correo = ""
        sugerencia = ""
    }
    
    var body: some View {
        NavigationStack{
            //NavigationView {
            //ZStack {
                //Color.yellow.edgesIgnoringSafeArea(.all) // Fondo amarillo
                //Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all) // Fondo general
                //VStack {
                    
                    Form {
                        Section(header: Text("suggestion.personal.info")) {
                                VStack {
                                    //Text("E-mail")
                                    //Text("profile.email", tableName: nil, bundle: .main, comment: "")
                                    Text("\(Text("suggestion.name.surname", tableName: nil, bundle: .main, comment: ""))")
                                        .onboardingTextStyle()
                                    HStack {
                                        Image(systemName: "person.fill") // Icono para el email
                                            .foregroundColor(.gray)
                                        TextField("suggestion.name", text: $nombreConApellido)
                                            .keyboardType(.emailAddress)
                                    }
                                }
                            
                                VStack {
                                    //Text("E-mail")
                                    //Text("profile.email", tableName: nil, bundle: .main, comment: "")
                                    Text("\(Text("profile.email", tableName: nil, bundle: .main, comment: ""))")
                                        .onboardingTextStyle()
                                    HStack {
                                        Image(systemName: "envelope.fill") // Icono para el email
                                            .foregroundColor(.gray)
                                        TextField("suggestion.email", text: $emailLoged)
                                            .keyboardType(.emailAddress)
                                            .autocapitalization(.none)
                                    }
                                }
                            }// Section 1
                            //.listRowBackground(Color(UIColor.systemGroupedBackground))
                        
                        Section(header: Text("suggestion.message")) {
                            TextEditor(text: $sugerencia)
                                .frame(height: 150)
                        } // Section 2
                        
                        //Section(header: Text("")) {
                            Button(action: {
                                enviarSugerencia()
                            }) {
                                Text("suggestion.button.send")
                                //.frame(maxWidth: .infinity, alignment: .center)
                                //.modifier(TextModifier1())
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(11)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.primaryColor2)
                                    .cornerRadius(10)
                                //.shadow(radius: 5)
                            }
                            .buttonStyle(PlainButtonStyle()) // Remove default styling
                            .clipShape(RoundedRectangle(cornerRadius: 10)) // Add clipShape
                            .alert(isPresented: $mostrarAlerta) {
                                Alert(title: Text("suggestion.alert.title"), message: Text("suggestion.alert.text"), dismissButton: .default(Text("suggestion.dismiss.button")))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        //} // Section 3
                        .listRowBackground(Color(UIColor.systemGroupedBackground))
                        
                    }// Form
                    .navigationTitle("suggestion.navigation.title")
                    
                //}// VStack
                
            //}// ZStack
            .onAppear {
                nameUserLoged = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                apellidoUserLoged = UserDefaults.standard.string(forKey: kLastName) ?? ""
                emailLoged = UserDefaults.standard.string(forKey: kEmail) ?? ""
                nombreConApellido = nameUserLoged + " " + apellidoUserLoged
            }
            
        }// NavigationStack
        
    }// body view
    
}// struct


//struct SugerenciaFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        SugerenciaFormView()
//    }
//}
//#Preview {
//    SugerenciaFormView()
//}

struct SugerenciaFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview in English
            SugerenciaFormView()
                .environment(\.locale, Locale(identifier: "en"))
                .previewDisplayName("En")

            // Preview in Spanish
            SugerenciaFormView()
                .environment(\.locale, Locale(identifier: "es"))
                .previewDisplayName("Es")

            // Preview in French
            SugerenciaFormView()
                .environment(\.locale, Locale(identifier: "fr"))
                .previewDisplayName("Fr")
            
            // Preview in Catalan
            SugerenciaFormView()
                .environment(\.locale, Locale(identifier: "ca"))
                .previewDisplayName("Cat")

            // Preview in Dark
            UserProfile()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    .preferredColorScheme(.dark)
                .previewDisplayName("Dark")

 
        }
    }
}
