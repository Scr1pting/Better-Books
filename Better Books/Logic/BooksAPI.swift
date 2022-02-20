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
    
    func getBook(id: String, completion: @escaping (Book) -> Void) {
        let apiUrl = "https://www.googleapis.com/books/v1/volumes/\(id)"
        
        DispatchQueue.global(qos: .utility).async {
            if InternetReachability.isConnectedToNetwork() {
                self.imageCache.clearLocalCache()
            }
        }
        
        URLSession(configuration: .default).dataTask(with: URL(string: apiUrl)!) { (data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            let id = json["id"].stringValue
            let title = json["volumeInfo"]["title"].stringValue
            var authors = ""
            
            for i in json["volumeInfo"]["authors"].array! {
                authors += "\(i.stringValue)"
            }
            
            let description = json["volumeInfo"]["description"].stringValue
            let imageUrl = URL(string: json["volumeInfo"]["imageLinks"]["large"].stringValue.replacingOccurrences(of: "http://", with: "https://")) ?? URL(string: json["volumeInfo"]["imageLinks"]["small"].stringValue.replacingOccurrences(of: "http://", with: "https://")) ?? URL(string: json["volumeInfo"]["imageLinks"]["thumbnail"].stringValue.replacingOccurrences(of: "http://", with: "https://")) ?? URL(string: "https://no-image-available.com")!
            let url = URL(string: json["volumeInfo"]["previewLink"].stringValue.replacingOccurrences(of: "http://", with: "https://")) ?? URL(string: "https://example.com")!
            
            if imageUrl.absoluteString != "https://no-image-available.com" {
                self.imageCache.loadImage(atUrl: imageUrl, key: id) { (urlString, image) in
                    guard let image = image else {
                        return
                    }
                    
                    completion(Book(id: id, title: title, authors: authors, description: description, image: Image(uiImage: image), url: url))
                }
            } else {
                completion(Book(id: id, title: title, authors: authors, description: description, image: Image("ImageUnavailbe"), url: url))
            }
            
        }.resume()
    }
    
    func bookSearch(query: String, completion: @escaping ([Book]) -> Void) {
        
        let apiUrl = "https://www.googleapis.com/books/v1/volumes?q=\(String(describing: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))"
        
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
                
                for i in item["volumeInfo"]["authors"].array ?? [] {
                    authors += "\(i.stringValue)"
                }
                
                let description = item["volumeInfo"]["description"].stringValue
                let imageUrl = URL(string: item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue.replacingOccurrences(of: "http://", with: "https://"))!
                let url = URL(string: item["volumeInfo"]["previewLink"].stringValue.replacingOccurrences(of: "http://", with: "https://"))!
                
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    guard let data = data, let image = UIImage(data: data) else {
                        print("An unknown error occured while downloading the book image")
                        return
                    }
                    
                    books.append(Book(id: id, title: title, authors: authors, description: description, image: Image(uiImage: image), url: url))
                    
                    if books.count == items.count {
                        completion(books)
                    }
                }
                .resume()
            }
            
        }.resume()
    }
}
