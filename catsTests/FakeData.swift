//
//  FakeData.swift
//  catsTests
//
//  Created by Laryssa Castagnoli on 15/03/24.
//

@testable import cats
import SwiftData

enum FakeData {
    
    static let mockBreeds: [Breed] = [
        Breed(id: "", name: "", temperament: "", origin: "", description: "", image: BreedImage(id: "", url: ""), lifeSpan: ""),
        Breed(id: "", name: "", temperament: "", origin: "", description: "", image: BreedImage(id: "", url: ""), lifeSpan: ""),
        Breed(id: "", name: "", temperament: "", origin: "", description: "", image: BreedImage(id: "", url: ""), lifeSpan: "")
    ]
    
    static let emptyBreeds: [Breed] = []
    
    static let modelContext: ModelContext = {
        let container = try! ModelContainer(for: Favourite.self)
        return ModelContext(container)
    }()
}
