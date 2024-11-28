import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

final class FirebaseUserService: UserService {
    private let storageManager: FirebaseStorageManager
    private let db: Firestore
    private let collectionName: String = "users"
    init(
        storageManager: FirebaseStorageManager,
        db: Firestore
    ) {
        self.storageManager = storageManager
        self.db = db
        
        // FirebaseApp이 이미 초기화되었는지 확인
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
    }
    
    func createUser(_ user: MolioUserDTO) async throws {
        guard let userData = user.toDictionary() else { return }
        
        let docRef = getDocumentReference(documentName: user.id)
        try await docRef.setData(userData)
    }
    
    func readUser(userID: String) async throws -> MolioUserDTO {
        let docRef = getDocumentReference(documentName: userID)
        return try await docRef.getDocument(as: MolioUserDTO.self)
    }
    
    func updateUser(_ user: MolioUserDTO) async throws {
        guard let updateUserData = user.toDictionary() else { return } // TODO: 딕셔너리 반환 에러 throw
        let docRef = getDocumentReference(documentName: user.id)

        try await docRef.updateData(updateUserData)
    }
    
    func deleteUser(userID: String) async throws {
        let docRef = getDocumentReference(documentName: userID)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            docRef.delete { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    // MARK: - Private Method
    
    private func getDocumentReference(documentName: String) -> DocumentReference {
        return db.collection(collectionName).document(documentName)
    }
}