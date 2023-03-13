//
//  BackgroundThreadLearning.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 09/03/2023.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
 
    func fetchData() {
        
        // We download the data on the background thread:
        DispatchQueue.global(qos: .background).async {
            // Right now we are creating a strong reference by using self. soon we will incorporate weak self in order to handle this better.
            let newData = self.downloadData()
            
            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 1: \(Thread.current)")
            
            
            // When we are ready we go back to the main thread.
            DispatchQueue.main.async {
                // We put the below in to this main thread because it is to do with the UI and has to be so.
                self.dataArray = newData
                print("CHECK 2: \(Thread.isMainThread)")
                print("CHECK 2: \(Thread.current)")
            }
        }
        
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
    
}

struct BackgroundThreadLearning: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            
        }
    }
}

struct BackgroundThreadLearning_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadLearning()
    }
}
