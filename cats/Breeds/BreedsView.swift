//
//  BreedsView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import SwiftData
import Network
import Combine
import Foundation

struct BreedsView: View {

    // MARK: Properties
    @State private var viewModel: BreedsViewModel
    @State private var searchText = ""
    private var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: .infinity, maximum: .infinity)), GridItem(.adaptive(minimum: .infinity, maximum: .infinity))]

    // MARK: Initializers
    init(modelContext: ModelContext, service: BreedsServiceProtocol) {
        let viewModel = BreedsViewModel(modelContext: modelContext, service: service)
        _viewModel = State(initialValue: viewModel)
    }

    // MARK: UI
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(Array(viewModel.breeds.enumerated()), id: \.offset) { index, breed in
                        NavigationLink(destination: DetailsView(modelContext: viewModel.modelContext, breed: breed)) {
                            CardView(breed: breed,
                                     isFavorite: viewModel.favourites.contains(where: { $0.id == breed.id })) {
                                viewModel.handleFavourite(index: index)
                            }.frame(minWidth: .zero, maxWidth: .infinity)
                        }
                    }
                    .frame(height: Constants.height)
                }.padding(.all, 10)
            }
            .scrollIndicators(.hidden)
            .background(Color.white)
        }
        .accentColor(.black)
        .onAppear {
            viewModel.getBreeds()
            viewModel.fetchData()
        }
        .searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModel.searchBreed(query: searchText)
            }
            .onChange(of: searchText, { old, new in
                guard new.isEmpty else { return }
                viewModel.getBreeds()
            })
    }
}


extension BreedsView {

    @Observable
    class BreedsViewModel {

        // MARK: Properties
        var modelContext: ModelContext
        var favourites = [Favourite]()
        var breeds = [BreedProtocol]()
        private var service: BreedsServiceProtocol
        private var cancellables = Set<AnyCancellable>()

        // MARK: Initializers
        init(modelContext: ModelContext, service: BreedsServiceProtocol) {
            self.modelContext = modelContext
            self.service = service
            fetchData()
        }

        
        // MARK: Methods
        func handleFavourite(index: Int) {

            if let favourite = favourites.first(where: { $0.id == breeds[index].id }) {
                modelContext.delete(favourite)
            } else {
                if let onlineBreed = breeds[index] as? Breed {
                    modelContext.insert(Favourite(with: onlineBreed))
                }
            }
            fetchData()
        }
        

        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Favourite>(sortBy: [SortDescriptor(\.name)])
                favourites = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
        
        func getBreeds() {
            
            service.breeds()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] receivedCompletion in
                    self?.handle(completion: receivedCompletion)
                }, receiveValue: { [weak self] response in
                    self?.handle(response: response)
                })
                .store(in: &cancellables)
        }
        
        func searchBreed(query: String) {

            service.searchBreed(with: query)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.handle(completion: completion)
                }, receiveValue: { [weak self] response in
                    self?.handle(response: response)
                })
                .store(in: &cancellables)
        }
        
        private func handle(completion: Subscribers.Completion<Error>) {
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                break
            }
        }

        private func handle(response: [Breed]) {
            breeds = response
        }
    }
}
