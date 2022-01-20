# Mostoda
# Project description

I have developed this app for the final project of Tuwiq academy, iOS development path.
The idea is about an app that works like a midator between the seller and the purchaser. 
The user can create an account and exploring the others offers.
The purchaser should has the ability to contact the seller to complete the transaction.
The purchaser can be the seller at the same time because he/she can upload and show his/ her offers to the others.

# Main Objective 
The main purpose of this application is to show merchandise and products to others through this app.
The application allows users to show the services that they can provide to others.
It also allows requesting a specific service and presenting it to all users of the application 
so that whoever has the ability to provide it, can communicate with who asked  for by calling him/her or by direct messages which the application provide.

# Requirements
- As a user, I want to be able to create a new user by my phone number.
- As a user, I want to be able to create a profile that contains my information, name last name ,email, and  profile picture.
- As a user, I want to post my offers which contains offer pictures, title, and description to the public, somewhere in the Internet. 
- As a user, I want to explore the others offers and contact them for more details.
- As a user, I want to be able to show the others offer on the map where the offer is located.
- As a user, I want to be able to have a direct messaging with the others.
- As a user, I want to be able to know  whether the user is verified from “معروف” platform or not.
- As a user, I want to be able to leave a comment on any offer.
- As a auser,I want to be able to bookmork any offer I want.

# Tools And Techniques.
- macOS
- iOS.
- Xcode.
- Swift programming languages.
- Firebase real-time database.
- Firebase firestore database
- Firebase authentication.
- SPM (Swift Package Manager)

# Challanges
I have faced some issues with reading subcollections to to reach all ids that have direct messages with me.
And I solced it by extending my database by creating a new collection that hold all my recent messages.
This collection stores sender and reciver ids. When the reciver id is similler to mine, the app fetch this message and show it to me. 

# Prototype
<img width="568" alt="Prototype" src="https://user-images.githubusercontent.com/70614887/150392950-677785f2-aa02-4940-9306-f057338d02d0.png">

# Screenshots

![Simulator Screen Shot - iPhone 12 - 2022-01-20 at 20 54 47](https://user-images.githubusercontent.com/70614887/150394670-1c76fb76-e441-40fd-892e-006265cea1cb.png)

![Simulator Screen Shot - iPhone 12 - 2022-01-20 at 20 55 50](https://user-images.githubusercontent.com/70614887/150394815-2301dbad-d74b-4930-bd76-c21c9bd6d2db.png)

![Simulator Screen Shot - iPhone 12 - 2022-01-20 at 20 56 10](https://user-images.githubusercontent.com/70614887/150394872-b669f95e-cb2e-46c7-863d-ac0c4afd09e0.png)

![Simulator Screen Shot - iPhone 12 - 2022-01-20 at 21 15 52](https://user-images.githubusercontent.com/70614887/150397616-a707caef-60d3-4f1c-b567-9c08515946cd.png)

![Simulator Screen Shot - iPhone 12 - 2022-01-20 at 21 16 51](https://user-images.githubusercontent.com/70614887/150397762-1f56e2de-117c-4fe2-ab47-cf0652fdd128.png)

![Simulator Screen Shot - iPhone 13 - 2022-01-20 at 21 17 55](https://user-images.githubusercontent.com/70614887/150397924-960e193f-e8b3-4b8b-905e-84cfa290f265.png)

![Simulator Screen Shot - iPhone 12 - 2022-01-20 at 21 18 00](https://user-images.githubusercontent.com/70614887/150397933-bcad85d5-eb31-4ec6-90be-da933a47cc35.png)

![Simulator Screen Shot - iPhone 12 - 2022-01-20 at 21 19 17](https://user-images.githubusercontent.com/70614887/150398115-4b5654a8-fc3f-4f62-93d7-927783019bf7.png)

![Simulator Screen Shot - iPhone 12 - 2022-01-20 at 21 19 45](https://user-images.githubusercontent.com/70614887/150398178-e98d6fef-8dd1-496c-a63f-58ef11f23457.png)

![Simulator Screen Shot - iPhone 13 - 2022-01-20 at 21 26 14](https://user-images.githubusercontent.com/70614887/150399123-7bba908b-d3d0-4638-abc0-6dbad60122ae.png)
