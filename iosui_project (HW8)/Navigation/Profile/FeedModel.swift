//
//  FeedModel.swift
//  Navigation
//
//  Created by Сергей Минеев on 8/15/24.
//

import Foundation

class FeedModel {
    private let secretWord: String

    init(secretWord: String) {
        self.secretWord = secretWord
    }

    func check(word: String) -> Bool {
        return word.lowercased() == secretWord.lowercased()
    }
}
