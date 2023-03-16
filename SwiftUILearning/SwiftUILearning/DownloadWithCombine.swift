//
//  DownloadWithCombine.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 13/03/2023.
//

import SwiftUI
import Combine
//MVVM

// Model
struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// View Model
class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine Overview:
        /*
        // 1. sign up for monthly subscription for package delivery
        // 2. The company would make the package behind the scene
        // 3. Receive the package at your front door
        // 4. Make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!
        // 7. cancellable at any time!!
         */
        
        // 1. Create the publisher
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
        // 2. subscribe the publisher on the background thread. We do that above although dataTaskPublisher would do this automaticaly anyway.
        // 3. Receive the package on the main thread
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
        // 5. Decode the PostModel
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
        // 6. sink (put the item into our app)
            //.replaceError(with: [])
            .sink { (completion) in
                // If we didn't care about the error we wouldn't want to use the switch statement below.
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("There was an error \(error)")
                }
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
        // 7. Cancel subscription if needed:
            .store(in: &cancellables)

        
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

// View
struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
