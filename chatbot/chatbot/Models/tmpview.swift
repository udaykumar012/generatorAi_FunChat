//
//  tmpview.swift
//  chatbot
//
//  Created by Uday Kumar Kotla on 28/06/23.
//

import SwiftUI

struct tmpview: View {
    @ObservedObject var viewModel = ChatViewModel()
    @State var msgs:[String] = []
    @State var m  = ""
    var body: some View {
        VStack {
            VStack{
                ForEach(msgs,id:\.self){
                    v in
                    Text(v)
                }
            }
            if let chat = viewModel.chat {
                Text(chat.message)
                    .font(.headline)
                Text(chat.response)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Text("Loading...")
            }
            TextField("type txt",text: $m)
                .onSubmit {
                   
                    
                }
        
        }
        
         
    }
}

struct tmpview_Previews: PreviewProvider {
    static var previews: some View {
        tmpview()
    }
}
