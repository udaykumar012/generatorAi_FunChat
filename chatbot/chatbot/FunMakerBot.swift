//
//  FunMakerBot.swift
//  chatbot
//
//  Created by Uday Kumar Kotla on 28/06/23.
//

import SwiftUI

struct FunMakerBot:  View {
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to FunMaker Bot 2.0!"]
    @ObservedObject var viewModel = ChatViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("FunMakerBot")
                    .font(.largeTitle)
                    .bold()
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.blue)
            }
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    // If the message contains [USER], that means it's us
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        
                        // User message styles
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    } else {
                        
                        // Bot message styles
                        HStack {
                            Text(message)
                                .padding()
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                    
                }.rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color.gray.opacity(0.1))
            
            // Contains the Message bar
            HStack {
                TextField("Type something", text: $messageText)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                
                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            
            .padding()
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message)
            self.messageText = ""
            
            viewModel.fetchChat(withID: message)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    if let chat =
                        viewModel.chat{
                        messages.append(chat.response)
                    }
                }
            }
        }
    }
}

struct FunMakerBot_Previews: PreviewProvider {
    static var previews: some View {
        FunMakerBot()
    }
}
