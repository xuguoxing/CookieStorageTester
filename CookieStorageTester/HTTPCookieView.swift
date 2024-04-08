//
//  HTTPCookieView.swift
//  CookieStorageTester
//
//  Created by guoxingxu on 2024/4/7.
//

import SwiftUI

struct HTTPCookieView: View {
    
    let cookie:HTTPCookie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0, content: {
            Text(cookie.hostInfo)
            Text(cookie.metadataInfo)
            Text(cookie.lifespanInfo)
            Text(cookie.securityInfo)
        })
    }
}

#Preview {
    HTTPCookieView(cookie: HTTPCookie.init())
}
