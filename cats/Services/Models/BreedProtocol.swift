//
//  BreedProtocol.swift
//  cats
//
//  Created by Laryssa Castagnoli on 15/03/24.
//

protocol BreedProtocol {
 
    var id: String { get }
    var name: String { get }
    var temperament: String { get }
    var origin: String { get }
    var description: String { get }
    var imageUrl: String { get }
    var lifeSpan: String { get }
}
