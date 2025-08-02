//
//  TypingTextView.swift
//  borrowers2.0
//
//  Created by Lissa Deguti on 01/08/25.
//

import SwiftUI
import Foundation

struct TypingTextView: View {
    let finalText: String //texto inteiro
    let font: Font
    var color: Color = Color("DarkBrown") // valor padrão
    var onFinished: (() -> Void)? = nil //pra avisar que acabou
    
    @State private var typedText = ""
    @State private var charIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        Text(typedText)
            .font(font)
            .foregroundStyle(color)
            .onAppear {
                typing()
            }
    }
    
    private func typing() {
        //confere se já não tem um timer (se tiver ele sai da função
        //mesma coisa que:
        
        //if timer != nil {
        //    return
        //}
        guard timer == nil else {return}
        
        //inicia timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { t in
            //confere se tem ainda letras para digitar
            if charIndex < finalText.count {
                
                //forma do xcode:
                //typedText.append(finalText[finalText.index(finalText.startIndex, offsetBy: charIndex)])
                
                //startIndex é do próprio Swift para checar o primeiro ponto válido da leitura da String
                let index = finalText.index(finalText.startIndex, offsetBy: charIndex)
                typedText += String (finalText[index])
                charIndex += 1
                
            } else {
                //para o timer pq acabou
                t.invalidate()
                timer = nil
                onFinished?() //avisa que terminou
            }
        }
        
    }
}
