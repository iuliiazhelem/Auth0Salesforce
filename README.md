# Auth0Salesforce

This sample exposes how to integrate Salesforce Authentication with Auth0.

For this you need to add the following to your `Podfile`:
```
pod 'Lock', '~> 1.24'
pod 'SimpleKeychain'
```
Please make sure you configure a [Salesforce connection in Auth0](https://auth0.com/docs/connections/social/salesforce)

Salesforce servers use TLS 1.2 but do not yet support forward secrecy. That's why apps need to disable the forward secrecy requirement. For more details please review [this link](https://rwhitleysfdc.wordpress.com/2015/09/29/tips-for-upgrading-mobile-sdk-apps-for-ios-9/)

```
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSExceptionDomains</key>
	<dict>
		<key>salesforce.com</key>
		<dict>
			<key>NSIncludesSubdomains</key>
			<true/>
			<key>NSExceptionRequiresForwardSecrecy</key>
			<false/>
		</dict>
		<key>force.com</key>
		<dict>
			<key>NSIncludesSubdomains</key>
			<true/>
			<key>NSExceptionRequiresForwardSecrecy</key>
			<false/>
		</dict>
	</dict>
</dict>
```
## Important Snippets

### Step 1: Register the authenticator 
```swift
let lock = A0Lock.sharedLock()
let salesforce = A0WebViewAuthenticator(connectionName: "salesforce", lock: lock)
lock.registerAuthenticators([salesforce])
```

### Step 2: Authenticate with a Connection name 
```swift
let success = { (profile: A0UserProfile, token: A0Token) in
print("User: \(profile)")
}
let failure = { (error: NSError) in
print("Oops something went wrong: \(error)")
}
let lock = A0Lock.sharedLock()
lock.identityProviderAuthenticator().authenticateWithConnectionName("salesforce", parameters: nil, success: success, failure: failure)
```

Before using the example, please make sure that you change some keys in the `Info.plist` file with your data:

##### Auth0 data from [Auth0 Dashboard](https://manage.auth0.com/#/applications):

- Auth0ClientId
- Auth0Domain
- CFBundleURLSchemes

```
<key>CFBundleTypeRole</key>
<string>None</string>
<key>CFBundleURLName</key>
<string>auth0</string>
<key>CFBundleURLSchemes</key>
<array>
<string>a0{CLIENT_ID}</string>
</array>
```

##### For iOS 9 support you need to configure the App Transport Security Exceptions for Salesforce domains
```
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSExceptionDomains</key>
	<dict>
		<key>salesforce.com</key>
		<dict>
			<key>NSIncludesSubdomains</key>
			<true/>
			<key>NSExceptionRequiresForwardSecrecy</key>
			<false/>
		</dict>
		<key>force.com</key>
		<dict>
			<key>NSIncludesSubdomains</key>
			<true/>
			<key>NSExceptionRequiresForwardSecrecy</key>
			<false/>
		</dict>
	</dict>
</dict>
```
