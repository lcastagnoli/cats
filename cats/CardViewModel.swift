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
}

final class CardViewModel { 

    // MARK: Constants
    enum Constants {
        static let height = 200.0
        static let cornerRadius = 5.0
    }

    // MARK: Properties
    private var urlString: String?
    internal var title: String

    // MARK: Initializers
    init(with url: String?, title: String) {
        self.urlString = url
        self.title = title
    }
}

// MARK: - CardViewModelProtocol
extension CardViewModel: CardViewModelProtocol {

    var imageUrl: URL? { URL(string: urlString ?? "") }
}
