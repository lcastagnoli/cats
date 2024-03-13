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
    private var width: CGFloat

    // MARK: Initializers
    init(viewModel: ViewModel, width: CGFloat) {
        self.viewModel = viewModel
        self.width = width
    }

    var body: some View {
        VStack {
            WebImage(url: viewModel.imageUrl)
                .resizable()
                .indicator(.activity)
                .shadow(radius: CardViewModel.Constants.cornerRadius)
                .clipped()
                .clipShape(
                    .rect(
                        topLeadingRadius: CardViewModel.Constants.cornerRadius,
                        bottomLeadingRadius: .zero,
                        bottomTrailingRadius: .zero,
                        topTrailingRadius: CardViewModel.Constants.cornerRadius
                    )
                )
            
            Text(viewModel.title)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: width, height: CardViewModel.Constants.height)
        .background(
                    RoundedRectangle(cornerRadius: CardViewModel.Constants.cornerRadius)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2))
    }
}

#Preview {
    CardView(viewModel: CardViewModel(with: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic", title: "Abys"), width: 182)
}
