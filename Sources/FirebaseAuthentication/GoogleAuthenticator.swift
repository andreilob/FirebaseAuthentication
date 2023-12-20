import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

public struct GoogleUser {
    var displayName: String?
    var photoURL: URL?
}

final class GoogleAuthenticator {
    func signIn() async throws -> GoogleUser {
        guard let clientID = FirebaseApp.app()?.options.clientID else { throw FirebaseAuthenticationError.noClientID }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let rootVC = Utils.getRootViewController() else { throw FirebaseAuthenticationError.failedToPresentGoogleView }
        let userAuthResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
        let user = userAuthResult.user
        guard let idToken = user.idToken else { throw FirebaseAuthenticationError.noUserToken }
        let accessToken = user.accessToken
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken.tokenString,
            accessToken: accessToken.tokenString
        )
        let result = try await Auth.auth().signIn(with: credential)
        return GoogleUser(displayName: result.user.displayName, photoURL: result.user.photoURL)
    }
}
