import XCTest
@testable import TripMate

final class HomeViewModelTests: XCTestCase {

    func test_fetchAttractionPlaces_success_updatesSections() async {

        // GIVEN
        let mockRepo = MockAttractionRepository()
        mockRepo.result = .success([.mock()])

        let useCase = FetchAttractionsUseCase(repository: mockRepo)
        let viewModel = HomeViewModel(attractionUseCase: useCase)

        let expectation = XCTestExpectation(description: "onDataUpdated called")

        viewModel.onDataUpdated = {
            expectation.fulfill()
        }

        viewModel.fetchAttractionPlaces()

        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.sections.count, 2)
    }

    func test_fetchAttractionPlaces_failure_callsOnError() async {

        let mockRepo = MockAttractionRepository()
        mockRepo.result = .failure(NSError(domain: "TestError", code: 0))

        let useCase = FetchAttractionsUseCase(repository: mockRepo)
        let viewModel = HomeViewModel(attractionUseCase: useCase)

        let expectation = XCTestExpectation(description: "onError called")

        viewModel.onError = { error in
            XCTAssertEqual((error as NSError).domain, "TestError")
            expectation.fulfill()
        }

        viewModel.fetchAttractionPlaces()

        await fulfillment(of: [expectation], timeout: 1)
    }

    func test_refreshData_triggersFetch() async {

        let mockRepo = MockAttractionRepository()
        mockRepo.result = .success([.mock()])

        let useCase = FetchAttractionsUseCase(repository: mockRepo)
        let viewModel = HomeViewModel(attractionUseCase: useCase)

        let expectation = XCTestExpectation(description: "refresh triggers fetch")

        viewModel.onDataUpdated = {
            expectation.fulfill()
        }

        viewModel.refreshData()

        await fulfillment(of: [expectation], timeout: 1)
    }
}
