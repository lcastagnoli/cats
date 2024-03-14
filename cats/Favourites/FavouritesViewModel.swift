//
//  FavouritesViewModel.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import Network
import SwiftUI
import Foundation

protocol FavouritesViewModelProtocol: ObservableObject {}
final class FavouritesViewModel {

    // MARK: Initializers
    init() {}
}

// MARK: - FavouritesViewModelProtocol
extension FavouritesViewModel: FavouritesViewModelProtocol {}
