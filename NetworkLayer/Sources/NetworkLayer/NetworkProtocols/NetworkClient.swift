
// MARK: - Network client protocol
public protocol NetworkClient {
    func send<T: APIResquest>(_ request: T) async throws -> T.Response
}
