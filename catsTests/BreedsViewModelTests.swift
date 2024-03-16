//
//  BreedsViewModelTests.swift
//  catsTests
//
//  Created by Laryssa Castagnoli on 15/03/24.
//

import XCTest
import Combine
import SwiftData
import SwiftUI
@testable import cats

final class BreedsViewModelTests: XCTestCase {
    
    func testViewModel_getBreeds_with_response_data() {

        let expectation = XCTestExpectation(description: "getBreeds")

        // Given
        let mockBreeds = FakeData.mockBreeds
        let service = FakeBreedsService(breedsExpectation: mockBreeds)
        let viewModel = BreedsView.BreedsViewModel(modelContext: FakeData.modelContext, service: service)
        
        
        viewModel.getBreeds()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { expectation.fulfill() }

        // When
        wait(for: [expectation], timeout: 2)
        
        // Then
        XCTAssertEqual(viewModel.breeds.count, mockBreeds.count)
    }

    func testViewModel_getBreeds_with_empty_response_data() {

        let expectation = XCTestExpectation(description: "getBreeds")

        // Given
        let mockBreeds = FakeData.emptyBreeds
        let service = FakeBreedsService(breedsExpectation: mockBreeds)
        let viewModel = BreedsView.BreedsViewModel(modelContext: FakeData.modelContext, service: service)
        
        
        viewModel.getBreeds()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { expectation.fulfill() }

        // When
        wait(for: [expectation], timeout: 3)
        
        // Then
        XCTAssertEqual(viewModel.breeds.count, .zero)
    }

    func testViewModel_searchBreeds_with_response_data() {

        let expectation = XCTestExpectation(description: "searchBreed")

        // Given
        let mockBreeds = FakeData.mockBreeds
        let service = FakeBreedsService(searchBreedsExpectation: mockBreeds)
        let viewModel = BreedsView.BreedsViewModel(modelContext: FakeData.modelContext, service: service)
        
        
        viewModel.searchBreed(query: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { expectation.fulfill() }

        // When
        wait(for: [expectation], timeout: 2)
        
        // Then
        XCTAssertEqual(viewModel.breeds.count, mockBreeds.count)
    }

    func testViewModel_searchBreeds_with_empty_response_data() {

        let expectation = XCTestExpectation(description: "searchBreed")

        // Given
        let mockBreeds = FakeData.emptyBreeds
        let service = FakeBreedsService(searchBreedsExpectation: mockBreeds)
        let viewModel = BreedsView.BreedsViewModel(modelContext: FakeData.modelContext, service: service)
        
        
        viewModel.searchBreed(query: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { expectation.fulfill() }

        // When
        wait(for: [expectation], timeout: 2)
        
        // Then
        XCTAssertEqual(viewModel.breeds.count, .zero)
    }
}
