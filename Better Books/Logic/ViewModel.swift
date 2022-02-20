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
    
    var userId: String {
        if keychain["userId"] != nil {
//            return keychain["userId"] ?? ""
            return "Te2CAwUnghJ81BJbnp7v"
        } else {
            let internalUserID = UUID().uuidString
            keychain["userId"] = internalUserID
            return internalUserID
        }
    }
    
    
    private let db = Firestore.firestore()
    private let booksApi = BooksAPI()
    
    
    func fetchFavoriteBooks() {
        let docRef = db
            .collection("users")
        
        // Download articles
        docRef.getDocuments() { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("no documents")
                return
            }
            
            print(documents)
            
            documents.forEach { docSnapshot in
                let data = docSnapshot.data()
                
                let userId = docSnapshot.documentID
                let usersFavoriteBooks = data["books"] as? [String] ?? []
                
                if userId == self.userId {
                    for bookId in usersFavoriteBooks {
                        self.booksApi.getBook(id: bookId) { book in
                            self.favoriteBooks.append(book)
                            self.favoriteBooks.sort(by: { $0.title < $1.title })
                        }
                    }
                }
                
                self.allUsers.append(User(id: userId, favoriteBookIds: usersFavoriteBooks))
            }
        }
    }
}
