final class FetchAttractionsUseCase {
    
    private let repository: AttractionRepositoryProtocol
    
    init(repository: AttractionRepositoryProtocol = AttractionRepository()) {
        self.repository = repository
    }
    
    func execute(type: AttractionType) async throws -> [AttractionModel] {
        return try await repository.fetchAttractionsPlaces(type: type)
    }
}
