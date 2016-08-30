# Auth0Salesforce

This sample exposes how to integrate Salesforce authentication with Auth0.

For this you need to add the following to your `Podfile`:
```
  pod 'Lock', '~> 1.24'
  pod 'SimpleKeychain'
```
Please make sure they you configure [Salesforce connection](https://auth0.com/docs/connections/social/salesforce)

## Important Snippets

### Step 1: Register authenticator 
```swift
  let lock = A0Lock.sharedLock()
  let salesforce = A0WebViewAuthenticator(connectionName: "salesforce", lock: lock)
  lock.registerAuthenticators([salesforce])
```

### Step 2: Authenticate with Connection name 
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

Before using the example please make sure that you change some keys in `Info.plist` with your data:

##### Auth0 data from [Auth0 Dashboard](https://manage.auth0.com/#/applications)
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

##### For iOS 9 support you need to configuring App Transport Security Exceptions for Salesforce domains
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
