//
//  LocationManager.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [raeLocation] = []
}
