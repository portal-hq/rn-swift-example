//
//  ContentView.swift
//  TestReactNativeIntegration
//
//  Created by Elijah Windsor on 8/1/22.
//

import SwiftUI
import UIKit
import React

struct RctView: UIViewRepresentable {
    func makeUIView(context: Context) -> RCTRootView {
        RCTRootView(bundleURL: URL(string: "http://localhost:8081/index.bundle?platform=ios")!, moduleName: "HelloTest", initialProperties: nil, launchOptions: nil)
    }
    
    func updateUIView(_ view: RCTRootView, context: Context) {
        
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hey there, I am from Swift")
        RctView()
    }
    
}
