import SwiftUI
import Firebase

public final class FirebaseAuthentication {
    private let googleAuth = GoogleAuthenticator()
    private let passwordAuth = PasswordAuthenticator()
    
    public init() {}
    
    public func configure() {
        FirebaseApp.configure()
    }
    
    public func signIn(withEmail email: String, andPassword password: String) async throws -> FirebaseUser {
        try await passwordAuth.signIn(withEmail: email, andPassword: password)
    }
    
    public func signInWithGoogle() async throws -> GoogleUser {
        try await googleAuth.signIn()
    }
    
    public func createUser(withEmail email: String, andPassword password: String) async throws -> FirebaseUser {
        try await passwordAuth.createUser(withEmail: email, andPassword: password)
    }
}
