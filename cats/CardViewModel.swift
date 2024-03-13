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
}

final class CardViewModel { 

    // MARK: Properties
    private var urlString: String?

    // MARK: Initializers
    init(with string: String?) {
        self.urlString = string
    }
}

// MARK: - CardViewModelProtocol
extension CardViewModel: CardViewModelProtocol {

    var imageUrl: URL? { URL(string: urlString ?? "") }
}
