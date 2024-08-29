//
//  OnboardingView.swift
//  LittleLemonApp
//
//  Created by Joan Roca on 23/8/24.
//

import SwiftUI

struct OnboardingView: View {
    
    private let slidesOnboarding = [
        OnboardingSlide(image: "onboarding-2", title: "Bienvenidos a Nuestra Casa", description: "Disfruta de un servicio excepcional y una cálida bienvenida desde el primer momento."),
        OnboardingSlide(image: "onboarding-1", title: "Ingredientes Frescos y Naturales", description: "Nos enorgullecemos de usar ingredientes frescos y naturales en cada plato que preparamos."),
        OnboardingSlide(image: "onboarding-3", title: "Variedad de Sabores Incomparables", description: "Explora la diversidad de sabores en nuestro menú, diseñado para deleitar tu paladar.")
    ]

    @State private var currentSlide = 0
    @State private var goRegister: Bool = false
    @State private var goMenu: Bool = false
    @State private var goLogin: Bool = false
    @State private var timer: Timer?
    @State private var omitOnboard: Bool = false
    @State private var showModal = false
    @State private var isLoggedIn = false
    @State private var nameUserLoged = ""
    @State private var apellidoUserLoged = ""
    
    @State private var alertIsPresented = false
    
    var body: some View {
        NavigationStack{
        //NavigationView {
            
            ZStack {
                // Fondo amarillo
                //Color.yellow
                //Color.white
                //    .edgesIgnoringSafeArea(.all)
                
                TabView(selection: $currentSlide) {
                    //ForEach(0..<slidesOnboarding.count) { slide in
                    ForEach(Array(0..<slidesOnboarding.count), id: \.self) { slide in
                        VStack(alignment: .center, spacing: 32) {
                            Image(slidesOnboarding[slide].image)
                                .resizable()
                            .frame(width: 352, height: 352)
                            .cornerRadius(14)
                            
                            Text(slidesOnboarding[slide].title)
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                            
                            Text(slidesOnboarding[slide].description)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                            
                            // Buttons
                            // Solo muestra los botones si es la última diapositiva
                            if slide == slidesOnboarding.count - 1 {
                            VStack {
                                
                                if isLoggedIn {
                                    Spacer()
                                    Text("Bienvenido  \(Text(nameUserLoged))  \(Text(apellidoUserLoged))")
                                        .fontWeight(.bold)
                                    Spacer()
                                    Button(action: {
                                        goMenu = true
                                    }, label: {
                                        NavigationLink("Comenzar", destination: MainScreen())
                                            .modifier(ButtonModifier2())
                                    })
                                    Spacer()
                                    
                                } else {
                                    Button(action: {
                                        goRegister = true
                                    }, label: {
                                        NavigationLink("Registrarse", destination: MainScreen())
                                        /*
                                         .font(.subheadline)
                                         .frame(width: 320, height: 48)
                                         .foregroundColor(.purple)
                                         .background(Color.white)
                                         .cornerRadius(12)
                                         .overlay(
                                         RoundedRectangle(cornerRadius: 10)
                                         .stroke(Color.purple, lineWidth: 2)
                                         )
                                         */
                                            .modifier(ButtonModifier1())
                                    })
                                }
                            }
                            //.opacity(currentSlide < slidesOnboarding.count - 1 ? 0 : 1)
                            //.transition(.opacity.animation(.easeInOut(duration: 0.3)))

                            /*
                            Button("Show Modal : sheet") {
                                        showModal = true
                                    }
                                    .sheet(isPresented: $showModal) {
                                        RegisterView()
                                    }
                            */
                                
                            }
                            
                            
                            Spacer()
                            
                            //Indicadores y Butones
                            HStack(alignment: .center) {
                                
                                Spacer()
                                
                                VStack{
                                    
                                    // Botón Omitir
                                    Button(action: {
                                        
                                        // Acciones Omitir
                                        /*
                                         UserDefaults.standard.set(true, forKey: kOmitOnboard)
                                         omitOnboard = true
                                         navigationDestination(isPresented: $omitOnboard) {
                                         MainScreen()
                                         }
                                         */
                                        alertIsPresented = true
                                    }) {
                                        Text("Omitir")
                                            .font(.subheadline)
                                            .foregroundColor(Color.primaryColor2)
                                    }
                                    .padding(.trailing, 20)
                                    
                                }.alert(isPresented: $alertIsPresented) {
                                    Alert(
                                        title: Text("¿Quieres desactivar el Onboarding?"),
                                        message: Text("Si aceptas, la próxima vez que abras la aplicación no se mostrará el Onboarding. Siempre podrás reactivarlo desde tu perfil de usuario."),
                                        primaryButton: .default(Text("Aceptar"), action: {
                                            
                                            print("Desactivando Onboarding")
                                            UserDefaults.standard.set(true, forKey: kOmitOnboard)
                                            omitOnboard = true
                                            navigationDestination(isPresented: $omitOnboard) {
                                            MainScreen()
                                            }
                                            
                                        }),
                                        secondaryButton: .destructive(Text("Cancelar"))
                                    )
                                }
                                
                                Spacer()
                                
                                // Circulos Indicadores
                                HStack(spacing: 20) {
                                    ForEach(Array(0..<slidesOnboarding.count), id: \.self) { slide in
                                        
                                        /*
                                        if slide == currentSlide {
                                    //ForEach(0..<slidesOnboarding.count) { slide in
                                    //   if slide == currentSlide {
                                            //Rectangle()
                                            Circle()
                                                .frame(width: 20, height: 10)
                                                .foregroundColor(Color.primaryColor1)
                                        } else {
                                            //Rectangle()
                                            Circle()
                                                .frame(width: 20, height: 10)
                                                .foregroundColor(Color.primaryColor2)
                                        } */
                                        Button(action: {
                                            withAnimation {
                                                currentSlide = slide
                                            }
                                                                            }) {
                                                                                Circle()
                                                                                    .frame(width: 10, height: 10)
                                                                                    .foregroundColor(slide == currentSlide ? Color.primaryColor1 : Color.primaryColor2)
                                                                            }
                                                                        
                                        
                                    }
                                }
                                
                                
                                Spacer()
                                
                                //Button Next
                                Button(action: {
                                    withAnimation {
                                        if self.currentSlide < (slidesOnboarding.count - 1) {
                                            self.currentSlide += 1
                                        } else {
                                            goRegister = true
                                        }
                                    }
                                    
                                }, label: {
                                    /*if (currentSlide < slidesOnboarding.count - 1) {*/
                                    if slide != slidesOnboarding.count - 1 {
                                        Text("Siguiente >")
                                            .foregroundColor(Color.primaryColor1)
                                    } else {
                                        if slide == slidesOnboarding.count - 1 {
                                            
                                            if isLoggedIn {
                                                NavigationLink(
                                                    /*nameUserLoged.count < 8 ? "Accede \(Text(nameUserLoged)) >" : */
                                                        "Acceder >",
                                                    destination: MainScreen()
                                                )
                                                    .foregroundColor(Color.primaryColor1)
                                                    .transition(.slide)
                                            } else {
                                                NavigationLink("Registrarse >", destination: MainScreen())
                                                    .foregroundColor(Color.primaryColor1)
                                                    .transition(.slide)
                                            }
                                        }
                                    }
                                })
                                
                                
                            }
                            .padding(.trailing, 50)
                        }// VStack
                        .tag(slide)
                    }//ForEach
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.3), value: currentSlide)
                .onAppear {
                    startTimer()
                }
                .onDisappear {
                    stopTimer()
                }
                
                
                // Si omitOnboard es verdadero, navegar automáticamente a la pantalla de login
                .navigationDestination(isPresented: $omitOnboard) {
                    MainScreen()
                }
                
                
            } //
            .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso
            .onAppear {
                        // Comprobar si el onboarding ha sido omitido
                        let hasSkippedOnboarding = UserDefaults.standard.bool(forKey: kOmitOnboard)
 
                        if hasSkippedOnboarding {
                            // Redirigir a la pantalla principal o de inicio de sesión
                            omitOnboard = true
                            print("kOmitOnboard = true")
                            //NSLog("SI existe onboardingSkipped")
                        } else {
                            print("kOmitOnboard = false")
                            //NSLog("NO existe onboardingSkipped")
                            omitOnboard = false
                        }
                    }
        }
        .onAppear {
            omitOnboard = UserDefaults.standard.bool(forKey: kOmitOnboard) // kOmitOnboard vs "onboardingSkipped"
                            
            // Actualizar el valor de isLoggedIn cuando la vista aparezca
            isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            if isLoggedIn {
                // Acceder a nameUserLoged solo si isLoggedIn es true
                nameUserLoged = UserDefaults.standard.string(forKey: kFirstName) ?? "Invitado"
                apellidoUserLoged = UserDefaults.standard.string(forKey: kLastName) ?? "Invitado"
            }
        }
        
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                if currentSlide < slidesOnboarding.count - 1 {
                    currentSlide += 1
                } else {
                    stopTimer() // Detenemos el temporizador cuando llegamos al último slide
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}


//#Preview

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .preferredColorScheme(.light)
            .previewDisplayName("Light")
        
        OnboardingView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
