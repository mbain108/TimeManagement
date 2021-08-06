//
//  Constants.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import UIKit

enum RecordType {
    static let location = "raeLocation"
    static let moon     = "raeMoon"
    static let profile  = "raeProfile"
}

enum PlaceholderImage {
    static let avatar = UIImage(named: "default-avatar")!
    static let square = UIImage(named: "default-square-asset")!
    static let banner = UIImage(named: "default-banner-asset")!
}

enum ImageDimension {
    case square, banner
    
    static func getPlaceholder(for dimension: ImageDimension) -> UIImage {
        switch dimension {
            case .square:
                return PlaceholderImage.square
            case .banner:
                return PlaceholderImage.banner
        }
    }
}
