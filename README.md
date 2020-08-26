# News Quiz

`News Quiz` is a news quiz app which shows users photos with 3 options to match with. 

## Assumptions. 
The app neither saves the questions locally nor the score. On each start, it fetches the data from the backend and the game starts from beginning. 

Later, we can change the app to keep track of the questions that the user has already answered, and persist that information through app launches.

## Overview

The app architecture is feature based MVVM and protocol based programming. Both MVVM and protocol based approach makes it easy to decouple view from core business logic, hence promoting testability. 

## App Flow
`QuizViewModel` is the heart of the application which manages the control flow of the main screen. 

On app start, it fetches the data from the backend, during which time a spinner is shown. Once the data is fetched, it starts showing questions in through `QuestionViewModel`. Once the user has gone through all the questions, a restart option is presented.

## Network
We are using `NetworkDependencyProvider`, which implements the protocol `NetworkDependencies`. By using the protocol, we can later mock the network APIs easily. The network calls rely on `WebService` and a `Routable` object, which in our case resolves to `QuizDataFetchService` and `BaseRouter`.

## Third Party Library Usage
For image fetching and caching, we are using `KingFisher`.


## Unit Testing (>90%)
Unit tests coverage for business logic in `QuizViewModel`, `QuestionViewModel`, `ResultViewModel`, `NewsArticleViewModel` is over 90% 
