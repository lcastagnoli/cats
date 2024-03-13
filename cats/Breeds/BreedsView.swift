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
    @State var gridLayout: [GridItem] = [ GridItem(.flexible()), GridItem(.flexible())]
    @State private var searchText = ""

    // MARK: Initializers
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                        ForEach(viewModel.cardViewModels) { cardViewModel in
                            CardView(viewModel: cardViewModel, width: (geometry.size.width - 10) / 2)
                        }.frame(width: CardViewModel.Constants.height, height: CardViewModel.Constants.height)
                    }
                }   
                .scrollIndicators(.hidden)
            }
            .padding()
            .background(Color.white)
        }.onAppear {
            viewModel.getBreeds()
        }.searchable(text: $searchText)
    }
}
