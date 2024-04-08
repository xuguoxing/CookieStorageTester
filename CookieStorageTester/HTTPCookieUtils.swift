//
//  HTTPCookieUtils.swift
//  CookieStorageTester
//
//  Created by guoxingxu on 2024/4/7.
//

import Foundation

extension HTTPCookie {
    
    var hostInfo:String {
        var resut = "domain:\(self.domain) path:\(self.path)"
        if let portList = self.portList {
            resut.append(" \(portList)")
        }
        return resut
    }
    
    var metadataInfo:String {
        return "name:\(self.name) value:\(self.value) version:\(self.version)"
    }
    
    var lifespanInfo:String {
        if let date = expiresDate {
            return ("expiresDate:\(date) isSessionOnly:\(self.isSessionOnly)" )
        } else {
            return ("isSessionOnly:\(self.isSessionOnly)" )
        }
    }
    
    var securityInfo:String {
        var result = "isHTTPOnly:\(self.isHTTPOnly) isSecure:\(self.isSecure)"
        if let policy = self.sameSitePolicy {
            result.append(" \(policy)")
        }
        return result
    }
    
}
