//
//  CoreLayoutContainers.swift
//  SwiftUIFocus
//
//  Created by Dragos on 15.04.2025.
//

// HStack
// VStack
// ZStack
// Spacer, Divider
// List
// Lazy - onAppear pe fiecare element print cu loaded
// AnyLayout - toggle H and V cu animatie
// ViewThatFits -
// @ViewBuilder - folosit in spate, if/else, return
// Custom Layout

import SwiftUI

struct CoreLayoutContainers: View {

    @State private var colorsCount: Double = 3

    var body: some View {
        ZStack {
            content
            Color.clear.frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    Slider(value: $colorsCount, in: 0...20)
                }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .overlay(alignment: .top) {
//        }
        .toolbar {
            ToolbarItem {
                Text(String(Int(colorsCount)))
            }
        }
    }

    private var content: some View {
        VStack {
            colors
        }
    }

    private var colors: some View {
        ForEach(0 ..< Int(colorsCount), id: \.self) { value in
            Color.random
                .overlay {
                    Text(String(value + 1))
                }
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    NavigationStack {
        CoreLayoutContainers()
    }
    .border(.red)
}

extension Color {
    static var random: Color {
        Color(hue: .random(in: 0...1), saturation: 1, brightness: 1)
    }
}

