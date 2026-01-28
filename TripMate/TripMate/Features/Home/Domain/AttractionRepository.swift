
enum AttractionType {
    case attractive
    case trending
}

protocol AttractionRepositoryProtocol {
    func fetchAttractionsPlaces(type: AttractionType) async throws -> [AttractionModel]
}

class AttractionRepository: AttractionRepositoryProtocol {
    
    let latitude = 51.5074
    let longitude = -0.1278
    
    private let apiClient: APIClient
    private let apiKey: String
    
    init(apiClient: APIClient = APIClient(), apiKey: String = APIConstants.googleAPIKey) {
        self.apiClient = apiClient
        self.apiKey = apiKey
    }
    
    func fetchAttractionsPlaces(type: AttractionType) async throws -> [AttractionModel] {
        let endpoint: EndPoints
        switch type {
        case .attractive:
            endpoint = EndPoints.attractionPlaces(apiKey: apiKey)
        case .trending:
            endpoint = EndPoints.trendingPlaces(lat: latitude, lng: longitude, radius: 10000, apiKey: apiKey)
        }
        let response: AttractionResponse = try await apiClient.request(endpoint: endpoint)
        return response.results
    }


}
