//
//  Build+VersionFormatter.swift
//  ProyectoFinal
//
//  Created by admin on 4/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension Bundle {

    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }

    var bundleId: String {
        return bundleIdentifier!
    }

    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }

    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }

}
