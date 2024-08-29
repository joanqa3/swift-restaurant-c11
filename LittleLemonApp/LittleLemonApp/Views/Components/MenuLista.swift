//
//  MenuList.swift
//
//  by JRA on 19.08.2024.
//

import SwiftUI
import CoreData

struct MenuLista: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var startersIsEnabled = true
    @State var mainsIsEnabled = true
    @State var dessertsIsEnabled = true
    @State var drinksIsEnabled = true
    
    @State var searchText = ""
    
    @State var loaded = false
    
    @State var isKeyboardVisible = false
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if !isKeyboardVisible {
                        withAnimation() {
                            Hero()
                                .frame(maxHeight: 180)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .onTapGesture {
                                //searchText = "" // Limpiar el campo de búsqueda
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // Cerrar el teclado
                                withAnimation {
                                    isKeyboardVisible = false // Forzar el estado del teclado a no visible
                                }
                            }
                        TextField("Buscador de platos", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.primaryColor1)
                
                Text("CARTA DE PLATOS")
                    .font(.sectionTitle())
                    .foregroundColor(.highlightColor2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding(.top)
                    .padding(4)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 9) {
                        /*Toggle("Starters", isOn: $startersIsEnabled)
                        Toggle("Mains", isOn: $mainsIsEnabled)
                        Toggle("Desserts", isOn: $dessertsIsEnabled)
                        Toggle("Drinks", isOn: $drinksIsEnabled)*/
                        Toggle("Entrantes", isOn: $startersIsEnabled)
                        Toggle("Principales", isOn: $mainsIsEnabled)
                        Toggle("Postres", isOn: $dessertsIsEnabled)
                        Toggle("Bebidas", isOn: $drinksIsEnabled)
                    }
                    .toggleStyle(MyToggleStyle())
                    .padding(.horizontal)
                }
                if !startersIsEnabled && !mainsIsEnabled && !dessertsIsEnabled && !drinksIsEnabled {
                    VStack {
                        Spacer()
                        Image(systemName: "eye.slash") // hand.raised.slash, fork.knife, tortoise.fill, eye.slash
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.gray.opacity(0.3))
                        Text("No hay categorías seleccionadas.")
                            .font(.headline)
                            .padding()
                            .foregroundColor(Color.gray.opacity(0.5))
                        /*Text("Seleccione al menos una categoría para ver los platos.")
                            .font(.subheadline)
                            .foregroundColor(Color.gray.opacity(0.6))*/
                        Spacer()
                        Spacer()
                    }
                    .padding()
                } else {
                    FetchedObjects(predicate: buildPredicate(),
                                   sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List(dishes) { dish in
                            NavigationLink(destination: DetailItem(dish: dish)) {
                                FoodItem(dish: dish)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                //Footer()
                //    .frame(height: 10)
            }
            //.ignoresSafeArea(.all, edges: .top)
        }
        //.navigationTitle("HOLA")
        //.navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .onAppear {
            if !loaded {
                MenuList.getMenuData(viewContext: viewContext)
                loaded = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = true
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = false
            }
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                  ascending: true,
                                  selector:
                                    #selector(NSString.localizedStandardCompare))]
    }
    // starters, mains, desserts, drinks
    // entrantes, platos principales, postres, bebidas
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters = !startersIsEnabled ? NSPredicate(format: "category != %@", "entrantes") : NSPredicate(value: true)
        let mains = !mainsIsEnabled ? NSPredicate(format: "category != %@", "platos principales") : NSPredicate(value: true)
        let desserts = !dessertsIsEnabled ? NSPredicate(format: "category != %@", "postres") : NSPredicate(value: true)
        let drinks = !drinksIsEnabled ? NSPredicate(format: "category != %@", "bebidas") : NSPredicate(value: true)

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
    }
}

struct MenuLista_Previews: PreviewProvider {
    static var previews: some View {
        MenuLista().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .preferredColorScheme(.light)
            .previewDisplayName("Light")
        
        MenuLista().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
