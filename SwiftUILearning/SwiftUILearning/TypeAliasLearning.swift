//
//  TypeAliasLearning.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 09/03/2023.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}
// instead of setting up another struct like we have above and below for similar purposes you can use type alias to set up another type based on the original.

typealias TVModel = MovieModel

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}

struct TypeAliasLearning: View {
    
    @State var item: MovieModel = MovieModel(title: "Title", director: "Josh", count: 5)
    @State var tvitem: TVModel = TVModel(title: "TV Show", director: "Sam", count: 3)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypeAliasLearning_Previews: PreviewProvider {
    static var previews: some View {
        TypeAliasLearning()
    }
}
