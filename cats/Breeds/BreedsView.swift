//
//  BreedsView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI

struct BreedsView<ViewModel: BreedsViewModelProtocol>: View {

    // MARK: Properties
    @ObservedObject private var viewModel: ViewModel

    // MARK: Initializers
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                        ForEach(viewModel.cardViewModels) { cardViewModel in
                            CardView(viewModel: cardViewModel)
                                .frame(width: geometry.size.width/2, height: 200)
                                .clipped()
                        }
                    }
                }
            }
            .background(Color.black)
        }.onAppear {

            getBreeds()
        }
    }
    
    private func getBreeds() {
        
        viewModel.getBreeds()
    }
}
