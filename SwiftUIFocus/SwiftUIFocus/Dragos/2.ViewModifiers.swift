//
//  ViewModifiers.swift
//  SwiftUIFocus
//
//  Created by Dragos on 16.04.2025.
//

// random foreground
// magic appear (scale, opacity) + delay, duration
// reveal on tap

import SwiftUI

struct RandomForegroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.random)
    }
}

struct RevealOnTapModifier: ViewModifier {

    @State var isVisible = false

    func body(content: Content) -> some View {
        content
            .overlay {
                Color.clear
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 8))
                    .onTapGesture {
                        withAnimation {
                            isVisible = true
                        }
                    }
                    .opacity(isVisible ? 0 : 1)
            }
    }
}

struct MagicAppearModifier: ViewModifier {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    var delay: Double
    var duration: Double

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: duration).delay(delay)) {
                    scale = 1.0
                    opacity = 1.0
                }
            }
    }
}

#Preview {
    Text("some content")
        .modifier(MagicAppearModifier(delay: 1, duration: 3))
}
