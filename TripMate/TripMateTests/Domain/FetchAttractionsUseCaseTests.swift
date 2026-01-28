import XCTest
@testable import TripMate

func test_fetchAttractionsUseCase_success() async throws {
    let mockRepo = MockAttractionRepository()
    mockRepo.result = .success([.mock()])
    
    let useCase = FetchAttractionsUseCase(repository: mockRepo)
    let attractions = try await useCase.execute(type: .attractive)
    
    XCTAssertEqual(attractions.count, 1)
    XCTAssertEqual(attractions.first?.name, "Test Place")
}

func test_fetchAttractionsUseCase_failure() async {
    let mockRepo = MockAttractionRepository()
    mockRepo.result = .failure(NSError(domain: "TestError", code: 0))
    
    let useCase = FetchAttractionsUseCase(repository: mockRepo)
    
    do {
        _ = try await useCase.execute(type: .trending)
        XCTFail("Expected to throw error")
    } catch let error as NSError {
        XCTAssertEqual(error.domain, "TestError")
        XCTAssertEqual(error.code, 0)
    }
}
