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
        var sourceUrl: URL;
        
        #if DEBUG
            sourceUrl = URL(string:"http://localhost:8081/index.bundle?platform=ios")!
        #else
            sourceUrl = Bundle.main.url(forResource: "main", withExtension: "jsbundle")!;
        #endif
        
        return RCTRootView(bundleURL: sourceUrl, moduleName: "HelloTest", initialProperties: nil, launchOptions: nil)
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
