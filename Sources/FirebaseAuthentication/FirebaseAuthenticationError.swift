import Foundation

enum FirebaseAuthenticationError: Error {
    case noClientID
    case failedToPresentGoogleView
    case noUserToken
    case failedToAuthenticate
    case failedToCreateUser
}
