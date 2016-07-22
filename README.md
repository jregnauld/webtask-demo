# Webtask demo
It's a small project which has for goal to get all information about an User and his iOS device and to notify a Slack channel of who is connected and how many users has the application installed.

What can we find through this project:

- Xcode project using cocoapods
- Javascript using Webtask
- a MongoDB host on mLab
- IFTTT for receiving a HTTP Request and post on Slack channel ( Maker then Slack)

## Installation

Clone the project

Go inside the folder "webtask-demo"

Install project libraries with the following command:

```
pod install

``` 

See this link about Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.


## Javascript

- All javascript scripts are hosted on Webtask.io 

- webtask-demo.js is a script to receive information from iOS devices and store in the database.

- webtask-call-slack.js is a script which call IFTTT for notifying slack and sending users informations in JSON.


