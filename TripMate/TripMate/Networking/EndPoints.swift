import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct EndPoints {
    let url: URL
    let method: HTTPMethod
    

    static func attractionPlaces(apiKey: String) -> EndPoints {
        let query = "top tourist attractions in UK"
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.googleapis.com"
        components.path = "/maps/api/place/textsearch/json"
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "type", value: "tourist_attraction"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        guard let url = components.url else {
            fatalError("Invalid URL")
        }
        
        print("=====Attraction Place URL===== \(url.absoluteString)")
        return EndPoints(url: url, method: .get)
    }
    
    static func trendingPlaces(lat: Double, lng: Double, radius: Int = 50000, apiKey: String) -> EndPoints {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.googleapis.com"
        components.path = "/maps/api/place/nearbysearch/json"
        components.queryItems = [
            URLQueryItem(name: "location", value: "\(lat),\(lng)"),
            URLQueryItem(name: "radius", value: "\(radius)"),
            URLQueryItem(name: "type", value: "tourist_attraction"),
            URLQueryItem(name: "rankby", value: "prominence"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        guard let url = components.url else {
            fatalError("Invalid URL")
        }
        print("=====Trending Place URL===== \(url.absoluteString)")

        return EndPoints(url: components.url!, method: .get)
    }

}
