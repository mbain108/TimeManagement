//
//  ActivityForTheDayView.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import SwiftUI
import MapKit

struct ActivityForTheDayView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = ActivityForTheDayViewModel()
    
    var body: some View {
        ZStack {
//            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
//                MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
//            }
            //.accentColor(.grubRed)
            //.ignoresSafeArea()
            
            VStack {
                LogoView(frameWidth: 125)
                    .shadow(radius: 10)
                Spacer()
                Text("a mindful time management tool for")
                Text("Agile Coach")
                Image("success-work-2")
                    .resizable()
                    .scaledToFit()
                Text("great day to for...")
                Text("better to avoid...")
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView, onDismiss: viewModel.checkIfLocationServicesIsEnabled) {
            OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .onAppear {
            viewModel.runStartupChecks()
            
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
    }
}

struct ActivityForTheDayView_Preview: PreviewProvider {
    static var previews: some View {
        ActivityForTheDayView()
    }
}
