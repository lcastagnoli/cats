//
//  DetailsView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 14/03/24.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftData

struct DetailsView: View {
    
    @State private var isFavorited = false

    // MARK: Properties
    @State private var viewModel: DetailsViewModel
    private var  details: String {
        "Origin: \(viewModel.breed.origin)\nTemperament: \(viewModel.breed.temperament)\nDescription: \(viewModel.breed.description)"
    }

    // MARK: Initializers
    init(modelContext: ModelContext, breed: BreedProtocol) {
        let viewModel = DetailsViewModel(modelContext: modelContext, breed: breed)
        _viewModel = State(initialValue: viewModel)
    }
    
    // MARK: UI
    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                VStack {
                    WebImage(url: URL(string: viewModel.breed.imageUrl))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.top)
                    Text(details)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                Button(action: {
                    viewModel.handleFavourite()
                }) {
                    Image(systemName: viewModel.isFavorited ? "star.fill" : "star")
                        .padding()
                        .foregroundColor(.black)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.breed.name)
    }
}
