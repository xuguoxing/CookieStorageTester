# Cookies in iOS -  HTTPCookieStorage and WKHTTPCookieStore

There are two kinds of cookie storages in iOS app: [HTTPCookieStorage](https://developer.apple.com/documentation/foundation/httpcookiestorage) and [WKHTTPCookieStore](https://developer.apple.com/documentation/webkit/wkhttpcookiestore).

## HTTPCookieStorage

HTTPCookieStorage is used by apps, app extensions and UIWebViews. 

By default, apps and associated app extensions will have different data containers. As a result, the value of the HTTPCookieStorage class’s [shared](https://developer.apple.com/documentation/foundation/httpcookiestorage/1416095-shared) property will refer to different persistent cookie stores when called by the app and by its extensions.

You can use the HTTPCookieStorage class’s [sharedCookieStorage(forGroupContainerIdentifier:)](https://developer.apple.com/documentation/foundation/httpcookiestorage/1411361-sharedcookiestorage) method to create a persistent cookie storage available to all apps and extensions with access to the same app group.

UIWebView instances within an app inherit the parent app's shared cookie storage.


## WKHTTPCookieStore

WKHTTPCookieStore is used by WKWebView.

You don’t create a WKHTTPCookieStore object directly. Instead, retrieve this object from the [WKWebsiteDataStore](https://developer.apple.com/documentation/webkit/wkwebsitedatastore) object in your web view’s configuration object.

```swift
var httpCookeStore = self.webView.configuration.websiteDataStore.httpCookieStore
```

### WKWebsiteDataStore

You create a [WKWebViewConfiguration](https://developer.apple.com/documentation/webkit/wkwebviewconfiguration) object in your code, configure its properties, and pass it to the initializer of your WKWebView object. The web view incorporates your configuration settings only at creation time; you cannot change those settings dynamically later.

By default, a WKWebViewConfiguration object uses the default data store returned by the [default()](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532937-default) method of WKWebsiteDataStore class, which saves website data persistently to disk.

You can also create a data store object and assign it to the [websiteDataStore](https://developer.apple.com/documentation/webkit/wkwebviewconfiguration/1395661-websitedatastore) property of a WKWebViewConfiguration object before you create your web view.

For example: 
* To create a private web-browsing session, create a nonpersistent data store using the [nonPersistent()](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532934-nonpersistent) method and assign it to the websiteDataStore property. 
* To implement profile browsing, create a persistent data store using the [init(forIdentifier:)](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/4183560-init) method, passing an identifier that you use to identify the data store.


### Managing WKHTTPCookieStore

You can use a WKHTTPCookieStore to specify the initial cookies for your webpages, and to manage cookies for your web content. For example, you might use this object to delete the cookie for the current session when the user logs out. To detect when the webpage changes a cookie, install a cookie observer using the [add(_:\)](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882010-add) method.

## Cookies Sync Between HTTPCookieStorage and WKWebsiteDataStore

After testing on real devices, we found out iOS automatically sync cookies between HTTPCookieStorage and WKWebsiteDataStore, but with some delay of about seconds.

If your app's code relies on the cookies from WKWebView or your WKWebview relies on the cookies from the app, you may need to do your own sync logic, as the delay of iOS automatically sync will cause a lot of issues. 

You can use this project to test the sync delay between HTTPCookieStorage and WKWebsiteDataStore, feel free to reach out to me if has any questions.