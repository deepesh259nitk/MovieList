# Movie List : iOS Integration with themoviedb

This project contains simple iOS integration of themoviedb API with swift 4.0

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

OS : macOS Sierra : 10.12.6
Xcode : 9.0.1
Swfit : 4.0


### Installing

Clone the repo and 
Double click on the ProductList.xcworkspace and open with Xcode 9.0.1 only using Swift 4.0
Install SwiftLint using brew or comment the script for siwftlint in the build scripts

## Running the tests

Use standard Apple Xcode XC test framework to run the test 
Use Command + U to run the rest 
The unit test are writing inside ProductListTests.swift

### Libraries 

SDWebImage is used for caching product images

### Unit Test Details

testMovieListLoaded
1. Will test if the data loaded inside the MovieService.json is not nil.

testParseData
1. Will test all the parsing features of the code. 
2. Will test if the movieListCache / Movie  Data model contains the expected data.

### And coding style tests

1. use camel case for variable names 
2. use swifty way of function declaration 
3. all constants should be capitalised 
4. all optional should be safely unwrapped using if lets to avoid crashes.
5. 3 Tier MVP Architecture :
1. API Services : responsible for API calls and parsing of json / raw data from open IMDB  API services.
2. Data Manager : responsible for data manuputaion methods and loading stubbed data if required.
3. Data Model : responsible for storing Movie  data model.
4. view :- responsbile for presentation of views
5. view controller :- responsible for binding views and data models together.

## Best Practices

1. Don’t have bad variable names , use meaningful names.
2. Don’t have long viewDidload methods , separate them into different methods ( you can use extract method in Xcode 9 )
3. Use proper Access Specifiers for function and classes
4. Delete all the print statements
5. Use global string variables for cell identifiers etc
6. Incorrect Naming conventions like capital for Class and Struct names
7. All variable names should be camel case
8. Use proper types for variables like age should be int, currency should be big int all in pennies. which will help for calculation and help in meaningful values
9. Use SwiftLint for clean code / conventions and spacing.

NSNotification is used for updated data models / views once API services returns back successful data.  
Singleton Objects for caching data 

## Deployment

Run using Xcode iOS simulators on iPhones and IPad's.

## Built With
Xcode 9.0.1

## Versioning
2.0

## Authors

djrecker

