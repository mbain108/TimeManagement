//
//  LocationListView.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationListViewModel()
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink(destination: viewModel.createLocationDetailView(for: location, in: sizeCategory)) {
                        LocationCell(location: location, profiles: viewModel.checkedInProfiles[location.id, default: []])
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(Text(viewModel.createVoiceOverSummary(for: location)))
                    }
                }
            }
            .navigationTitle("Grub Spots")
            .onAppear { viewModel.getCheckedInProfilesDictionary() }
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
