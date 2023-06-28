//
//  HeaderView.swift
//  chatbot
//
//  Created by Uday Kumar Kotla on 28/06/23.
//

import SwiftUI

struct HeaderView: View {
    @State  var Name:String
    @State var logo:String
    var body: some View {
        HStack {
            Text(Name)
                .font(.largeTitle)
                .bold()
            
            Image(systemName: logo)
                .font(.system(size: 26))
                .foregroundColor(Color.blue)
        }
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(Name: "Bot", logo: "message.fill")
    }
}
