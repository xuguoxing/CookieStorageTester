//
//  ContentView.swift
//  CookieStorageTester
//
//  Created by guoxingxu on 2024/4/7.
//

import SwiftUI
import WebKit


struct ContentView: View {
    
    @State var requestUrl:String = "https://rbzr7d4hhwzqw65i33doeiekcm0dorkr.lambda-url.ap-northeast-1.on.aws/setcookie"
    @State var requestContent:String = ""
    @State var webViewUrl:String = "https://rbzr7d4hhwzqw65i33doeiekcm0dorkr.lambda-url.ap-northeast-1.on.aws/setcookie"
    @StateObject var webViewStore = WebViewStore()
    

    @State var cookieStorageType:CookieStorageType = .HTTPCookieStorage
    @State var httpCookies = [HTTPCookie]()
    @State var wkCookies = [HTTPCookie]()
    
    
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 5.0, content: {
                TextField("URL", text: $requestUrl)
                    .textFieldStyle(.roundedBorder)
                Button("App Request") {
                    requestURL()
                }
            })
            TextEditor(text: .constant(requestContent))
                .foregroundColor(.primary)
                .font(.system(size: 14.0))
                .frame(height:100)
                .cornerRadius(10)
                
                
            
            
            HStack(alignment: .center, spacing: 5.0, content: {
                TextField("URL", text: $webViewUrl)
                    .textFieldStyle(.roundedBorder)
                Button("WKWebView") {
                    requestWKWebView()
                }
            })
            WebView(webView: webViewStore.webView)
                .frame(height:100)
            
            Picker("Cookie", selection: $cookieStorageType) {
                ForEach(CookieStorageType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            
            if cookieStorageType == .HTTPCookieStorage {
                HTTPCookieListView(cookies: httpCookies)
                    .onAppear(perform: {
                        httpCookies = HTTPCookieStorage.shared.cookies ?? [HTTPCookie]()
                    })
            }
            
            if cookieStorageType == .WKHTTPCookieStorage {
                HTTPCookieListView(cookies: wkCookies)
                    .onAppear(perform: {
                        WKWebViewConfiguration.init().websiteDataStore.httpCookieStore.getAllCookies { cookies in
                            wkCookies = cookies
                        }
                    })
            }
        }
        .padding()
    }
    
    func requestURL() {
        
        guard let url = URL(string: requestUrl) else {
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                requestContent = String(data: data, encoding: .utf8) ?? ""
                httpCookies = HTTPCookieStorage.shared.cookies ?? [HTTPCookie]()
            }catch {
                print(error)
            }
        }
    }
    
    func requestWKWebView(){
        if let url = URL(string: webViewUrl) {
            self.webViewStore.webView.load(URLRequest(url: url))
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                WKWebViewConfiguration.init().websiteDataStore.httpCookieStore.getAllCookies { cookies in
                    wkCookies = cookies
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
