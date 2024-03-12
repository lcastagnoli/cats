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
            Text("Breeds")
        }.onAppear {
            getBreeds()
        }
    }
    
    private func getBreeds() {
        
        viewModel.getBreeds()
    }
}
