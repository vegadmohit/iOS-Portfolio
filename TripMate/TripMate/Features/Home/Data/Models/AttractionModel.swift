import Foundation

struct AttractionResponse: Codable {
    let results: [AttractionModel]
}

struct AttractionModel: Codable {
    
    let name: String
    let formatted_address: String?
    let vicinity: String?
    let rating: Double?
    let user_ratings_total: Int?
    let geometry: Geometry
    let photos: [Photo]?
    
    // MARK: - Computed Properties
    var address: String {
        if let formatted = formatted_address {
            return formatted
        } else if let vicinity = vicinity {
            return vicinity
        } else {
            return "No address"
        }
    }
    
    func photoURL(maxWidth: Int = 400) -> URL? {
        guard let photoReference = photos?.first?.photo_reference else { return nil }
        var components = URLComponents(string: "https://maps.googleapis.com/maps/api/place/photo")
        components?.queryItems = [
            URLQueryItem(name: "maxwidth", value: "\(maxWidth)"),
            URLQueryItem(name: "photoreference", value: photoReference),
            URLQueryItem(name: "key", value: APIConstants.googleAPIKey)
        ]
        return components?.url
    }
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

struct Photo: Codable {
    let photo_reference: String
}
