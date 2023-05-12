//
//  Extensions.swift
//  EmojiPicker
//
//  Created by devdchaudhary on 12/05/23.
//

import Foundation

extension Character {
    
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
}
