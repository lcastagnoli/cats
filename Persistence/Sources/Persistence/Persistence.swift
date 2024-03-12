import SwiftData
import SwiftUI

public protocol PersistenceManagerProtocol {

    func save<T>(_ value: T) where T: PersistentModel
    func delete<T>(type: T.Type) where T: PersistentModel
    func get<T>(type: T.Type) -> T? where T: PersistentModel
}

// MARK: - PersistenceManagerProtocol
public final class PersistenceManager: PersistenceManagerProtocol {

    // MARK: Properties
    @Environment(\.modelContext) var modelContext
    
    // MARK: Initializer
    public init() {}

    public func save<T>(_ value: T) where T : PersistentModel {
        modelContext.insert(value)
        try? modelContext.save()
    }
    public func delete<T>(type: T.Type) where T : PersistentModel {
        try? modelContext.delete(model: type.self)
        try? modelContext.save()
    }
    public func get<T>(type: T.Type) -> T? where T : PersistentModel {
        return modelContext.insertedModelsArray as? T
    }
}
