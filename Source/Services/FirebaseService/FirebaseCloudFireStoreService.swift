//
//  FirebaseCloudFireStoreService.swift
//  TaleneCore
//
//  Created by Emmanuvel Thamel on 6/17/20.
//

import Foundation
import FirebaseFirestore

public typealias TCListenerRegistration = ListenerRegistration

public protocol FirebaseCloudFireStoreService: AppConfigure {
    func create<T: Codable>(item: T, in collection: String, withCompletion completion: @escaping (Result<String, TCFirestoreError>) -> Void)
    func create<T: Codable>(item: T, withDocumentId documentId: String, in collection: String, withCompletion completion: @escaping (Result<String, TCFirestoreError>) -> Void)
    func all<T: Codable>(forCollection collection: String, withCompletion completion: @escaping (Result<[T], TCFirestoreError>) -> Void)
    func read<T: Codable>(documentId id: String, inCollection collection: String, withCompletion completion: @escaping (Result<T, TCFirestoreError>) -> Void)
    func delete(documentId id: String, inCollection collection: String, withCompletion completion: @escaping (Result<Bool, TCFirestoreError>) -> Void)
    func addListener<T: Codable>(toCollection collection: String, documentId: String, withCompletion completion: @escaping (Result<T, TCFirestoreError>) -> Void) -> ListenerRegistration?
}

public enum TCFirestoreError: Error {
    case nilDocumentID
    case invalidDocumentId
    case errorAddingDocument
    case errorFetchingAllDocuments
    case errorFetchingDocument(String)
    case documentDoesNotExist(String)
    case documentDecodingError(String)
    case documentDeletionFailed(String)
}

class FirebaseCloudFireStoreServiceProvider: FirebaseCloudFireStoreService {

    var db: Firestore? = nil
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        db = Firestore.firestore()
    }

    func create<T: Codable>(item: T, in collection: String, withCompletion completion: @escaping (Result<String, TCFirestoreError>) -> Void) {
        var ref: DocumentReference? = nil
        guard let dataDictionary = toDictionary(item) else { return }
        ref = db?.collection(collection).addDocument(data: dataDictionary) { err in
            if let err = err {
                App.managers.logger.error(message: "Error adding document: \(err)")
                completion(.failure(.errorAddingDocument))
            } else {
                if let id = ref?.documentID {
                    App.managers.logger.info(message: "Document added with ID: \(id)")
                    completion(.success(id))
                } else {
                    App.managers.logger.error(message: "Error adding document: nil document id")
                    completion(.failure(.nilDocumentID))
                }
            }
        }
    }

    func create<T: Codable>(item: T, withDocumentId documentId: String, in collection: String, withCompletion completion: @escaping (Result<String, TCFirestoreError>) -> Void) {
        guard let dataDictionary = toDictionary(item) else { return }

        db?.collection(collection).document(documentId).setData(dataDictionary) { err in
            if let err = err {
                App.managers.logger.error(message: "Error adding document: \(err)")
                completion(.failure(.errorAddingDocument))
            } else {
                App.managers.logger.info(message: "Document added with ID: \(documentId)")
                completion(.success(documentId))
            }
        }
    }

    func all<T: Codable>(forCollection collection: String, withCompletion completion: @escaping (Result<[T], TCFirestoreError>) -> Void) {
        db?.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                App.managers.logger.error(message: "Error getting documents: \(err)")
                completion(.failure(.errorFetchingAllDocuments))
            } else {
                var items: [T?] = []
                items.removeAll()
                for document in querySnapshot!.documents {
                    let item = try? JSONDecoder().decode(T.self, withJSONObject: document.data())
                    items.append(item)
                    App.managers.logger.info(message: "\(document.documentID) => \(document.data())")
                }
                completion(.success(items.compactMap{ $0 }))
            }
        }
    }

    func read<T: Codable>(documentId id: String, inCollection collection: String, withCompletion completion: @escaping (Result<T, TCFirestoreError>) -> Void) {
        let docRef = db?.collection(collection).document(id)
        docRef?.getDocument { (document, error) in
            if let document = document, document.exists {
                if let item = try? JSONDecoder().decode(T.self, withJSONObject: document.data() as Any) {
                    App.managers.logger.info(message: "Fetched document id: \(document.documentID)")
                    completion(.success(item))
                } else {
                    App.managers.logger.error(message: "Document \(id) decoding error.")
                    completion(.failure(.documentDecodingError(id)))
                }
            } else {
                App.managers.logger.error(message: "Document \(id) does not exist.")
                completion(.failure(.documentDoesNotExist(id)))
            }
        }
    }

    func delete(documentId id: String, inCollection collection: String, withCompletion completion: @escaping (Result<Bool, TCFirestoreError>) -> Void) {
        db?.collection(collection).document(id).delete() { err in
            if let err = err {
                App.managers.logger.error(message: "Error removing documentId:\(id) Error: \(err)")
                completion(.failure(.documentDeletionFailed(id)))
            } else {
                App.managers.logger.info(message: "Document: \(id) successfully removed!")
                completion(.success(true))
            }
        }
    }

    private func toDictionary<T: Codable>(_ item: T) -> [String: Any]? {
        encoder.outputFormatting = .prettyPrinted
        guard let jsonData = try? encoder.encode(item) else { return nil}
        guard let dataDictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else { return nil}
        print(String(data: jsonData, encoding: .utf8)!)
        return dataDictionary
    }

    func addListener<T: Codable>(toCollection collection: String, documentId: String, withCompletion completion: @escaping (Result<T, TCFirestoreError>) -> Void) -> TCListenerRegistration? {
        let listener = db?.collection(collection).document(documentId)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    App.managers.logger.error(message: "Fetched document id: \(documentId)")
                    completion(.failure(.errorFetchingDocument(documentId)))
                    return
                }

                guard let data = document.data() else {
                    App.managers.logger.error(message: "Fetched document id: \(documentId)")
                    completion(.failure(.errorFetchingDocument(documentId)))
                    return
                }

                App.managers.logger.info(message: "Fetched document id: \(documentId)")
                if let item = try? JSONDecoder().decode(T.self, withJSONObject: data as Any) {
                    App.managers.logger.info(message: "Fetched document id: \(documentId)")
                    completion(.success(item))
                } else {
                    App.managers.logger.error(message: "Document \(documentId) decoding error.")
                    completion(.failure(.documentDecodingError(documentId)))
                }
        }
        return listener
    }

}
