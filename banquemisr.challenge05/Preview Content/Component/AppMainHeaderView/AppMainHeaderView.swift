//
//  AppMainHeaderView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import SwiftUI

struct AppMainHeaderView: View {
    // MARK: - Properties
    @State var headerTitle: String
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .center) {
            Text(headerTitle)
                .font(.system(size: 18, weight: .bold, design: .default))
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.7))
                    .clipShape(Circle())
                Image(systemName: "person.fill")
                    .imageScale(.large)
                    .foregroundStyle(.black)
                
            }
            .frame(width: 40, height: 40)
        }
    }
}
#Preview {
    AppMainHeaderView(headerTitle: "Banque Misr")
}
