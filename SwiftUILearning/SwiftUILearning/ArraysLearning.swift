//
//  ArraysLearning.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 14/03/2023.
//

import SwiftUI

// model:

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let point: Int
    let isVerified: Bool
}

// viewModel:

class ArrayModificationViewModel: ObservableObject {

    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    
    init() {
        getUsers()
        updatedFilteredArray()
    }
    
    func updatedFilteredArray() {
        // sort
        /*
        // user 1 and user 2 are not the references from the array but a comparison of two users
//        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
//            // Sorts by highest points to lower
//            return user1.point > user2.point
//        }
        
        // A shorthand way to write the above is:
        filteredArray = dataArray.sorted(by: { $0.point > $1.point })
        */
        
        // filter
        /*
        filteredArray = dataArray.filter({ (user) -> Bool in
            return !user.isVerified
           // return user.name.contains("i")
        })
        
        filteredArray = dataArray.filter({$0.isVerified})
         */
        
        // map
        /*
        mappedArray = dataArray.map({ (user) -> String in
            return user.name
        })
        mappedArray = dataArray.map({ $0.name })
        mappedArray = dataArray.compactMap({ (user) -> String? in
            // With compact map the below will only return a user when they have their name field inputted.
            return user.name
        })
        
        mappedArray = dataArray.compactMap({ $0.name })
        */
        
        // Sort by most points:
        let sort = dataArray.sorted(by: { $0.point > $1.point})
        // Only include those who are verified:
        let filter = dataArray.filter({ $0.isVerified })
        // just show the name on the screen:
        let map = dataArray.compactMap({ $0.name })
        
        mappedArray = dataArray
            .sorted(by: { $0.point > $1.point})
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
        
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Josh", point: 12, isVerified: true)
        let user2 = UserModel(name: nil, point: 66, isVerified: false)
        let user3 = UserModel(name: "James", point: 5, isVerified: true)
        let user4 = UserModel(name: "Samuel", point: 54, isVerified: false)
        let user5 = UserModel(name: "Richard", point: 33, isVerified: false)
        let user6 = UserModel(name: "Jamie", point: 98, isVerified: true)
        let user7 = UserModel(name: "Jess", point: 9, isVerified: false)
        let user8 = UserModel(name: nil, point: 7, isVerified: true)
        let user9 = UserModel(name: "Jesus", point: 100, isVerified: true)
        let user10 = UserModel(name: "Jeramiah", point: 1, isVerified: true)
        
        self.dataArray.append(contentsOf: [
        user1,
        user2,
        user3,
        user4,
        user5,
        user6,
        user7,
        user8,
        user9,
        user10,
        ])
    }
    
    
}


// View

struct ArraysLearning: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // Filtered displayed user data:
                /*
                ForEach(vm.filteredArray) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                        HStack {
                            Text("Points: \(user.point)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.cornerRadius(10))
                    .padding(.horizontal)
                 
                }*/
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
            }
        }
    }
}

struct ArraysLearning_Previews: PreviewProvider {
    static var previews: some View {
        ArraysLearning()
    }
}
