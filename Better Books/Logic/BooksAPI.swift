//
//  BooksAPI.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI
import SwiftyJSON

class BooksAPI: ObservableObject {

    let imageCache = ImageCache()
    
    func getBooksList(searchQuery: String, completion: @escaping ([Book]) -> Void) {
        
        let apiUrl = "https://www.googleapis.com/books/v1/volumes?q=\(String(describing: searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))"
        
        URLSession(configuration: .default).dataTask(with: URL(string: apiUrl)!) { (data, _, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let items = json["items"].array!
            
            var books: [Book] = []
            
            for item in items {
                
                let id = item["id"].stringValue
                let title = item["volumeInfo"]["title"].stringValue
                var authors = ""
                
                for i in item["volumeInfo"]["authors"].array! {
                    authors += "\(i.stringValue)"
                }
                
                let description = item["volumeInfo"]["description"].stringValue
                let imageUrl = URL(string: item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue.replacingOccurrences(of: "http://", with: "https://"))!
                let url = URL(string: item["volumeInfo"]["previewLink"].stringValue.replacingOccurrences(of: "http://", with: "https://"))!
                
                self.imageCache.loadImage(atUrl: imageUrl, key: id) { (urlString, image) in
                    guard let image = image else {
                        
                        
                        return
                    }
                    
                    books.append(Book(id: id, title: title, authors: authors, description: description, image: Image(uiImage: image), url: url))
                }
            }
            
            completion(books)
            
        }.resume()
    }
}
