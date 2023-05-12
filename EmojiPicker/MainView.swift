//
//  MainView.swift
//  EmojiPicker
//
//  Created by devdchaudhary on 12/05/23.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedEmoji = ""
    @State var showSheet = false
    
    var body: some View {
        
        VStack {
            
            Text(selectedEmoji)
                .font(.headline)
                .padding(.vertical)
            
            Button {
                showSheet.toggle()
            } label: {
                Text("Select an emoji")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
        .sheet(isPresented: $showSheet) {
            EmojiPickerView(selectedEmoji: $selectedEmoji)
                .presentationDetents([.medium, .large])
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
