//
//  ProfileSheetView.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 9/7/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import SwiftUI

// Alternative Profile Modal View for larger dynamic type sizes
// We present this as a sheet instead of a small pop up

struct ProfileSheetView: View {
    
    var profile: raeProfile
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(uiImage: profile.createAvatarImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                    .accessibilityHidden(true)
                
                Text(profile.firstName + " " + profile.lastName)
                    .bold()
                    .font(.title2)
                    .minimumScaleFactor(0.90)
                
                Text(profile.companyName)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.90)
                    .foregroundColor(.secondary)
                    .accessibilityLabel(Text("Works at \(profile.companyName)"))
                
                Text(profile.bio)
                    .accessibilityLabel(Text("Bio, \(profile.bio)"))
            }
            .padding()
        }
    }
}

struct ProfileSheetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileSheetView(profile: raeProfile(record: MockData.profile))
                .environment(\.sizeCategory, .accessibilityExtraLarge)
        }
    }
}
