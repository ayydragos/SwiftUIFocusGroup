//
//  DiagonalLayout.swift
//  SwiftUIFocus2
//
//  Created by Dragos on 16.04.2025.
//

import SwiftUI

struct DiagonalLayout: Layout {
    var spacing: CGFloat = 20

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // Total size is based on the furthest subview
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0

        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            maxX = max(maxX, CGFloat(index) * spacing + size.width)
            maxY = max(maxY, CGFloat(index) * spacing + size.height)
        }

        return CGSize(width: maxX, height: maxY)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            let x = CGFloat(index) * spacing
            let y = CGFloat(index) * spacing
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(width: size.width, height: size.height))
        }
    }
}
