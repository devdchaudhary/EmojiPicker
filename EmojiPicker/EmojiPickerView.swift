//
//  ContentView.swift
//  EmojiPicker
//
//  Created by devdchaudhary on 12/05/23.
//

import SwiftUI

struct EmojiPickerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedEmoji: String
    @State var emojiList: [EmojiModel] = []
    
    @State var isSearched = false
    @State var searchQuery = ""
    
    var reactionSelected: (() -> Void)?
    
    let items: [GridItem] = [
        .init(.flexible(), spacing: 0),
        .init(.flexible(), spacing: 0),
        .init(.flexible(), spacing: 0),
        .init(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                    
                    TextField("", text: $searchQuery)
                        .submitLabel(.search)
                        .onSubmit {
                            withAnimation {
                                searchClicked()
                            }
                        }
                        .onChange(of: searchQuery) { newVal in
                            
                            searchQuery = newVal.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if searchQuery.isEmpty {
                                
                                isSearched = false
                                searchQuery = ""
                                emojiList = []
                                emojiList = getEmojiModel()
                                
                            } else {
                                
                                emojiList = emojiList.filter({ $0.name.contains(searchQuery.uppercased())})
                                
                            }
                        }
                    
                    Spacer()
                    
                    if isSearched {
                        
                        Button {
                            withAnimation {
                                searchCancelled()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .background(Color(uiColor: .systemGray5))
                .cornerRadius(30)
                
                Spacer()
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
            
            Spacer()
            
            ScrollView(.vertical) {
                LazyVGrid(columns: items, spacing: 0) {
                    ForEach(emojiList, id: \.id) { emoji in
                        Button {
                            selectedEmoji = emoji.value
                            reactionSelected?()
                            dismiss()
                        } label: {
                            Text(emoji.value)
                                .font(.system(size: 35))
                                .padding()
                        }
                    }
                }
            }
            .onAppear {
                emojiList = getEmojiModel()
            }
        }
    }
    
    private func searchClicked() {
        
        isSearched = true
        
        if searchQuery == "" {
            searchCancelled()
            return
        }
        
        emojiList = emojiList.filter({ $0.name.contains(searchQuery.uppercased())})
    }
    
    private func searchCancelled() {
        isSearched = false
        searchQuery = ""
        emojiList = []
        emojiList = getEmojiModel()
    }
    
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPickerView(selectedEmoji: .constant(""))
    }
}
