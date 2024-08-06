//
//  CustomStyles.swift
//  DexScreener
//
//  Created by waqas on 06/08/2024.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    var height: CGFloat
    var cornerRadius: CGFloat
    var padding: CGFloat

    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(padding)
            .background(Color.white)
            .cornerRadius(cornerRadius)
            .frame(height: height)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.gray, lineWidth: 1))
    }
}
