//
//  SwiftUILearningApp.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 09/03/2023.
//

import SwiftUI

@main
struct SwiftUILearningApp: App {
    var body: some Scene {
        WindowGroup {
            // For some reason the memory is beginning at 70mb even with a basic text display for the app. So 70 is our baseline.
            //BackgroundThreadLearning()
            //WeakSelfLearning()
            //CodableLearning()
            //DownloadWithEscapingLearning()
            //DownloadWithCombine()
            //MagnificationGestureLearning()
            //RotatingGestureLearning()
            DragGestureLearning()
        }
    }
}
