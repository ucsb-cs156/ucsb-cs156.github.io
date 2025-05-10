---
parent: APIs
grand_parent: Topics
layout: default
title: "APIs: UCSB Developer API"
description:  "Found at developer.ucsb.edu"
---

# {{page.title}} - {{page.description}}

The website <https://developer.ucsb.edu> offers API access to a variety of UCSB data sources.

Two UCSB legacy code projects make use of these APIs:

* <https://ucsb-cs156/proj-courses>: A course search app
* <https://ucsb-cs156/proj-dining>: An app that shows dining commons menus and provides a way to leave reviews.

An API Key is required to use these APIs, and so is required to set up either of these apps.

Anyone with UCSB login credentials can create a UCSB developer account, and then create one or more API keys.

A few endpoints are "auto-approved", meaning that anyone with a UCSB account can set up a key to access these endpoint.  *These are the only ones that we use in CMPSC 156*.

These allow access to information that is, for the most part, already available on public facing websites.  The API gives us programmatic access to that and avoids the need for "screen scraping".
* Course catalog listings 
* Dining commons menus
* Translations of "codes" into "text" (e.g. translating `"CMPSC"` to `"Computer Science"` and `"ARTHI"` to `"Art History"`.

Most other endpoints, however, because they expose potentially sensitive information, require "approval", which you are unlikely to get (so I encourage you not to ask for it; if they start getting
lots of requests, my concern is that they'll just make the process more difficult, and that wouldn't serve anyone well.)  

The rest of this page explains:
* How to set up an account
* How to set up an API key
* How to make use of "Try out an API page" (which will be familliar, since it uses Swagger, just like our code bases)
* How to access these APIs from a Spring Boot backend
* How to configure proj-courses and proj-dining for a UCSB_API_KEY on localhost and dokku
 
## How to set up an account

To set up an account:

1. Navigate to <https://developer.ucsb.edu/> in your web browser
2. Click `Log in` or `Create an Account` (if you are not yet logged in, they both end up at the same place)
3. Click the `Log in with UCSBNet id` button. 

   <img width="431" alt="image" src="https://github.com/user-attachments/assets/c39b98bc-07b2-4e20-97dd-00b1808d1de6" />

   Please *don't* try applying to create a "Functional Account".
   Those are only provided to staff and administrators as explained [here](https://developer.ucsb.edu/docs/accounts/developer-portal), and there's a
   whole bureaucratic process.
4. An account is created for you automatically.

# How to set up an API key

To set up an API key you create an "app".   

1. From home page, click Apps on top menu row
   
   <img width="619" alt="select-app" src="https://github.com/user-attachments/assets/1ea8d66c-4b3e-462f-b989-9efde85c014b" />

2. Click the `Add app` button:

   <img width="644" alt="click-add-app" src="https://github.com/user-attachments/assets/389146c4-3c85-40ce-aec5-3888dc3d939f" />

3. In the form that comes up, fill in the name and description.  The name is the only required field, and the name is solely for documentation purposes.  I suggest you choose
   a name that makes sense to you, such as the name of the repo you are doing your project in, but this can literally be anything you want.   

   <img width="937" alt="fill-in-form" src="https://github.com/user-attachments/assets/47f07ac0-6ec7-411a-b650-2edae0debd52" />

   Then scroll down so that you can see all of the check buttons for APIs, as shown in the image below.

4. Check **exactly, and only**, the buttons shown below.  This gives you access to all of the auto-approved APIs (and *only* those.)
   * Checking fewer means some functions might not work.
   * Checking more will delay getting your credentials (while your access request is processed, and then inevitably, denied.)

   <img width="915" alt="Selecting auto approved APIs" src="https://github.com/user-attachments/assets/57f2af01-346b-4f6e-831b-6c336fec026e" />

   The eight Auto-Approved APIs you want to select are:

   | API Category | Resource |
   |--------------|----------|
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Curriculums](https://developer.ucsb.edu/content/academic-curriculums) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Graduate Programs](https://developer.ucsb.edu/content/academic-graduate-programs) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Quarter Calendar](https://developer.ucsb.edu/content/academic-quarter-calendar) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Events](https://developer.ucsb.edu/content/events) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Dining Commons](https://developer.ucsb.edu/apis/dining/dining-commons) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Dining Menu](https://developer.ucsb.edu/apis/dining/dining-menu) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Meal Plan Rates](https://developer.ucsb.edu/apis/dining/meal-plan-rates) |
   | [Students](https://developer.ucsb.edu/apis/students) | [Student Record Code Lookups](https://developer.ucsb.edu/content/student-record-code-lookups) |

5. When you've selected all of these, click the `Add app` button at the bottom of the page:

   <img width="158" alt="image" src="https://github.com/user-attachments/assets/7ce774e6-6252-4976-9a8f-72f9a864a57c" />

6. You'll be returned to the `Apps` page with a message like this one:

   <img width="158" alt="image" src="https://github.com/user-attachments/assets/24658da1-291b-4ee1-a451-22e5efee251a" />

   You should then find your app in the list of apps, like this:

   <img width="899" alt="your-new-app" src="https://github.com/user-attachments/assets/5b948145-2016-44af-a3ac-42b60d5c6962" />

7. To access your API key, click on the app name as shown in the image above.  That will take you to page like this one:

   <img width="877" alt="consumer-key" src="https://github.com/user-attachments/assets/dab3ec39-c0e2-40e6-add3-f7aad2913f9e" />

   On this page, the only information you need is the Consumer Key, which is circled.  Click where it says `Show key` and the key will
   be revealed (a long sequence of letters and numbers).

   You can access this at any time; it isn't a "one time reveal" like some of the
   secret values provided by Google and Github APIs.  But for now, copy it so that you can paste it in the next step that we try.

## Trying out an API

To try out an API navigate to any one of the eight API endpoints that are Auto Approved.  You can use the navigation on the website,
or one of the convenient links here.  I suggest [Student Record Code Lookups](https://developer.ucsb.edu/content/student-record-code-lookups) because it's the easiest to understand.

   | API Category | Resource |
   |--------------|----------|
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Curriculums](https://developer.ucsb.edu/content/academic-curriculums) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Graduate Programs](https://developer.ucsb.edu/content/academic-graduate-programs) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Quarter Calendar](https://developer.ucsb.edu/content/academic-quarter-calendar) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Events](https://developer.ucsb.edu/content/events) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Dining Commons](https://developer.ucsb.edu/apis/dining/dining-commons) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Dining Menu](https://developer.ucsb.edu/apis/dining/dining-menu) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Meal Plan Rates](https://developer.ucsb.edu/apis/dining/meal-plan-rates) |
   | [Students](https://developer.ucsb.edu/apis/students) | [Student Record Code Lookups](https://developer.ucsb.edu/content/student-record-code-lookups) |

Once you land on the API page, it will look familiar if you've used Swagger in your CMPSC 156 Spring Boot apps.  Here's an example page:

<img width="979" alt="authorize button" src="https://github.com/user-attachments/assets/7f61e9c5-d0d5-44d3-bf56-eccfe70a73f1" />

What's different is how you unlock the API so that you can "try it out".  You need to click the Authorize button indicated in the image above.

When you click this, you see the following modal pop up.  Paste the "Consumer Key" value that you copied into this form, and click `Authorize`:

<img width="515" alt="image" src="https://github.com/user-attachments/assets/a44811cd-5904-436f-aa27-b8649215bc65" />

When you do, the modal will change to look like this. Click `Close`:

<img width="516" alt="image" src="https://github.com/user-attachments/assets/4fa3ef9f-1da0-4013-a9d8-8ae2eaf7ecfc" />

You should now be able to click the `GET` buttons on any of the API endpoints, and open up the Swagger interface:

<img width="516" alt="image" src="https://github.com/user-attachments/assets/8737247c-6243-4ac9-bed9-f3ab50f6fbc1" />

You can then click the `Try it out` button, which should give you the `Execute` button:

<img width="516" alt="image" src="https://github.com/user-attachments/assets/d5a2f1a3-6d8b-4910-9a3d-7e31c4e3d954" />

After you do this, you can see the Response Json on the page:

<img width="516" alt="image" src="https://github.com/user-attachments/assets/a3e4e88d-9a71-45fa-8e28-6032b4cdb683" />

You are invited to try out a few of the APIs from this list so that you get comfortable with using them.

   | API Category | Resource |
   |--------------|----------|
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Curriculums](https://developer.ucsb.edu/content/academic-curriculums) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Graduate Programs](https://developer.ucsb.edu/content/academic-graduate-programs) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Academic Quarter Calendar](https://developer.ucsb.edu/content/academic-quarter-calendar) |
   | [Academics](https://developer.ucsb.edu/apis/academics) | [Events](https://developer.ucsb.edu/content/events) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Dining Commons](https://developer.ucsb.edu/apis/dining/dining-commons) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Dining Menu](https://developer.ucsb.edu/apis/dining/dining-menu) |
   | [Dining](https://developer.ucsb.edu/apis/dining) | [Meal Plan Rates](https://developer.ucsb.edu/apis/dining/meal-plan-rates) |
   | [Students](https://developer.ucsb.edu/apis/students) | [Student Record Code Lookups](https://developer.ucsb.edu/content/student-record-code-lookups) |

## Configuring `proj-courses` and `proj-dining` with values of the `UCSB_API_KEY`

If you've configured your app for Google OAuth, then you are familiar with how to:
* Set values in the `.env` file for localhost
* Set values using `dokku config:set ...` on dokku

The value of UCSB_API_KEY is set in exactly the same way; use the `Consumer Key` value explained above.

## Sample Code

Here are links to some sample code for using the UCSB API in our Spring Boot apps:

* 
