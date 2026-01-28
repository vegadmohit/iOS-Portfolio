import Foundation
import UIKit

final class HomeViewModel: HomeViewModelProtocol {
    
    private let attractionUseCase: FetchAttractionsUseCase
    private(set) var sections: [HomeSection] = []
    
    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(attractionUseCase: FetchAttractionsUseCase = FetchAttractionsUseCase()) {
           self.attractionUseCase = attractionUseCase
       }
    // MARK: - Methods
    
    func fetchAttractionPlaces() {
        Task {
            do {
                let attractions = try await attractionUseCase.execute(type: .attractive)
                let trending = try await attractionUseCase.execute(type: .trending)
                
                self.sections = [
                    .attractionPlaces(attractions),
                    .trendingPlaces(trending)
                ]
                DispatchQueue.main.async {
                    self.onDataUpdated?()
                }
            } catch {
                DispatchQueue.main.async {
                    self.onError?(error)
                }
            }
        }
    }
    
    func refreshData() {
        fetchAttractionPlaces()
    }
}
