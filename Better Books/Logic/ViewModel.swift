//
//  ViewModel.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import Foundation
import FirebaseFirestore
import KeychainAccess

class ViewModel: ObservableObject {
    @Published var favoriteBooks = [Book]()
    
    @Published var allUsers = [User]()
    
    let keychain = Keychain(service: "de.the-cyborgs.Better-Books")
        .synchronizable(true)
    
    var userId: UUID {
        if keychain["userId"] != nil {
            return UUID(uuidString: keychain["userId"] ?? "") ?? UUID()
        } else {
            let internalUserID = UUID()
            keychain["userId"] = internalUserID.uuidString
            return internalUserID
        }
    }
    
    private let db = Firestore.firestore()
    
    func fetchFavoriteBooks() {
        let docRef = db
            .collection("users")
        
        // Download articles
        docRef.getDocuments() { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("no documents")
                return
            }
            
            documents.forEach { docSnapshot in
                let data = docSnapshot.data()
                
                let userId = docSnapshot.documentID
                var usersFavoriteBooks = data["books"] as? [String] ?? []
                
                self.allUsers.append(User(id: userId, favoriteBookIds: usersFavoriteBooks))
            }
            
            print("All Users: \(self.allUsers)")
        }
    }
}
