//
//  ChatModel.swift
//  chatbot
//
//  Created by Uday Kumar Kotla on 28/06/23.
//

import Foundation

import Foundation
struct Chat: Codable {
    var message: String
    var response: String
}
class ChatViewModel: ObservableObject {
    @Published var chat: Chat?

    func fetchChat(withID msg:String ) {
        let baseURL = "http://127.0.0.1:5000/get"
        let message = msg
        
        guard let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    return
                }
        let urlString = "\(baseURL)?msg=\(encodedMessage)"
        guard let url = URL(string: urlString) else {
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let chat = try decoder.decode(Chat.self, from: data)
                DispatchQueue.main.async {
                    self.chat = chat
                    print(chat)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
