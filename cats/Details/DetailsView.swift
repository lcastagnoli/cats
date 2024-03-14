//
//  DetailsView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 14/03/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    
    @State private var isFavorited = false

    // MARK: Properties
    private var breed: LocalBreed
    private var  details: String {
        "Origin: \(breed.origin)\nTemperament: \(breed.temperament)\nDescription: \(breed.descriptionBreed)"
    }

    // MARK: Initializers
    init(breed: LocalBreed) {
        self.breed = breed
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                VStack {
                    WebImage(url: URL(string: breed.image))
                        .resizable()
                        .indicator(.activity)
                        .frame(height: 200)
                        .edgesIgnoringSafeArea(.top)
                    Text(details)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                Button(action: {
                    breed.isFavorited.toggle()
                }) {
                    Image(systemName: breed.isFavorited ? "star.fill" : "star")
                        .padding()
                        .foregroundColor(.black)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(breed.name)
    }
}

#Preview {
    DetailsView(breed: LocalBreed(id: "", name: "", temperament: "", origin: "", descriptionBreed: "", image: "", lifeSpan: "", isFavorited: true))
}
