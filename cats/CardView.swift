//
//  CardView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView<ViewModel: CardViewModelProtocol>: View {

    // MARK: Properties
    private var viewModel: ViewModel

    // MARK: Initializers
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            WebImage(url: viewModel.imageUrl) { image in
                image.resizable()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .scaledToFill()
        }
    }
}

#Preview {
    CardView(viewModel: CardViewModel(with: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"))
}
