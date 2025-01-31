//
//  ErrorMessageView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import SwiftUI

struct ErrorMessageView: View {
    let errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Error: \(errorMessage ?? "")")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.white)
                .padding(8)
        }
        .frame(maxWidth: .infinity)
        .background(Color.red.opacity(0.8))
        .cornerRadius(12)
    }
}
