//
//  PathChoicesView.swift
//  borrowers2.0
//
//  Created by Lissa Deguti on 02/08/25.
//

import SwiftUI

struct PathChoicesView: View {
    
    let keepQuietSteps: [DialogueStep] = [
        DialogueStep(speech: "It’s getting late. Try to sleep now, Obaachan. Good night…", speaker: .mina)
    ]
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .edgesIgnoringSafeArea(.all)
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PathChoicesView()
}
