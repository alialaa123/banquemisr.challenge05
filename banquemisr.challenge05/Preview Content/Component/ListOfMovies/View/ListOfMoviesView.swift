//
//  ListOfMoviesView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 29/01/2025.
//

import SwiftUI

struct ListOfMoviesView: View {
    // MARK: - State property
    @StateObject var viewModel: ListOfMoviesViewModel
    
    // MARK: - View
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("banquemisr.challenge05")
        }
        .padding()
    }
}

#Preview {
    ListOfMoviesView(viewModel: ListOfMoviesViewModel())
}
