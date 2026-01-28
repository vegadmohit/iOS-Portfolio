import Foundation

final class MockAttractionRepository: AttractionRepositoryProtocol {

    var result: Result<[AttractionModel], Error>!

    func fetchAttractionsPlaces(type: AttractionType) async throws -> [AttractionModel] {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result not set")
        }
    }
}
