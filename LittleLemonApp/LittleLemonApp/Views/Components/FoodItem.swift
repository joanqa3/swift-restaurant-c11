//
//  FoodItem.swift
//
//  by JRA on 19.08.2024.
//

import SwiftUI
//import Kingfisher

struct FoodItem: View {
    
    let dish:Dish
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
        //LazyHStack {
            VStack {
            //LazyVStack {
                Text(dish.title ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.sectionCategories())
                    .foregroundColor(colorScheme == .dark ? .primaryColor2 : .primaryColor2 )
                Spacer(minLength: 10)
                Text(dish.descriptionDish ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.paragraphText())
                    .foregroundColor(Color.primaryColor1)
                    .lineLimit(2)
                Spacer(minLength: 5)
                //Text("$" + (dish.price ?? ""))
                Text("" + (dish.price ?? "")+" €" )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.highlightText())
                    .foregroundColor(Color.primaryColor1)
                    .monospaced()
            }
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90) // Altura fija
                    //.background(Color.gray.opacity(0.1)) // Fondo gris
                    .clipShape(RoundedRectangle(cornerRadius: 14)) // Bordes redondeados
            } placeholder: {
                ProgressView()
            }
            /*.frame(maxWidth: 90, maxHeight: 90)
            .clipShape(Rectangle())
            .cornerRadius(14)
            .frame(height: 90) // Altura fija
            .background(Color.gray.opacity(0.1)) // Fondo gris*/
            .frame(width: 90, height: 90)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(.vertical)
        .frame(maxHeight: 150)
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem(dish: PersistenceController.oneDish())
            .preferredColorScheme(.light)
            .previewDisplayName("Light")
      
        FoodItem(dish: PersistenceController.oneDish())
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
    
}
