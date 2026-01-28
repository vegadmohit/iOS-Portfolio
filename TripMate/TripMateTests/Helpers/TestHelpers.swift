import Foundation

extension AttractionModel {
    static func mock(
        name: String = "Test Place") -> AttractionModel {
        AttractionModel(name: name,formatted_address: "Test Address",vicinity: nil,rating: nil,user_ratings_total: nil,geometry: Geometry(location: Location(lat: 0, lng: 0)),
            photos: [])
    }
}
