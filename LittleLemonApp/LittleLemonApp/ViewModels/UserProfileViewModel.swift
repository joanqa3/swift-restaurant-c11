//
//  UserProfileViewModel.swift
//  LittleLemonApp
//
//  Created by Joan Roca on 24/8/24.
//

import SwiftUI
import PhotosUI

import Foundation
import Combine

public let kFirstName = "first name key"
public let kLastName = "last name key"
public let kEmail = "e-mail key"
public let kIsLoggedIn = "kIsLoggedIn"
public let kPhoneNumber = "phone number key"

public let kOrderStatuses = "order statuses key"
public let kPasswordChanges = "password changes key"
public let kSpecialOffers = "special offers key"
public let kNewsletter = "news letter key"

// Nueva constante para almacenar la imagen de perfil
public let kProfileImage = "profile image key"

public let kOmitOnboard = "Omit Skip Onboard key"

class UserProfileViewModel: ObservableObject {
    
    // propiedades del formulario
    @Published var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @Published var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @Published var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @Published var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    
    // propiedades otras que se podrian usar
    @Published var orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
    @Published var passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
    @Published var specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
    @Published var newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    
    @Published var omitOnboard = UserDefaults.standard.bool(forKey: kOmitOnboard)
    
    // propiedades de mensajes de error
    @Published var errorMessageShow = false
    @Published var errorMessage = ""
    
    // propiedades de busqueda
    @Published var searchText = ""
    
    // Propiedad publicada que almacena el elemento seleccionado del PhotosPicker
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            DispatchQueue.main.async {
                Task {
                    try? await self.loadImage()
                }
            }
        }
    }
    
    // Propiedad publicada que almacena la imagen de perfil cargada
    @Published var profileImage: Image?
    
    // Inicializador para cargar la imagen desde UserDefaults si está presente
    init() {
        if let imageData = UserDefaults.standard.data(forKey: kProfileImage),
           let uiImage = UIImage(data: imageData) {
            self.profileImage = Image(uiImage: uiImage)
        }
    }

    // Método asíncrono que carga la imagen desde el elemento seleccionado
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        
        //self.profileImage = Image(uiImage: uiImage)
        
        // Actualiza la UI en el hilo principal y guarda la imagen en UserDefaults
        DispatchQueue.main.async {
            self.profileImage = Image(uiImage: uiImage)
            UserDefaults.standard.set(imageData, forKey: kProfileImage)
        }
        
    }
    
    // Método para resetear la imagen a su estado predeterminado (sin imagen)
    func resetImage() {
        self.profileImage = nil
        self.selectedItem = nil
        UserDefaults.standard.removeObject(forKey: kProfileImage)
    }
    
    // Método que valida los campos de entrada del usuario y gestion del mensaje de error
    func validateUserInput(firstName: String, lastName: String, email: String, phoneNumber: String) -> Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            errorMessage = "Los campos Nombre, Apellido y Email son obligatorios"
            errorMessageShow = true
            return false
        }
        
        // Elimina los espacios en blanco al principio y al final del correo electrónico
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Verifica que no haya espacios en blanco dentro del correo electrónico
        guard !trimmedEmail.contains(" ") else {
            errorMessage = "La dirección de correo electrónico no debe contener espacios"
            errorMessageShow = true
            return false
        }
        
        guard email.contains("@") else {
            errorMessage = "Dirección de correo electrónico no válida"
            errorMessageShow = true
            return false
        }
        
        let email = email.split(separator: "@")
        
        guard email.count == 2 else {
            errorMessage = "Dirección de correo electrónico no válida"
            errorMessageShow = true
            return false
        }
        
        guard email[1].contains(".") else {
            errorMessage = "Dirección de correo electrónico no válida"
            errorMessageShow = true
            return false
        }
        
        guard phoneNumber.isEmpty || phoneNumber.allSatisfy({ $0.isNumber }) ||
                (phoneNumber.first == "+" && phoneNumber.dropFirst().allSatisfy({ $0.isNumber })) else {
            errorMessage = "Formato de número de teléfono no válido"
            errorMessageShow = true
            return false
        }
        errorMessageShow = false
        errorMessage = ""
        return true
    }
    
    
}
