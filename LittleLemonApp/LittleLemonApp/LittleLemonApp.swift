//
//  LittleLemonApp.swift
//
//  by JRA on 19.08.2024.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            //Onboarding().environment(\.managedObjectContext, persistenceController.container.viewContext)
            SplashScreenView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
