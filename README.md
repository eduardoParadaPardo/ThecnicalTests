# README.MD
This technical test has been done with Xcode 13.4 and Swift 5.

## Content
For this solution, it has been created in 3 folders. 
1) The first one where you can find the UML diagrams of the 2 use cases described. And I have created a diagram defining the philosophy used to perform the behavioral tests.
2) In the second folder where all the source code is hosted.
3) In the last folder, you will find the exported file of the postman where the tests with the services have been performed.

## Requirements
1) The application has been developed based on the VIPER design pattern. Other additional patterns such as Builder and Singleton have been used.
2) No third party libraries have been used for the development of the application, as they may compromise the application if any of them fail to perform constant maintenance. If a third party library is required, a Decorator type design pattern would be used to protect the application in case it is discontinued or you want to change it for another sdk.
    2 SDKs are used for the test part, Quick & Nimble to help simplify the test management.
3) For this test we have created behavioral tests and unit tests, no interface tests.
4) Added swiftLint to maintain best practices throughout the code.
5) A multi-environment system has been added as an extra, with the ability to install 2 versions (quality and production) on the same device. In this way, the solution allows to compile versions depending on the environment and facilitates the integration with a continuous integration system for testing/compilation/analysis of a specific environment.
6) As a second extra, Coredata has been added to perform the download of all the characters only once and improve the application startup speed.
7) As third extra, an image caching system has been added to reduce the loading time of these.
8) Finally we have made a development based on reutulization of views and models using abstract elements.

## Restrictions
1) In order to reach the largest number of users, the use of swiftUI has been discarded as it requires a minimum version of iOS 13. (Currently the adoption rate according to some sources is 72% of users with iOS 13 or higher). The app uses iOS 12, but since it doesn't handle any special functions it could be downgraded to get a higher adoption rate.

## Demo
The project does not require any installation, as it has been made using apple's dependency management system (Swift package manager).
The project has the possibility to use 2 environments, managed through the schema system.
It has only been configured so that the tests can be launched from the integration environment.
