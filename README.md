# foodback
CS 360 (Software Engineering) Project

Group 12

_______

### Summary:

This is a web application and is very specific to LUMS.

The client, Ayamma Mohsin, is a student of LUMS, who has trouble keeping track of her monthly allowance for food. She ends up spending too much too fast, and does not have a lot of money to spend towards the latter half of the month. She wants an application that can keep track of her expenses and tell her when she is about to exceed her budget limit. The other stakeholders would be other students of LUMS who have the same problem that Ayamma does.
The design for the application is as follows:
- The Application essentially acts as a digital wallet. It keeps track of your finances, and provides you a value for the average amount of money you should spend every day (particularly on food), so that you do not overspend.
- Every user would need to make an account for himself/herself. The user would need to input the amount of money they have to spend, by the end of the month. If the user wants to save a certain amount of money, he/she can enter that value as well. If the user can spend a certain amount of money up to a specific date of the month, and then can spend the remaining afterwards, those constraint are also added. The application will then calculate how much money you should ideally spend every day, so that by the end of the month those requirements are met.
- We divide the transactions into two broad categories; those related to food, and general transactions. The application will have a separate tab for general transactions, a separate tab for each of the food places in LUMS, and a separate tab for if you order food from outside of LUMS. Whenever you make a transaction, you enter the amount that you spent, eg 500 rupees, in the relevant tab and you also mention what you spent it on. If this is a food item, this helps the application understand what food you like better from which venue inside LUMS.
- The application does not only keep track of how much you can spend, but it also provides you with food suggestions if you want it to. If, for example, the application has told you that you can spend 1000 rupees per day, you may give the application an idea of how much you wish to spend at that moment in time on food, and it will make food suggestions for you. Let's assume a person had 1000 rupees to spend, and they want to spend 200 out of it on their breakfast. They simply need to enter that amount into the application and the application will judge where in LUMS you are currently standing, and will give you food options based on what food is near you and what food lies in your price range. Every time you try something out from a food place at LUMS, you may also mark the item as a ‘favorite’, so that the next time you are near that food place again, the application will suggest that food to you as well.
- By the end of each day, the application recalculates your budget for the week, so that in case you exceeded your daily budget, you at least meet your weekly budget. Besides giving you the recalculated budget, it also generates warnings if you exceed the budget.
- The application also has a ‘reward’ feature. If you meet your weekly budget, it suggests that you reward yourself for following the budget plan. The application will therefore, at the end of the week, provide you with a list of more expensive food that you can afford, from inside LUMS, if you wish to.
- Every user can also have a friend list. This includes people who are also using the same application. Your friends may share information about what they just ate, and whether they liked that food or not. This may help you make a decision about what you wish to eat as well.
- The web applications will have a responsive design, so that it is compatible with both mobiles and desktop machines.

_______

### User Stories

Feature: Set a daily spending limit and keep a record of daily expenditures

As a Hostelite

So that I don’t ruin my budget by having fancy meals and end up eating Daal-roti three times a day.

_______

Feature: Save money from my monthly budget

As a dependent student

So that I can wisely spend my money and buy what I want at the end of the month with my target savings.

_______

Feature: See all open options within the range of my daily budget plan

As a Foodie

So that I can view all the options and choose the best affordable meals.

_______

Feature: Sensible spending of monthly budget on food

As a dependent Student

So that I don’t run out if money at the end of the month and can spend wisely.

_______

Feature: Mark my food preferences

As a foodie

So that I know whenever I can afford my favourite meals.

_______
