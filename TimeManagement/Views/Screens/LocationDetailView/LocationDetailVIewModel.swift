//
//  LocationDetailViewModel.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/31/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import SwiftUI
import MapKit
import CloudKit

enum CheckInStatus { case checkedIn, checkedOut }

final class LocationDetailViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [raeProfile] = []
    @Published var isShowingProfileModal = false
    @Published var isShowingProfileSheet = false
    @Published var isCheckedIn = false
    @Published var isLoading =  false
    @Published var alertItem: AlertItem?
    
    var location: raeLocation
    var selectedProfile: raeProfile?
    
    init(location: raeLocation) { self.location = location }
    
    
    func determineColumns(for sizeCategory: ContentSizeCategory) -> [GridItem] {
        let numberOfColumns = sizeCategory >= .accessibilityMedium ? 1 : 3
        return Array(repeating: GridItem(.flexible()), count: numberOfColumns)
    }
    
    
    func getDirectionsToLocation() {
        let placemark =  MKPlacemark(coordinate: location.location.coordinate)
        let mapItem     = MKMapItem(placemark: placemark)
        mapItem.name    = location.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    
    func callLocation() {
        guard let url = URL(string: "tel://\(location.phoneNumber)") else {
            alertItem = AlertContext.invalidPhoneNumber
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    func getCheckedInStatus() {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    if let reference = record[raeProfile.kIsCheckedIn] as? CKRecord.Reference {
                        isCheckedIn = reference.recordID == location.id
                    } else {
                        isCheckedIn = false
                    }
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckInStatus
                }
            }
        }
    }
    
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
                case .success(let record):
                    switch checkInStatus {
                        case .checkedIn:
                            record[raeProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                            record[raeProfile.kIsCheckedInNilCheck] = 1
                        case .checkedOut:
                            record[raeProfile.kIsCheckedIn] = nil
                        record[raeProfile.kIsCheckedInNilCheck] = nil
                }
                
                CloudKitManager.shared.save(record: record) { result in
                    DispatchQueue.main.async {
                        switch result {
                            case .success(let record):
                                let profile = raeProfile(record: record)
                            
                            switch checkInStatus {
                                case .checkedIn:
                                    checkedInProfiles.append(profile)
                                case .checkedOut:
                                    checkedInProfiles.removeAll(where: {$0.id == profile.id})
                            }
                                
                            isCheckedIn = checkInStatus == .checkedIn
                            
                        case .failure(_):
                            alertItem = AlertContext.unableToCheckInOrOut
                        }
                    }
                }
                case .failure(_):
                    alertItem = AlertContext.unableToCheckInOrOut
            }
        }
    }
    
    
    func getCheckedInProfiles() {
        showLoadingView()
        CloudKitManager.shared.getCheckedInProfiles(for: location.id) { [self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let profiles):
                        checkedInProfiles = profiles
                    case .failure(_):
                        alertItem = AlertContext.unableToCheckedInProfiles
                }
                hideLoadingView()
            }
        }
    }
    
    
    func show(profile: raeProfile, in sizeCategory: ContentSizeCategory) {
        selectedProfile = profile
        if sizeCategory >= .accessibilityMedium {
            isShowingProfileSheet = true
        } else {
            isShowingProfileModal = true
        }
    }
    
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}
