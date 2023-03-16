//
//  DownloadWithEscapingLearning.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 09/03/2023.
//

import SwiftUI

// Again Model, View Model, View
// Codable decodes our data efficiently.
//struct PostsModel: Identifiable, Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostsModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        downloadData(fromURL: url) { (returnedData) in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([PostsModel].self, from: data) else {return}
                // We append the data to the main thread below and we use weak self because we are good coders.
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
                
            } else {
                print("No data returned")
            }
        }
        
    }
    // We can use the below function across our app if we're downloading something. We go to the url and it returns us generic data.
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        // dataTask by default uses background threads by default. This is dope. We call completion once the data is downloaded. We use @escaping because the below is asynchronus.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloading data")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
        
        
    }
}

struct DownloadWithEscapingLearning: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithEscapingLearning_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingLearning()
    }
}
