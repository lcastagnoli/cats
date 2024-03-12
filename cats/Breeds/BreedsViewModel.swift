//
//  BreedsViewModel.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import Network
import Combine

protocol BreedsViewModelProtocol: ObservableObject { }
final class BreedsViewModel {
    init() {}
}

// MARK: - BreedsViewModelProtocol
extension BreedsViewModel: BreedsViewModelProtocol {}

