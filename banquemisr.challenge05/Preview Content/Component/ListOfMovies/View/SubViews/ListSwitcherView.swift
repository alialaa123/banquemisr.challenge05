//
//  ListSwitcherView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import SwiftUI

struct ListSwitcherView: View {
    // MARK: - Properties
    @Binding var tabs: [String]
    @Binding var selectedTab: String
    
    // MARK: - View
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ZStack(alignment: .center) {
                /// Background Color for animation
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.blue)
                        .frame(
                            width: geometry.size.width / CGFloat(tabs.count),
                            height: geometry.size.height
                        )
                        .clipShape(.capsule)
                        .offset(x: self.offset(for: selectedTab, in: geometry))
                        .animation(.easeInOut, value: selectedTab)
                }
                /// Tabs
                HStack(spacing: 16) {
                    ForEach(tabs, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            Text(tab)
                                .foregroundColor(.white)
                                .fontWeight(selectedTab == tab ? .bold : .regular)
                        }
                        .padding(.leading)
                        Spacer()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .background(Color.black)
        .clipShape(.capsule)
    }
    
    // MARK: - Method for offset animation
    private func offset(for tab: String, in geometry: GeometryProxy) -> CGFloat {
        let index = CGFloat(tabs.firstIndex(of: tab) ?? 0)
        let tabWidth = geometry.size.width / CGFloat(tabs.count)
        return index * tabWidth
    }
}


#Preview {
    ListSwitcherView(tabs: .constant(["Now", "Later"]), selectedTab: .constant("Now"))
}
