//
//  BooksAPI.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import Foundation
import SwiftyJSON

class BooksAPI: ObservableObject {

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
                let authors = item["volumeInfo"]["authors"].array!
                var author = ""
                
                for i in authors {
                    author += "\(i.stringValue)"
                }
                
                let description = item["volumeInfo"]["description"].stringValue
                let imurl = item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                let url1 = item["volumeInfo"]["previewLink"].stringValue
                
                books.append(Book(id: id, title: title, authors: author, desc: description, imageUrl: imurl, url: url1))
            }
            
            completion(books)
            
        }.resume()
    }
}
