//
//  SubscriberLearning.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 13/03/2023.
//

import SwiftUI
import Combine
class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    // Any cancellable is just something we can cancel at any time.
    //var timer: AnyCancellable?
    
    // if we had more than one publisher that needed to be cancelled we would do this:
    var cancellables = Set<AnyCancellable>()
    
    // We can create published variables and subscribe to the data that it publishes.
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
        // Debounce will basically wait until your done typing before running the map code. This is good practice because otherwise the code would be calling with every additional letter typed.
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        // The map functonality in this case can be used to determine if the user has typed enough characters, has ued the correct types of character and so on. No swearing, whatever.
            .map { (text) -> Bool in
                
                if text.count > 3 {
                    return true
                }
                return false
            }
        // There is no way to make self weak with assign use sink
            //.assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
        // we cant use the onReceive call in the view model so we use the .sink
            .sink { [weak self] _ in
                // professional devs would check if self was valid:
                guard let self = self else {return}
                self.count += 1
            }
            .store(in: &cancellables)
    }
 
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else {return}
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
                
            }
            .store(in: &cancellables)
    }
    
}

struct SubscriberLearning: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
           // Text(vm.textIsValid.description)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.blue)
                .font(.headline)
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.headline)
                        .padding(.trailing)
                    , alignment: .trailing
                )
            
            Button(action: {}, label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

struct SubscriberLearning_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberLearning()
    }
}
