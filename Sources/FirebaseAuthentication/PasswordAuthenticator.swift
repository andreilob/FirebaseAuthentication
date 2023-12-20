import Foundation
import FirebaseAuth

public struct FirebaseUser {
    let id: String
}

final class PasswordAuthenticator {
    func signIn(withEmail email: String, andPassword password: String) async throws -> FirebaseUser {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard let result, error == nil else {
                    continuation.resume(throwing: FirebaseAuthenticationError.failedToAuthenticate)
                    return
                }
                continuation.resume(returning: FirebaseUser(id: result.user.uid))
            }
        }
    }
    
    func createUser(withEmail email: String, andPassword password: String) async throws -> FirebaseUser  {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard let result, error == nil else {
                    continuation.resume(throwing: FirebaseAuthenticationError.failedToCreateUser)
                    return
                }
                continuation.resume(returning: FirebaseUser(id: result.user.uid))
            }
        }
    }
}
