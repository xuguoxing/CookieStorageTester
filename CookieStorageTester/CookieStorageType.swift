//
//  CookieStorageType.swift
//  CookieStorageTester
//
//  Created by guoxingxu on 2024/4/8.
//

import Foundation

enum CookieStorageType: String,Identifiable, CaseIterable, Hashable {
    case HTTPCookieStorage
    case WKHTTPCookieStorage
    
    public var id:String{
        return self.rawValue
    }
}
