//
//  EscapingBootcamp.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 09/03/2023.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "hello there"
    
    func getData() {
        downloadDataFive { [weak self] (returnedResult) in
            self?.text = returnedResult.data
        }
    }
    
    // The below -> returning a string is synchronous code. It wants to do everything step by step.
    func downloadData() -> String {
        return "New Data!"
    }
    
    // Could be completion or handler. Completion handler is just what we're using
    // in the completion handler we cannot use a specific name for readability so we use _
    
    // -> Void could also be -> ()
    func downloadDataTwo(completionHandler: (_ data: String) -> Void) {
        completionHandler("New data!")
    }
    
    // The @escaping makes our code asynchronous
    func downloadDataThree(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New Data")
        }
    }
    
    // How do we make the above function more readable.
    func downloadDataFour(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data !!!!")
            completionHandler(result)
        }
    }
    
    // How do we make the above even more readable
    func downloadDataFive(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data !!!!")
            completionHandler(result)
        }
    }
    
    func doSomething(forData data: String) {
        print(data)
    }
}

// The below is the same as saying -> Void)
typealias DownloadCompletion = (DownloadResult) -> ()

struct DownloadResult {
    let data: String
}

struct EscapingLearning: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingLearning_Previews: PreviewProvider {
    static var previews: some View {
        EscapingLearning()
    }
}
