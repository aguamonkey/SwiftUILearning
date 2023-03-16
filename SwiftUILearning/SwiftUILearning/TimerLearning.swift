//
//  TimerLearning.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 13/03/2023.
//

import SwiftUI

struct TimerLearning: View {
    
    // the timer is a publisher
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    // Current Time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
       // formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    // Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
     
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
        
    }
     */
    
    // Animation Counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.purple, Color.blue]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count,
                    content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
            // Cool loading animation:
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundColor(.white)
            
           // Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ?? "\(count)")
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
        }
        // Value is whatever we are publishing.
        // the below will print out and update the current time.
//        .onReceive(timer, perform: { value in
//            currentDate = value
//        })
//        .onReceive(timer, perform: { _ in
//            if count <= 1 {
//              finishedText = "Wow!"
//            } else {
//                count -= 1
//            }
//        })
//        .onReceive(timer, perform: { _ in
//            updateTimeRemaining()
//        })
        
        // Loading CIRCLES ANIMATION:
//        .onReceive(timer, perform: { _ in
//            withAnimation(.easeInOut(duration: 0.5)) {
//                count = count == 3 ? 0 : count + 1
//
//            }
//        })
        .onReceive(timer, perform: { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
            
        })
        
  // The above is the exact same code as the below but clearly more organised and concise.
//            if count == 3 {
//                count = 0
//            } else {
//                count += 1
//            }
//        })
    }
}

struct TimerLearning_Previews: PreviewProvider {
    static var previews: some View {
        TimerLearning()
    }
}
