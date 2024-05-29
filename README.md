# Books App

Google Books API Exploration

## Introduction

This project explores the Google Books API.

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
-   ViewModels are known as notifiers
-   Class Dependencies are managed using the Riverpod Providers
-   There are usage of special providers such as StreamProvider, StateProviders that comes with riverpod
-   It uses the classic repository approach
-   Services for performing network requests, contextless navigation etc are grouped as well

### Build Limitations

-   The project depends on an API Key (for calling the books api) which I gitignored so kindly generate an APIKey and place an apiKey constant in lib/src/services/base/api_credentials.dart 
-   Google Signin will also not work until you add a valid SHA 1 key.

### When building for Web

run with PORT 5000 for Google Signin to Work i.e flutter run -d chrome --web-port=5000

### Find app screenshots here

![register](https://user-images.githubusercontent.com/50176100/137649903-6ebe2f8b-c228-4ecb-984f-0618e743acd4.jpeg)
![login](https://user-images.githubusercontent.com/50176100/137649905-68a2c42e-445b-48b2-836d-6dadfa465933.jpeg)
![forgot_password](https://user-images.githubusercontent.com/50176100/137649904-3fd2def7-17f1-40d3-8c0e-5a546deb9d5f.jpeg)
![google_signin](https://user-images.githubusercontent.com/50176100/137649906-36ac93e1-58ac-4abc-9797-b4b53c2aede8.jpeg)

![books](https://user-images.githubusercontent.com/50176100/137649907-7e42b14d-8172-48bb-a288-ba8058b31e59.jpeg)
![book_details](https://user-images.githubusercontent.com/50176100/137649908-7afda413-6b85-4084-87f3-3d3879b9b4b6.jpeg)
![favorite_books](https://user-images.githubusercontent.com/50176100/137649892-3bcec5df-4035-42be-b064-29b3f7ee0d12.jpeg)

![profile](https://user-images.githubusercontent.com/50176100/137649898-4e2ef423-dfc4-4eb0-ba79-09aaa33d609f.jpeg)
![update_profile](https://user-images.githubusercontent.com/50176100/137649899-14545476-9295-4ba4-94e7-8da9016df998.jpeg)
![update_password](https://user-images.githubusercontent.com/50176100/137649901-00701493-962a-4f9a-8273-de84681eef64.jpeg)
![update_email_address](https://user-images.githubusercontent.com/50176100/137649902-dc088a88-ac64-4cdf-b663-20a43ac19475.jpeg)
