import XCTest
@testable import Data
@testable import Domain
@testable import NetworkLayer

class DefaultGetListOfMoviesRemoteTests: XCTestCase {
    // MARK: - SUB
    var remote: DefaultGetListOfMoviesRemote!
    var mockNetworkClient: MockNetworkClient!
    var mockKeyChain: MockKeychainManager!
    
    // MARK: - Setup & tearDown
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        mockKeyChain = MockKeychainManager()
        remote = DefaultGetListOfMoviesRemote(
            client: mockNetworkClient,
            keychainManager: mockKeyChain
        )
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        remote = nil
        super.tearDown()
    }
    
    // MARK: - test cases
    func testGetListOfMovies_Success() async {
        // Arrange
        let expectedMovies = [
            MovieDTO(id: 1, movieTitle: "Ali", movieImage: "001.jpg"),
            MovieDTO(id: 2, movieTitle: "Jungle in the humble", movieImage: "002.jpg")
        ]
        
        let responseDTO = ListOfMoviesResponseDTO(page: 1, results: expectedMovies)
        mockNetworkClient.sendResult = .success(responseDTO)
        
        // Act
        do {
            let listOfMoviesResponse = try await remote.getListOfMovies(with: "now_playing", page: 1)
            // Assert
            XCTAssertEqual(listOfMoviesResponse.count, 2)
            XCTAssertEqual(listOfMoviesResponse[0].id, 1)
            XCTAssertEqual(listOfMoviesResponse[0].movieTitle, "Ali")
            XCTAssertEqual(listOfMoviesResponse[1].movieTitle, "Jungle in the humble")
        } catch {
            XCTFail("Expected success, got error: \(error)")
        }
    }
    
    func testGetListOfMovies_Failure() async {
        // Arrange
        let expectedError = NSError(domain: "test Error", code: 1, userInfo: nil)
        mockNetworkClient.sendResult = .failure(expectedError)
        
        // Act
        do {
            _ = try await remote.getListOfMovies(with: "now_playing", page: 1)
            XCTFail("Expected failure, got success")
        } catch {
         // Assert
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}
