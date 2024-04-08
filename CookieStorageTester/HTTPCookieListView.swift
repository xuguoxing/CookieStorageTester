//
//  HTTPCookieListView.swift
//  CookieStorageTester
//
//  Created by guoxingxu on 2024/4/7.
//

import SwiftUI

struct HTTPCookieListView: View {
    
    let cookies: [HTTPCookie]
    
    var body: some View {
        List(cookies,id: \.self) { cookie in
            HTTPCookieView(cookie: cookie)
        }
        
    }
}

#Preview {
    HTTPCookieListView(cookies: [HTTPCookie]())
}
