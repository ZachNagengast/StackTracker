# StackTracker - Objective-C Coding Challenge

![Screenshot](https://i.imgur.com/vtP1fjD.png)

Objectives:
- Connect to [Stackoverflow Users API Endpoint](https://api.stackexchange.com/2.2/users?site=stackoverflow) and retrieve the first page of data. [FULL API documentation](https://api.stackexchange.com/docs)
- Display the retrieved data through a TableView.
- Display at least username, badges and gravatar for every user.
- While the gravatar is being downloaded, the UI should show a loading animation.
- Each of the photos should be downloaded only once and stored for offline usage.
- The UI should always be responsive.

## Libraries Used

Cocoapods:

`pod 'AFNetworking'`
- Trusted networking library for the API GET request

`pod 'SDWebImage'`
- Extends the UIImageView class to retrieve and cache any web images using their url's as keys

`pod 'PureLayout'`
- Convenient shorthand for auto layout when designing interfaces.

## Comments

- Estimated time spent: `4 - 5 hours`
- Built with Xcode-beta
- Took inspiration from Robinhood and the iOS app store.
