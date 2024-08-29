//
//  RegisterView.swift
//  LittleLemonApp
//
//  Created by JRA on 21.08.2024.
//

import SwiftUI

struct RegisterView: View {
    //@StateObject private var viewModel = ViewModel()
    @StateObject private var userProfileVM = UserProfileViewModel()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    
    @State var isKeyboardVisible = false
    @State var contentOffset: CGSize = .zero
    
    @State var isLoggedIn = false
    @State var navigateToMainScreen = false
        
    var body: some View {
        
        NavigationStack{
        //NavigationView {
            
            ZStack {
                // Fondo amarillo
                //Color.yellow
                //Color.white
                //    .edgesIgnoringSafeArea(.all)
            
            //ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    //Header()
                    Hero()
                        .padding()
                        .background(Color.primaryColor1)
                        .frame(maxWidth: .infinity, maxHeight: 240)
                    
                    
                    VStack {
                        if isLoggedIn {
                            NavigationLink(destination: MainScreen()) { EmptyView() }
                        }
                        Text("Nombre *")
                            .onboardingTextStyle()
                        TextField("Introduce tu nombre", text: $firstName)
                        Text("Apellidos *")
                            .onboardingTextStyle()
                        TextField("Introduce tus apellidos", text: $lastName)
                        Text("E-mail *")
                            .onboardingTextStyle()
                        TextField("Introduce tu E-mail", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .padding()
                    
                    if userProfileVM.errorMessageShow {
                        withAnimation {
                            Text(userProfileVM.errorMessage)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                    }
                    
                    /*
                    Button(action: {
                        goMenu = true
                        MainScreen()
                    }, label: {
                        Text("HOLA")
                    })
                    .buttonStyle(ButtonStyleYellowColorWide())
                     */
                    
                    Button("Registrar") {
                        if userProfileVM.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) { //, phoneNumber: phoneNumber
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            
                            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                            
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            UserDefaults.standard.set(true, forKey: kOrderStatuses)
                            UserDefaults.standard.set(true, forKey: kPasswordChanges)
                            UserDefaults.standard.set(true, forKey: kSpecialOffers)
                            UserDefaults.standard.set(true, forKey: kNewsletter)
                            firstName = ""
                            lastName = ""
                            email = ""
                            //isLoggedIn = true
                            isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
                            navigateToMainScreen = true // Cambia el estado para navegar a MainScreen
                        }
                    }
                    .buttonStyle(ButtonStyleYellowColorWide())
                    
                    
                    /*
                    Button("Tengo una cuenta") {
                        if isLoggedIn {
                            // Si ya está logueado, navega a la pantalla principal
                            navigateToAqui()
                        } else {
                            // Puedes implementar lógica para mostrar un mensaje o redirigir a una pantalla de login si no está logueado
                            print("Usuario no está logueado.")
                        }
                    }
                    .buttonStyle(ButtonStyleGrayColorWide())
                    */
                    /*
                    if isLoggedIn {
                        Spacer()
                        Text("Ya estas dentro")
                            .font(.footnote)
                    } else {
                        Spacer()
                        Text("No estas registrado o logeado")
                            .font(.footnote)
                    }
                    */
                    Spacer()

                }
                //.ignoresSafeArea(.all, edges: .top)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: contentOffset.height)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    withAnimation {
                        let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let keyboardHeight = keyboardRect.height
                        self.isKeyboardVisible = true
                        self.contentOffset = CGSize(width: 0, height: -keyboardHeight / 2 + 50)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                    withAnimation {
                        self.isKeyboardVisible = false
                        self.contentOffset = .zero
                    }
                }
                
                //Footer()
                
            }
            .navigationBarHidden(true)
            .onAppear {
                isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            }
            .navigationDestination(isPresented: $navigateToMainScreen) {
                MainScreen() // Navega a MainScreen después del registro
            }

        /*
         }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isLoggedIn) {
            HomeMain()
            // MainScreen()  // Cambia HomeMain() por MainScreen()
        }
         */
        }
    }
    
    private func navigateToAqui() {
        isLoggedIn = true // Esto activará la navegación a MainScreen
        print("Usuario ya está logueado, navegando aqui!!!.")
        //NavigationLink(destination: UserProfile()) {
            // TODO: esto no me esta redirigiendo...
        //}
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview in English
            RegisterView()
                .environment(\.locale, Locale(identifier: "en"))
                .previewDisplayName("En")

            // Preview in Spanish
            RegisterView()
                .environment(\.locale, Locale(identifier: "es"))
                .previewDisplayName("Es")

            // Preview in French
            RegisterView()
                .environment(\.locale, Locale(identifier: "fr"))
                .previewDisplayName("Fr")
            
            // Preview in Catalan
            RegisterView()
                .environment(\.locale, Locale(identifier: "ca"))
                .previewDisplayName("Cat")

            // Preview in Dark
            RegisterView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    .preferredColorScheme(.dark)
                .previewDisplayName("Dark")

 
        }
    }
}
