//
//  ProfileViewModel.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import CloudKit

enum ProfileContext { case create, update }

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName            = ""
    @Published var lastName             = ""
    @Published var companyName          = ""
    @Published var bio                  = ""
    @Published var avatar               = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var isLoading            = false
    @Published var alertItem: AlertItem?
    
    private var existingProfileRecord: CKRecord? {
        didSet { profileContext = .update }
    }
    var profileContext: ProfileContext = .create
    
    func isValidProfile() -> Bool {
        
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        let profileRecord = createProfileRecord()
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        
        showLoadingView()
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                
                switch result {
                    case .success(let records):
                    for record in records where record.recordType == RecordType.profile {
                        existingProfileRecord = record
                    }
                    
                        alertItem = AlertContext.createProfileSuccess
                    case .failure(_):
                        alertItem = AlertContext.createProfileFailure
                        break
                }
            }
        }
    }
    
    func getProfile() {
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
        
        let profileRecordID = profileReference.recordID
        
        showLoadingView()
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                    case .success(let record):
                        existingProfileRecord = record
                    
                        let profile = raeProfile(record: record)
                        firstName   = profile.firstName
                        lastName    = profile.lastName
                        companyName = profile.companyName
                        bio         = profile.bio
                        avatar      = profile.createAvatarImage()
                        
                    case .failure(_):
                        alertItem = AlertContext.unableToGetProfile
                        break
                }
            }
        }
    }
    
    func updateProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        guard let profileRecord = existingProfileRecord else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        
        profileRecord[raeProfile.kFirstName]    = firstName
        profileRecord[raeProfile.kLastName]     = lastName
        profileRecord[raeProfile.kCompanyName]  = companyName
        profileRecord[raeProfile.kBio]          = bio
        profileRecord[raeProfile.kAvatar]       = avatar.convertToCKAsset()
        
        showLoadingView()
        
        CloudKitManager.shared.save(record: profileRecord) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                
                switch result {
                    case .success(_):
                        alertItem = AlertContext.updateProfileSuccess
                    case .failure(_):
                        alertItem = AlertContext.updateProfileFailure
                }
            }
        }
    }
    
    private func createProfileRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[raeProfile.kFirstName]    = firstName
        profileRecord[raeProfile.kLastName]     = lastName
        profileRecord[raeProfile.kCompanyName]  = companyName
        profileRecord[raeProfile.kBio]          = bio
        profileRecord[raeProfile.kAvatar]       = avatar.convertToCKAsset()
        
        return profileRecord
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}
