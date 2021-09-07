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
            VStack {
                HeaderBackgroundView()
                
                HStack {
                    ZStack {
                        DateBackgroundView()
                        VStack {
                            Text("Friday")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.top, 70)
                            Text("Aug 27th")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading)
                    }
                    
                    ZStack {
                        UsageBackgroundView()
                        VStack(alignment: .leading) {
                            Text("Use this day for:")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("- Nuturing\n- Self Care\n- Building good relatiosnhsips\n- Spiritual in tune")
                        }
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Strong Support For:")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Constructive, nuturing activities, slow exercise, watch sports, meditate, play music")
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Medium Support For:")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Exercise (vigorous), construction, buying & selling, do we need more text?")
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Weak Support For:")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Stressful relationships, demolition, providing criticism")
                        }
                        .padding()
                    }
                }
            }
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .onAppear {
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

struct HeaderBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 110)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct DateBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 160)
            .cornerRadius(12)
            .padding(.leading)
    }
}

struct UsageBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 160)
            .cornerRadius(12)
            .padding(.trailing)
    }
}
