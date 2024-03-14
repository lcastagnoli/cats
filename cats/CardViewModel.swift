//
//  CardViewModel.swift
//  cats
//
//  Created by Laryssa Castagnoli on 13/03/24.
//

import Foundation
import Combine

protocol CardViewModelProtocol: Identifiable {

    var imageUrl: URL? { get }
    var title: String { get }
    var isFavorited: Bool { get }
}

final class CardViewModel { 

    // MARK: Constants
    enum Constants {
        static let height: CGFloat = 200.0
        static let cornerRadius: CGFloat = 5.0
    }

    // MARK: Properties
    private var urlString: String?
    internal var title: String
    internal var isFavorited: Bool

    // MARK: Initializers
    init(breed: LocalBreed) {
        self.urlString = breed.image
        self.title = breed.name
        self.isFavorited = breed.isFavorited
    }
}

// MARK: - CardViewModelProtocol
extension CardViewModel: CardViewModelProtocol {

    var imageUrl: URL? { URL(string: urlString ?? "") }
}
