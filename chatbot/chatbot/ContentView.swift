//
//  ContentView.swift
//  chatbot
//
//  Created by Uday Kumar Kotla on 28/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                FunMakerBot()
                    .tabItem {
                        Image(systemName: "message.and.waveform.fill" )
                        Text("chat")
                    }
                
                FunMakerImageGenerator()
                    .tabItem {
                        Image(systemName: "text.below.photo")
                        Text("Image")
                    }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
