import Foundation

// MARK: - HomeSection Enum

enum HomeSection {
    case attractionPlaces([AttractionModel])
    case trendingPlaces([AttractionModel])
    
    var rowHeight: CGFloat {
        switch self {
        case .attractionPlaces: return 213
        case .trendingPlaces: return 280
        }
    }
}

// MARK: - HomeViewModelProtocol

protocol HomeViewModelProtocol: AnyObject {
    
    var sections: [HomeSection] { get }
    
    var onDataUpdated: (() -> Void)? { get set }
    
    var onError: ((Error) -> Void)? { get set }
    
    func fetchAttractionPlaces()
    
    func refreshData()
}
