//
//  DialogueStep.swift
//  borrowers2.0
//
//  Created by Lissa Deguti on 01/08/25.
//

import SwiftUI
import Foundation

struct DialogueStep: Identifiable {
    
    let id = UUID()
    var speech: String? = nil
    var narration: String? = nil
    var circles: String? =  nil
    var speaker: Speaker? = nil
    var choices: String? = nil
    
}
