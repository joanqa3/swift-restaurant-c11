//
//  UserProfile.swift
//  LittleLemonApp
//
//  Created by JRA on 24.08.2024.
//

//import UIKit
import SwiftUI
import PhotosUI

struct UserProfile: View {
    //@StateObject private var viewModel = ViewModel()
    
    @Environment(\.presentationMode) var presentation
    
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isLoggedOut = false
    
    //@State private var selectedImage: PhotosPickerItem?
    @StateObject private var userProfileVM = UserProfileViewModel()
    @State private var showPhotosPicker = false
    
    //@State private var omitOnboard = UserDefaults.standard.bool(forKey: "onboardingSkipped") // Control Onboarding
    @State private var omitOnboard = true
    
    var body: some View {
        NavigationStack{
        //NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if isLoggedOut {
                    //NavigationLink(destination: Onboarding()) { EmptyView() }
                    NavigationLink(destination: RegisterView()) { EmptyView() }
                }
                
                VStack(spacing: 5) {
                    Text("Avatar")
                        .onboardingTextStyle()
                    HStack(spacing: 0) {
                        VStack {
                            PhotosPicker(selection: $userProfileVM.selectedItem) {
                                if let profileImage = userProfileVM.profileImage {
                                    profileImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                    Text("profile.change", tableName: nil, bundle: .main, comment: "")
                                       .modifier(TextModifier1())
                                } else {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 75, height: 75)
                                        .foregroundColor(Color(.systemGray4))
                                    Text("profile.change", tableName: nil, bundle: .main, comment: "")
                                        //.buttonStyle(ButtonStylePrimaryColor1())
                                        .modifier(TextModifier1())
                                }
                            }
                            /*
                             Text("\(firstName) \(lastName)")
                             .font(.title2)
                             .fontWeight(.semibold)
                             .foregroundColor(Color.primaryColor1)
                             */
                        }
                        /*Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 75)
                            .clipShape(Circle())
                            .padding(.trailing)
                         Button("Change") { }
                             .buttonStyle(ButtonStylePrimaryColor1())
                         */

                        /*Button("Borrar") {
                            userProfileVM.resetImage()
                        }*/
                        Button(action: {
                            userProfileVM.resetImage()
                        }) {
                            Text("profile.delete", tableName: nil, bundle: .main, comment: "")
                        }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                        Spacer()
                    }
                    
                    VStack {
                        // Text("First name")
                        //    .onboardingTextStyle()
                        //Text(NSLocalizedString("profile.first.name", comment: "First name label"))
                        Text("\(Text("profile.first.name", tableName: nil, bundle: .main, comment: "")) *")
                            .onboardingTextStyle()
                        TextField("First Name", text: $firstName)
                    
                    }.padding(.top,10)
                    
                    VStack {
                        //Text("Last name")
                        //Text("profile.last.name", tableName: nil, bundle: .main, comment: "")
                        Text("\(Text("profile.last.name", tableName: nil, bundle: .main, comment: "")) *")
                            .onboardingTextStyle()
                        TextField("Last Name", text: $lastName)
                    }
                    
                    VStack {
                        //Text("E-mail")
                        //Text("profile.email", tableName: nil, bundle: .main, comment: "")
                        Text("\(Text("profile.email", tableName: nil, bundle: .main, comment: "")) *")
                            .onboardingTextStyle()
                        HStack {
                            Image(systemName: "envelope.fill") // Icono para el email
                                .foregroundColor(.gray)
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        }
                    }
                    
                    VStack {
                        //Text("Phone number")
                        Text("profile.phone", tableName: nil, bundle: .main, comment: "")
                            .onboardingTextStyle()
                        HStack {
                            Image(systemName: "phone.fill") // Icono para el teléfono
                                .foregroundColor(.gray)
                            TextField("Phone number", text: $phoneNumber)
                                .keyboardType(.default)
                        }
                    }
                }
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                //.padding()
                .padding(.bottom,10)
                .padding(.leading) // Añadir padding izquierdo
                .padding(.trailing) // Añadir padding derecho
                
                // Selctor de Onboarding
                VStack {
                    Toggle(isOn: $omitOnboard) {
                        Text("Omitir Onboarding")
                    }
                    .foregroundColor(.primaryColor1)
                    .tint(.primaryColor2) // Aplica el color personalizado al toggle
                }
                //.padding()
                .padding(.leading) // Añadir padding izquierdo
                .padding(.trailing) // Añadir padding derecho
                //.padding(.leading, 10) // Añadir padding izquierdo
                //.padding(.trailing, 10) // Añadir padding derecho
                .font(Font.leadText())
                .foregroundColor(.primaryColor1)
                
                // Notificaciones
                
                Text("profile.email.notifications", tableName: nil, bundle: .main, comment: "")
                    .font(.regularText())
                    .foregroundColor(.primaryColor1)
                    .padding(.top,10)
                
                
                VStack {
                    //Toggle("Order statuses", isOn: $orderStatuses)
                    Toggle(isOn: $orderStatuses) {
                        Text("profile.order.statuses", tableName: nil, bundle: .main, comment: "")
                    }
                    .tint(.primaryColor2)
                    Toggle(isOn: $passwordChanges) {
                        Text("profile.password.changes", tableName: nil, bundle: .main, comment: "")
                    }
                    .tint(.primaryColor2)
                    Toggle(isOn: $specialOffers) {
                        Text("profile.special.offers", tableName: nil, bundle: .main, comment: "")
                    }
                    .tint(.primaryColor2)
                    Toggle(isOn: $newsletter) {
                        Text("profile.newsletter", tableName: nil, bundle: .main, comment: "")
                    }
                    .tint(.primaryColor2)
                }
                .padding()
                .font(Font.leadText())
                .foregroundColor(.primaryColor1)
                
                if userProfileVM.errorMessageShow {
                    withAnimation {
                        Text(userProfileVM.errorMessage)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                }
                
                HStack {
                    Button(action: {
                        firstName = userProfileVM.firstName
                        lastName = userProfileVM.lastName
                        email = userProfileVM.email
                        phoneNumber = userProfileVM.phoneNumber
                        
                        orderStatuses = userProfileVM.orderStatuses
                        passwordChanges = userProfileVM.passwordChanges
                        specialOffers = userProfileVM.specialOffers
                        newsletter = userProfileVM.newsletter
                        omitOnboard = userProfileVM.omitOnboard
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Text("profile.discard.changes", tableName: nil, bundle: .main, comment: "")
                    }.buttonStyle(ButtonStylePrimaryColorReverse())
                    /*
                    Button("Discard Changes") {
                        firstName = viewModel.firstName
                        lastName = viewModel.lastName
                        email = viewModel.email
                        phoneNumber = viewModel.phoneNumber
                        
                        orderStatuses = viewModel.orderStatuses
                        passwordChanges = viewModel.passwordChanges
                        specialOffers = viewModel.specialOffers
                        newsletter = viewModel.newsletter
                        self.presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(ButtonStylePrimaryColorReverse())
                     */
                    Button(action: {
                        if userProfileVM.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                            UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                            UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                            UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                            UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                            UserDefaults.standard.set(omitOnboard, forKey: kOmitOnboard) // Restaurar el valor de omitOnboard "onboardingSkipped"
                                                    
                            self.presentation.wrappedValue.dismiss()
                        }
                    }) {
                        Text("profile.save.changes", tableName: nil, bundle: .main, comment: "")
                    }.buttonStyle(ButtonStylePrimaryColor1())
                    /*
                    Button("Save changes") {
                        if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                            UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                            UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                            UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                            UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                            self.presentation.wrappedValue.dismiss()
                        }
                    }
                    .buttonStyle(ButtonStylePrimaryColor1())
                     */
                }
                
                Spacer(minLength: 20)
                
                //Button("Log out") {
                Button(action: {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    UserDefaults.standard.set("", forKey: kFirstName)
                    UserDefaults.standard.set("", forKey: kLastName)
                    UserDefaults.standard.set("", forKey: kEmail)
                    UserDefaults.standard.set("", forKey: kPhoneNumber)
                    UserDefaults.standard.set(false, forKey: kOrderStatuses)
                    UserDefaults.standard.set(false, forKey: kPasswordChanges)
                    UserDefaults.standard.set(false, forKey: kSpecialOffers)
                    UserDefaults.standard.set(false, forKey: kNewsletter)
                    // UserDefaults.standard.set(false, forKey: kOmitOnboard)
                    isLoggedOut = true
                }){
                    Text("profile.log.out", tableName: nil, bundle: .main, comment: "")
                }
                .buttonStyle(ButtonStyleYellowColorWide())
                
                Spacer(minLength: 30)
                
                
                NavigationLink("profile.send.suggestions", destination: SugerenciaFormView())
                    .foregroundColor(Color.primaryColor1)
                    .transition(.slide)
                
                Spacer(minLength: 30)
                
                /*NavigationLink(
                    destination: SugerenciaMessageUIView()
                ) {
                    Text("Ui \(NSLocalizedString("profile.send.suggestions", comment: ""))") // Usa NSLocalizedString para texto localizado
                        .foregroundColor(Color.primaryColor1)
                        .transition(.slide)
                }*/
                
                Spacer(minLength: 50)
                
            }
            .onAppear {
                firstName = userProfileVM.firstName
                lastName = userProfileVM.lastName
                email = userProfileVM.email
                phoneNumber = userProfileVM.phoneNumber
                
                orderStatuses = userProfileVM.orderStatuses
                passwordChanges = userProfileVM.passwordChanges
                specialOffers = userProfileVM.specialOffers
                newsletter = userProfileVM.newsletter
                
                omitOnboard = userProfileVM.omitOnboard
            }
            .navigationTitle(
                    //Text("Personal information")
                    Text("profile.personal.information", tableName: nil, bundle: .main, comment: "")
                
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isLoggedOut) {
                //Onboarding()
                //RegisterView()
                MainScreen()
            }
            // PhotosPicker invocado desde el botón "Change"
            /*
             .sheet(isPresented: $showPhotosPicker) {
                PhotosPicker(selection: $userProfileVM.selectedItem, matching: .images, photoLibrary: .shared()) {
                    Text("Select an image") // Añadir una instrucción o contenido adicional si es necesario.
                    //EmptyView()
                }
                
            }
             */
             
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview in English
            UserProfile()
                .environment(\.locale, Locale(identifier: "en"))
                .previewDisplayName("En")

            // Preview in Spanish
            UserProfile()
                .environment(\.locale, Locale(identifier: "es"))
                .previewDisplayName("Es")

            // Preview in French
            UserProfile()
                .environment(\.locale, Locale(identifier: "fr"))
                .previewDisplayName("Fr")
            
            // Preview in Catalan
            UserProfile()
                .environment(\.locale, Locale(identifier: "ca"))
                .previewDisplayName("Cat")

            // Preview in Light
            /*
             UserProfile()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    .preferredColorScheme(.light)
                .previewDisplayName("Light")
            */
            // Preview in Dark
            UserProfile()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    .preferredColorScheme(.dark)
                .previewDisplayName("Dark")

 
        }
    }
}
