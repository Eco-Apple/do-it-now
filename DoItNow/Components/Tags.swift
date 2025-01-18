//
//  Tags.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/17/25.
//

import SwiftUI

struct Tags: View {
    @Binding var text: String
    var tagsLimit: Int
    
    var body: some View {
        TextField("#Workout #Habits #MakeItWork", text: $text)
            .multilineTextAlignment(.trailing)
            .frame(height: 12)
            .padding(.trailing, 18)
            .padding(.top, 15.18)
            .onChange(of: text) { oldValue, newValue in
                guard !(newValue.count == tagsLimit && newValue.last == " ") else {
                    text = oldValue
                    return
                }
                guard newValue != " " else {
                    text = oldValue
                    return
                }
                guard newValue.count <= tagsLimit else {
                    text = oldValue
                    return
                }
                
                if newValue.count >= 2 {
                    let secondToLastIndex = newValue.index(newValue.endIndex, offsetBy: -2)
                    if newValue.last == "#" && newValue[secondToLastIndex] != " " {
                        text = oldValue
                        return
                    }
                    
                    if newValue.last == " " && newValue[secondToLastIndex] == "#" {
                        text = oldValue
                        return
                    }
                    
                    if newValue.last == " " && newValue[secondToLastIndex] == " " {
                        text = String(newValue[..<secondToLastIndex])
                        return
                    }
                    
                    if newValue.last != "#" && newValue[secondToLastIndex] == " " {
                        if let last = newValue.last {
                            text = "\(String(newValue[..<secondToLastIndex])) #\(last.uppercased())"
                            return
                        }
                    }
                    
                    guard newValue.hasPrefix(oldValue) else {
                        let modifiedSentence = newValue.split(separator: " ")
                            .map { word in
                                if word.starts(with: "#") {
                                    // Capitalize the first letter after #
                                    let firstLetter = word.dropFirst().prefix(1).uppercased()
                                    let restOfWord = word.dropFirst(2)
                                    return "#\(firstLetter)\(restOfWord)"
                                } else {
                                    // Prepend # to words without it
                                    return "#\(word)"
                                }
                            }
                            .joined(separator: " ")
                        
                        text = modifiedSentence
                        return
                    }
                    
                    let startIndex = oldValue.endIndex
                    let addedText = String(newValue[startIndex...])
                    
                    if addedText.last == " " {
                        text = oldValue + addedText.replacingOccurrences(of: " ", with: " #")
                    } else {
                        // Split the sentence into words and process each one
                        let modifiedSentence = newValue.split(separator: " ")
                            .map { word in
                                if word.starts(with: "#") {
                                    // Get the first letter after # and capitalize it
                                    let firstLetter = word.dropFirst().prefix(1).uppercased()
                                    // Combine with the rest of the word
                                    let restOfWord = word.dropFirst(2)
                                    return "#\(firstLetter)\(restOfWord)"
                                } else {
                                    return String(word)
                                }
                            }
                            .joined(separator: " ")
                        
                        text = modifiedSentence
                    }
                    
                } else {
                    if newValue != "#" && !newValue.isEmpty {
                        text = "#" + newValue.uppercased()
                    }
                }
            }
    }
}

#Preview {
    Tags(text: .constant(""), tagsLimit: 5)
}
