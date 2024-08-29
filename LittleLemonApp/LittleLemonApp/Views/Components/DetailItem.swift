//
//  DetailItem.swift
//
//  by JRA on 19.08.2024.
//

import SwiftUI

struct DetailItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    let dish: Dish
    
    var body: some View {
        /*
        ScrollView {
            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        // Placeholder con imagen por defecto
                        Image("placeholder-image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 350) // Establece una altura fija
                            .background(Color.gray.opacity(0.1)) // Fondo para que no sea blanco vacío
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 350) // Mantén la misma altura que el placeholder
                case .failure:
                    // En caso de error, muestra la imagen por defecto también
                    Image("placeholder-image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 350)
                        .background(Color.gray.opacity(0.1))
                @unknown default:
                    // Maneja cualquier otro caso desconocido
                    Image("placeholder-image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 350)
                        .background(Color.gray.opacity(0.1))
                }
            }
            .clipShape(Rectangle())
            
            Text(dish.title ?? "")
                .font(.subTitleFont())
                .foregroundColor(colorScheme == .dark ? .primaryColor2 : .primaryColor2 )
                //.padding()
            Spacer(minLength: 20)
            Text(dish.descriptionDish ?? "")
                .font(.regularText())
                //.padding()
            Spacer(minLength: 10)
            //Text("$" + (dish.price ?? ""))
            Text("" + (dish.price ?? "")+" €" )
                .font(.highlightText())
                .foregroundColor(.primaryColor1)
                .monospaced()
                //.padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
 */
        
        ScrollView {
                VStack {
                    AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Image("placeholder-image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 352, height: 352)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .background(Color.gray.opacity(0.1))
                                ProgressView()
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 352, height: 352)
                                .clipShape(RoundedRectangle(cornerRadius: 14)) //
                                .background(Color.gray.opacity(0.1))
                        case .failure:
                            Image("placeholder-image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 352, height: 352)
                                .clipShape(RoundedRectangle(cornerRadius: 14)) //
                                .background(Color.gray.opacity(0.1))
                        @unknown default:
                            Image("placeholder-image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 352, height: 352)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 14)) //
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 14)) //
                    .padding(.horizontal)
                    
                    Text(dish.title ?? "")
                        .font(.subTitleFont())
                        .foregroundColor(colorScheme == .dark ? .primaryColor2 : .primaryColor2)
                        .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                    
                    Text(dish.descriptionDish ?? "")
                        .font(.regularText())
                        .padding(.horizontal)
                    
                    Spacer(minLength: 10)
                    
                    Text("" + (dish.price ?? "") + " €")
                        .font(.highlightText())
                        .foregroundColor(.primaryColor1)
                        .monospaced()
                        .padding(.horizontal)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
        
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(dish: PersistenceController.oneDish())
            .preferredColorScheme(.light)
            .previewDisplayName("Light")
        
        DetailItem(dish: PersistenceController.oneDish())
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
