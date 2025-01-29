//
//  CustomToolbarModifier.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/29/25.
//

import SwiftUI

struct CustomToolbarModifier<ToolbarContent: View>: ViewModifier {
    let toolbarContent: () -> ToolbarContent
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0){
            toolbarContent()
            content
        }
    }
}

extension View {
    func customToolbar<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(CustomToolbarModifier(toolbarContent: content))
    }
}
