//
//  InternalHeaderView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 01/02/2025.
//

import SwiftUI

enum HeaderButtonIcon: String {
    case back = "chevron.backward.circle.fill"
    case close = "xmark.circle.fill"
}

struct InternalHeaderView: View {
    // MARK: - Properties
    var buttonIcon: HeaderButtonIcon = .back
    @Binding var buttonAction: Bool
    
    // MARK: - View
    var body: some View {
        HStack {
            Button {
                buttonAction = true
            } label: {
                Image(systemName: buttonIcon.rawValue)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .shadow(radius: 12)
            }
            .foregroundStyle(.white)
            .padding(.top, 80)
            .padding(.leading, 26)
            
            Spacer()
        }
    }
}

#Preview {
    InternalHeaderView(buttonAction: .constant(false))
}
