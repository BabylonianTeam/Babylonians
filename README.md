# Babylonians
A great app we are making for CS506

# Tutorial
Open the workspace file ```Babylonian.xcworkspace``` with the newest version of XCode. Then you should be able to build it. If it builds successfully but doesn't launch the app, make sure you select "Babylonian" next to the "Stop" button, instead of "Bolts".

![alt tag](https://github.com/BabylonianTeam/Babylonians/blob/master/Screen%20Shot%202016-04-18%20at%2011.18.14%20PM.png?raw=true)

In case of any error. Go to the terminal and run ```pod install``` under the root folder of the project. If you don't have pod, then run ```gem install cocoapods``. This is very likely needed for OS X El Capitan.

The app runs as the creator side by default. Change 
```c
#define		RUNTIME_USER_ROLE                   @"creator"
```
into 
```c
#define		RUNTIME_USER_ROLE                   @"learner"
```
to run the learner side.
This will only impact the user role when you create a new user. If you login with existing account, it will load the right side according to the user rolf of that account.

We provide the following two testing account for convenience:
```
learner test account: learner@wandonye.com, password: tester
creator test account: creator@wandonye.com, password: tester
```

##Dependency:
###For image management
https://github.com/rs/SDWebImage

###For popup window(Alert/Error/Success)
https://github.com/relatedcode/ProgressHUD

###For reordering table
https://github.com/nicolasgomollon/LPRTableView

###For tag list
https://github.com/xhacker/TagListView

##Reference Projects:
https://github.com/relatedcode/EncryptedChat

https://github.com/jessesquires/JSQMessagesViewController
