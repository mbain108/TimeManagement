//
//  LocationListViewModel.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 9/3/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import CloudKit

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: [raeProfile]] = [:]
    
    
    func getCheckedInProfilesDictionary() {
        CloudKitManager.shared.getCheckedInProfilesDictionary { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let checkedInProfiles):
                        self.checkedInProfiles = checkedInProfiles
                    case .failure(_):
                        print("Error getting back dictionary")
                }
            }
        }
    }
}
