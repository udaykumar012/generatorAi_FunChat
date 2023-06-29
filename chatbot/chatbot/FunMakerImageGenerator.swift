//
//  FunMakerImageGenerator.swift
//  chatbot
//
//  Created by Uday Kumar Kotla on 28/06/23.
//

import SwiftUI

struct FunMakerImageGenerator:View{
    @State private var generatedImage: UIImage?
    @State var input : String = ""
    @State var isSubmit : Bool = false
    @State var imageName:String=""
    var body: some View {
        VStack {
            HeaderView(Name:"FunImageGenerator",logo:"text.below.photo")
            Spacer()
            List{
                if(isSubmit){
                    Text("Keep Going!!")
                }
                Section {
                    if let image = generatedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(imageName).bold().font(.title2)
                            .foregroundColor(.blue)
                    }else if(isSubmit == false){
                        Text("Try our image generator")
                            .bold().font(.largeTitle)
                    }
                    else {
                        Text("Loading Image... Please wait...").bold().font(.largeTitle)
                    }
                }
                   
                

               
            }
            Spacer()
            HStack {
                TextField("Type something", text: $input)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                   
                
                Button {
                    generatedImage = nil
                    generateImage(img: input)
                    imageName = input
                    isSubmit = true
                } label: {
                    Image(systemName: "paperplane.fill")
                }.disabled(input=="")
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            
            .padding()
        }
        
        
    }

    func generateImage(img:String) {
        let data = ["inputs": img]

        guard let url = URL(string: "https://api-inference.huggingface.co/models/prompthero/openjourney") else {
            return
        }
        //auth token from hugging face
        let authToken = "Bear***er hf_abc********"
        print("your auth token : \(authToken) verify it!!!")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    generatedImage = image
                }
            }
        }.resume()
    }}

struct FunMakerImageGenerator_Previews: PreviewProvider {
    static var previews: some View {
        FunMakerImageGenerator()
    }
}

