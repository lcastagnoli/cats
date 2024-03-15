//
//  CardView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {

    // MARK: Properties
    private var breed: BreedProtocol
    private var isFavorite: Bool
    private var didTapFavourite: () -> Void

    // MARK: Initializers
    init(breed: BreedProtocol, isFavorite: Bool, didTapFavourite: @escaping () -> Void) {
        self.breed = breed
        self.isFavorite = isFavorite
        self.didTapFavourite = didTapFavourite
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                GeometryReader { geo in
                    WebImage(url: URL(string: breed.imageUrl))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFill()
                        .shadow(radius: Constants.cornerRadius)
                        .clipShape(
                            .rect(
                                topLeadingRadius: Constants.cornerRadius,
                                bottomLeadingRadius: .zero,
                                bottomTrailingRadius: .zero,
                                topTrailingRadius: Constants.cornerRadius
                            )
                        )
                        .frame(width: geo.size.width, height: 150)
                        .clipped()
                }
                Text(breed.name)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.black)
            }
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2))
            Button(action: {
                didTapFavourite()
            }) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .padding()
                    .foregroundColor(.black)
                    .background(.white.opacity(0.5))
                    .cornerRadius(50)
            }
        }
    }
}
