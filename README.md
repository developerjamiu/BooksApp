# Books App

App and Up Flutter Take Home Project

## Introduction

This project is the implementation of the App and Up Flutter Take Home Project.

### Requirements
-   Authentication with Firebase Authentication (Email + at least one social), design of the required screens is up to you.
-   Show a list of books gotten from the Google Books API
-   Allow the user to search for books
-   Replicate the design given for the page listing the books.
-   Add a detail page showing the details of the selected book, the design is up to you.
-   Allow the user to add and remove a book from his favorites by saving it on a Firebase Firestore Database.
-   BONUS: implement a Firebase Cloud Function doing something you feel worthwhile for the app.
-   BONUS: handle App responsiveness on the Desktop/Web.

### Implementation
The project was implemented with custom architecture similar to MVVM where
-   ViewModels are known as modifiers and
-   Class Dependencies are managed using the Riverpod Providers
