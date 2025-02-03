//
//  MovieMinimumInformationView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import SwiftUI
import Domain

struct InformationView: View {
    // MARK: - Properties
    @State var informationToShow: [MovieInformationPresentationModel]
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(
                Array(informationToShow.enumerated()),
                id: \.element.iconImage
            ) { index, information in
                addingInformation(
                    with: MovieInformationPresentationModel(
                        iconImage: information.iconImage,
                        text: information.text
                    )
                )
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Helper function to generate stack of view
    func addingInformation(
        with information: MovieInformationPresentationModel
    ) -> some View {
        return HStack(alignment: .center, spacing: 8) {
            Image(systemName: information.iconImage)
                .foregroundStyle(Color.white)
                .frame(width: 15, height: 15)
            
            Text(information.text)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .lineLimit(1)
                .foregroundStyle(Color.white)
            
            Spacer()
        }
    }
}

#Preview {
    InformationView(informationToShow: [
        MovieInformationPresentationModel(iconImage: "popcorn", text: "Ali"),
        MovieInformationPresentationModel(iconImage: "calendar.badge.clock", text: "03-02-2025")
    ])
}
