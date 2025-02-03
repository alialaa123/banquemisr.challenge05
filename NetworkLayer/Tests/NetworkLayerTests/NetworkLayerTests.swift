
import XCTest
@testable import NetworkLayer

class APIClientTests: XCTestCase {
    // MARK: - SUB
    var apiClient: APIClient!
    var mockSession: MockURLSession!
    
    // MARK: - Setup & tearDown
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        apiClient = APIClient(baseURL: "https://example.com", session: mockSession)
    }
    
    override func tearDown() {
        apiClient = nil
        mockSession = nil
        super.tearDown()
    }
    
    // MARK: - Test cases
    func testSendRequestSuccess() async {
        // Arrange
        let mockData = """
         {"id": 1, "movieTitle": "Test", "movieImage": "/sdjdnasdjsd.jpg"}
         """.data(using: .utf8)!
        mockSession.nextData = mockData
        mockSession.nextResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let request = MockAPIRequest()
        
        do {
            // Act
            let response: MockMovieResponse = try await apiClient.send(request)
            
            // Assert
            XCTAssertEqual(response.id, 1)
            XCTAssertEqual(response.movieTitle, "Test")
            XCTAssertEqual(response.movieImage, "/sdjdnasdjsd.jpg")
        } catch {
            XCTFail("Request should not fail: \(error)")
        }
    }
    
    func testSendWithRetrySuccess() async {
        // Arrange
        let mockData = """
        {"id": 1, "movieTitle": "Test", "movieImage": "/sdjdnasdjsd.jpg"}
        """.data(using: .utf8)!
        
        mockSession.nextData = mockData
        mockSession.nextResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let request = MockRetryableRequest()
        
        do {
            // Act
            let response: MockMovieResponse = try await apiClient.sendWithRetry(request)
            
            // Assert
            XCTAssertEqual(response.id, 1)
            XCTAssertEqual(response.movieTitle, "Test")
            XCTAssertEqual(response.movieImage, "/sdjdnasdjsd.jpg")
        } catch {
            XCTFail("Request should not fail: \(error)")
        }
    }
    
    func testSendRequestFailure() async {
        // Arrange
        mockSession.nextData = nil
        mockSession.nextResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        
        let request = MockAPIRequest()
        
        do {
            // Act
            let _: MockMovieResponse = try await apiClient.send(request)
            XCTFail("Request should fail")
        } catch {
            // Assert
            XCTAssertTrue(error is NetworkError)
        }
    }
    
    func testSendRequestFailureDecoding() async {
        // Arrange
        mockSession.nextData = "Invalid JSON".data(using: .utf8)!
        mockSession.nextResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let request = MockAPIRequest()
        
        do {
            // Act
            let _: MockMovieResponse = try await apiClient.send(request)
        } catch {
            // Assert
            if let networkError = error as? NetworkError {
                if case .decodingFailed(let decodingError) = networkError {
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Expected NetworkError.decodingFailed, got: \(networkError)")
                }
            } else {
                XCTFail("Expected NetworkError, got: \(error)")
            }
        }
    }
    
    func testSendRequestFailureAuthorization() async {
        // Arrange
        mockSession.nextData = """
         {"message": "user is unauthorized"}
        """.data(using: .utf8)
        mockSession.nextResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 401,
            httpVersion: nil,
            headerFields: nil
        )
        
        let request = MockAPIRequest()
        
        do {
            // Act
            let _: MockMovieResponse = try await apiClient.send(request)
            XCTFail("Request should fail")
        } catch {
            if let networkError = error as? NetworkError, case .unauthorized = networkError {
                XCTAssertTrue(true)
            } else {
                XCTFail("Expected NetworkError.unauthorized, got: \(error)")
            }
        }
    }
}
