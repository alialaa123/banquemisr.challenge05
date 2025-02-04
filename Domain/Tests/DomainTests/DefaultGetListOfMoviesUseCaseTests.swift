import XCTest
@testable import Domain

class DefaultGetListOfMoviesUseCaseTests: XCTestCase {
    // MARK: - SUB
    var useCase: DefaultGetListOfMoviesUseCase!
    var mockRepository: MockListOfMoviesRepository!
    var mockCachingRepository: MockCachingRepository!
    
    // MARK: - Setup & tearDown
    override func setUp() {
        super.setUp()
        mockRepository = MockListOfMoviesRepository()
        mockCachingRepository = MockCachingRepository()
        useCase = DefaultGetListOfMoviesUseCase(
            repository: mockRepository,
            cachingRepository: mockCachingRepository
        )
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Test cases
    func testExecute_WithValid_Request_ReturnExpectedMovies() async {
        // Arrange
        let expectedMovies: [Movie] = [
            Movie(id: 1, movieTitle: "Ali", movieImage: "001.jpg", releaseDate: "01-01-2025"),
            Movie(id: 2, movieTitle: "Jungle in the humble", movieImage: "002.jpg", releaseDate: "02-01-2025"),
        ]
        mockRepository.getListOfMoviesResult = .success(expectedMovies)
        
        // Act
        do {
            let movies = try await useCase.execute(with: "now_playing", page: 1)
            
            // Assert
            XCTAssertEqual(movies, expectedMovies)
        } catch {
            XCTFail("Expected success, got failure: \(error)")
        }
    }
    
    func testExecute_WithTypeScreen_ReturnExpectedListType() async {
        // Arrange
        mockRepository.getListOfMoviesResult = .success([])
        
        // Act
        do {
            _ = try await useCase.execute(with: "now_playing", page: 1)
            
            // Assert
            XCTAssertEqual(mockRepository.listMoviesType, "now_playing")
            XCTAssertEqual(mockRepository.lastPage, 1)
        } catch {
            XCTFail("Expected success, got failure: \(error)")
        }
    }
    
    
    func testExecute_WithError_ReturnExpectedError() async {
        // Arrange
        let expectedError = NSError(domain: "Test Error", code: 1, userInfo: nil)
        
        mockRepository.getListOfMoviesResult = .failure(expectedError)
        mockCachingRepository.getListOfMoviesResult = .failure(expectedError)
        
        // Act
        do {
            _ = try await useCase.execute(with: "now_playing", page: 1)
            XCTFail("Expected failure, got success")
        } catch {
            // Assert
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
}
