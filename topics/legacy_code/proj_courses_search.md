---
parent: Legacy Code
grand_parent: Topics
layout: default
title: "Legacy Code: Courses Search"
description:  "Project specific documentation"
---

# {{page.title}}

Courses search is intended as an application that provides a more functional version of the official public
facing course search app available at the address: <https://my.sa.ucsb.edu/public/curriculum/coursesearch.aspx>

Our version, currently deployed at <https://courses.dokku-00.cs.ucsb.edu> provides many more features:

For example:
* Search by instructor (What courses has Diba Mirza taught?)
* Search by course over a range of quarters (Who has taught CMPSC 130A over time?)
* and many more

| Explanation | Link |
|-------------|------|
| Source code | <https://github.com/ucsb-cs156/proj-courses> |
| Production Deployment | <https://courses.dokku-00.cs.ucsb.edu> |
| QA Deployment (for CMPSC156 course staff) | <https://courses-qa.dokku-00.cs.ucsb.edu> |

## Environment Variables

The following values shoudl be set in `.env`, or via `dokku config:set`, or both:

| Key                      | .env | dokku | Explanation |
|--------------------------|------|-------|-------------|
| `PRODUCTION`             |      |    X  | Should be set to `true` so that the frontend is built into app and served directly from Spring Boot server, rather than via a separate server on port 3000 |
| `SOURCE_REPO`            |  X   |    X  | Should be set to the address of the repo if different from `https://github.com/ucsb-cs156/proj-courses` (e.g. `https://github.com/ucsb-cs156-s25/proj-courses-s25-02`) |
| `START_QTR`              |  X   |    X  | Should be set to first quarter that appears in dropdown menus, using `YYYYQ` format, e.g. `20204` for Fall 2020 |
| `END_QTR`                |  X   |    X  | Should be set to last quarter that appears in dropdown menus, using `YYYYQ` format, e.g. `20252` for Spring 2025 |
| `ADMIN_EMAILS`           |  X   |    X  | Comma separated list of emails of admins (no spaces). For the course, it's typically all members of your team, plus all course staff (instructor, TAs, LAs) | 
| `GOOGLE_CLIENT_ID`       |  X   |    X  | Google [OAuth credential](https://ucsb-cs156.github.io/topics/oauth/oauth_google_setup.html) |
| `GOOGLE_CLIENT_SECRET`   |  X   |    X  | Google [OAuth credential](https://ucsb-cs156.github.io/topics/oauth/oauth_google_setup.html) |
| `JDBC_DATABASE_URL`      |      |    X  | Password for [dokku postgres database](https://ucsb-cs156.github.io/topics/dokku/postgres_database.html) |
| `JDBC_DATABASE_USERNAME` |      |    X  | Password for [dokku postgres database](https://ucsb-cs156.github.io/topics/dokku/postgres_database.html) |
| `JDBC_DATABASE_PASSWORD` |      |    X  | Password for [dokku postgres database](https://ucsb-cs156.github.io/topics/dokku/postgres_database.html) |
| `MONGODB_URI`            |  X   |    X  | URI for [MongoDB](https://ucsb-cs156.github.io/topics/mongodb/) |
| `UCSB_API_KEY`           |  X   |    X  | API Key for [UCSB Developer API](https://developer.ucsb.edu/), see [below](#UCSB_API_KEY_values) |


## UCSB_API_KEY values

To deploy proj-courses, in addition to the usual GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET needed for other OAuth apps
in this course, you will also need a value for UCSB_API_KEY.  This is a key that gives you access to the API for UCSB course information.  These keys are obtained from the website <https://developer.ucsb.edu>.

You can request your own account, but it is typically faster to get one from the instructor, who will provide it to you on your
team slack channel.

When setting up API keys, we typically enable all of the API endpoints that are not sensitive or protected (i.e. the auto-approved endpoints.)  As of this writing, those are these endpoints:

* Academics - Events
* Academics - Academic Quarter Calendar
* Academics - Curriculums
* Dining - Dining Commons
* Dining - Dining Menu
* Students - Student Record Code Lookups

The ones that are currently used in the app are:

* Academics - Curriculums
* Students - Student Record Code Lookups

## MongoDB Collections

The Courses Search application uses a MongoDB collection as backup storage for the UCSB Curriculum information, so you will also 
need to set up a MongoDB collection and put the URL for that collection in your environment variables.  Read on for more explanation.

## Why MongoDB for UCSB Courses Search

While it might seem redundant to cache curriculum information in a separate database (vs. just going to the API each time), doing so provides several important advantages:

* It may be faster to get data from the MongoDB collection than from the UCSB API for some queries
* Some query types are not supported directly by the UCSB API; in particular, the UCSB API does not support searches across multiple quarters; it can
  only retrieve data for one quarter at a time.
* It provides a backup in case the UCSB API ever becomes unavailable temporarily or permanently.

In addition, it provides an opportunity to learn about how to work with a MongoDB database.

## Getting the value for `MONGODB_URI`

In the `.env` file for `proj-courses`, you'll need a value for `MONGODB_URI`.  That URI contains the hostname, username, password, and other information needed to connect to a MongoDB database provided by MongoDB.com.  

To start, in order to keep things simple, we will use the same database credentials for localhost, dev, qa and prod.  We acknowledge that this is not in keeping with "best practices" which would keep these separate (as they are for the SQL databases).  You have the option of learning how to create your own databases on MongoDB.com and then getting separate credentials for these if this becomes an issue that you need to tackle.

To get the value for MONGODB_URI, here's what you need to do.

1. Login to MongoDB.com; you should have gotten an invitation to a project in your email that matches your team name e.g. `f23-7pm-1`, `f23-7pm-2`, etc. under an organization that matches your class name (e.g. `ucsb-cs156-f23`).
2. Find your project. That should be a page that looks like this:
   <img width="1262" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/4e593aa1-1bf9-4ce1-8886-c7c5ec5e3f9d">
3. On the card for the deployment, there should be a `Connect` button, as shown below. Click that button
   <img width="1250" alt="click-the-connect-button" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/dbc82141-9cd8-4591-865f-0b2e76ddb69c">
4. That brings up this modal.  Click Drivers (the first option).
   <img width="782" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/1f855c4a-971c-41ca-8aef-f8eae9543da2">
5. That takes you to a page like this one.  The page asks you to choose a driver, but as it turns out that for both the default option (`Node.js`) and the actual option we are using (`Java`), the URI is exactly the same, and that's all we need here.  You will get the URI from the box as shown below.  Note, however, that this is *not* the final form of the URI; we'll have to do some editing here.  But, go ahead and copy that URI and paste it into your `.env` file as the value of `MONGODB_URI`.  For example, if the screen looks like this:
   <img width="786" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/7b10f1fa-42ee-4320-ad74-c042244cecf8">
   
   Then in your `.env` file, you'll start with this:
   ```
   MONGODB_URI=mongodb+srv://user:<password>@cluster0.vwrcszq.mongodb.net/?retryWrites=true&w=majority
   ```
6. Now, we need to do two things. The first one is to add in the name of our database, which we are calling `database`
   in order to keep things simple. The text `database` goes right after the single `/` and before the `?retryWrites`,
   like this:

   * OLD: <tt>MONGODB_URI=mongodb+srv://user:&lt;password&gt;@cluster0.vwrcszq.mongodb.net/?retryWrites=true&w=majority</tt>
   * NEW: <tt>MONGODB_URI=mongodb+srv://user:&lt;password&gt;@cluster0.vwrcszq.mongodb.net/<b>database</b>?retryWrites=true&w=majority</tt>

   Note that by convention, our projects use `database` as the database name, but if you use something else (say `potato`)
   then this should go in this spot in the URI.

7. I said there were two things.  The second thing is to replace `<password>` (including the `<>`) with the actual
   password.  Note that while there is a password that's already set for the username `user`, it is not possible to
   look that up; the only thing we can do is reset it.  So the next few steps are to reset this password, and then
   copy that value in, replacing the `<password>` in the URI.

   Note that another option is to add addtional users with names other than `user`; each of those can have a different
   password.  This may be important, because otherwise, if everyone on the team is sharing the same password, any time
   you need to update it, you have to coordinate with the entire team; changing it changes it for *everyone*.  So, it's
   up to the team how to manage this.  Decide whether its easier to have just one user/password combination, or whether
   it's easier to create separate user/passwords for each team member.

   To change the password value, navigate to the main page of the project, so that it looks like this:
   <img width="1240" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/f6449825-6383-4497-92ea-6a80868da467">
   
   Find `Database Access` on the left nav and click. You'll see a page like this one:

   <img width="1243" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/9db6a69e-653f-4e46-bd5a-1c4e833bf316">

   Here, you have a choice; edit the user called `user` to reset the password, or create additional users.  If you create
   additional users, you'll need to change the `user` in the MONGODB_URI as well; for example, if you create `cgaucho`,
   then the MONGO_URI changes like this:

   * OLD: <tt>MONGODB_URI=mongodb+srv://<b>user</b>:&lt;password&gt;@cluster0.vwrcszq.mongodb.net/database?retryWrites=true&w=majority</tt>
   * NEW: <tt>MONGODB_URI=mongodb+srv://<b>cgaucho</b>:&lt;password&gt;@cluster0.vwrcszq.mongodb.net/database?retryWrites=true&w=majority</tt>

   In any case, to change the password, you go into the `edit` button beside the user.  You'll see this:

   <img width="925" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/ac81a43f-9a34-46a1-9992-44b811063a5d">

   Click the `Edit Password` button.

   Click `Autogenerate Secure Password`.  Then either click the `Copy` button to copy the password, or click the `Show` button and copy it manually.  Either way, it's probably a good idea to `Show` the password and copy/paste it into your URI before you click `Update User` to make sure they match.  And **you must scroll down and click `Update User`!** This is easy to forget because the `Update User` is *not visible*  until you *scroll down*.  I have made this mistaken dozens of times, and it's a time-consuming one to make.

   Here's what that looks like, including copying the password into the `MONGODB_URI` in `.env` and *scrolling down*
   to *click Update User*:

   ![mongo-db-password-update](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/3bd3c18c-7061-4209-8879-c552ee6f9f40)

 With that (along with configuring the other values in `.env`), you should be able to run `mvn spring-boot:run`

 To check if it is working, login as an admin, and try loading courses for a quarter, like this:

 ![load-courses-for-quarter](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/81423036-76d1-45ab-ad72-26a315d542be)

 As shown in the animation above, if the MongoDB database is working, you'll be able to see messages indicating success.

 At that point, you can also browse the MongoDB collection manually, as shown below.

## Navigating to the databases and collections

Your team should have a deployment with the default name (typically `cluster0`).  Inside this deployment, there should be a database called `database`, which can contain multiple *collections*.  

Collections functions similar to tables in an SQL database, although they have a differerent structure: they are key/value stores that function similar to JSON objects.
In fact, they use a variant of JSON known as BSON (which stands for "Binary Javascript Object Notation").  It's the same idea, except, internally, the objects are not literally stored in JSON, but in binary encoding of JSON.

To navigate to your database and collections, follow this path in MongoDB.com:

From the deployment card, click `Browse Collections`:

<img width="593" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/98c3314a-7cb2-45c6-a4c0-87f3b8273c51">

You should see an interface similar to this one:

<img width="1039" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/7f17f105-cc5a-4fd3-8bf6-2e9ad20ae38b">

The collections themselves are explained in further detail below.



## The main collection

The main database in your MongoDB deployment should be called `database`, and the main collection should be called `courses`.

You can do queries like as shown below.  This is a query that finds all records for quarter `20231` (Winter 2023) and the enroll code `07443`. 

```
{ 'courseInfo.quarter' : '20231', 'section.enrollCode' : '07443' }
```

<img width="967" alt="image" src="https://user-images.githubusercontent.com/1119017/203236404-32c67f00-11b7-46ae-8c98-d1b6f27548ce.png">

As we can see here, this brings up two records; this is the result of loading the data for this quarter twice without first defining an index to prevent duplicates (as illustrated below).


## Avoiding Duplicate Data

To avoid duplicate data, it is helpful to define an indexes that prevents storing multiple documents with the same quarter and enroll code.  Here's how.

First, we want to ensure that the combination of `courseInfo.quarter` (e.g. "20231") and `section.enrollCode` (e.g. `07443`) is unique, so that we don't end up storing duplicate data.  We can do that by defining an index like this:

Go to the index tab (second over in MongoDB.com collections page):

<img width="977" alt="image" src="https://user-images.githubusercontent.com/1119017/203235608-4ba7d26b-65c2-4042-800f-b303fcc920ae.png">

Click the `Create Index` button at right: 

<img width="126" alt="image" src="https://user-images.githubusercontent.com/1119017/203235693-e4e97ab5-b9fd-4a4c-adcd-a40c460edc3c.png">

That brings up this modal: 

<img width="714" alt="image" src="https://user-images.githubusercontent.com/1119017/203235761-c7918199-2af8-481e-b529-97351301de54.png">

Fill in `Fields` with:

```
{
  "courseInfo.quarter": 1,
  "section.enrollCode" : 1
}
```

Then fill in options with:

```
{unique:true}
```

So that it looks like this:

<img width="701" alt="image" src="https://user-images.githubusercontent.com/1119017/203236005-98152214-4f72-435f-9344-c5f43a7a95a5.png">


Then click "Review".

Note that if you already have duplicate data, adding this constraint will not eliminate those. You may need to drop the collection and recreate it with the constraint in place (i.e. add the constraint before you start adding data.)

# Querying Data in MongoDB

The animation below shows how to do some basic queries in MongoDB.

A few tips:
* Use single quotes, not double quotes.
* Query by simply listing the keys (using dot notation for nested fields) and the values those fields should have.
* Examples:

  ```
  { 'courseInfo.quarter' : '20231'}
  ```

  ```
  { 'courseInfo.quarter' : '20231', 'courseInfo.title': 'INTRO DATA SCI 1' }
  ```
  
  
  ```
  { 'courseInfo.quarter' : '20231', 'courseInfo.title': 'INTRO DATA SCI 1' , 'section.enrollCode' : '07443'}
  ```

  


![see-mongodb-data](https://user-images.githubusercontent.com/1119017/203417526-acb3ebab-3669-4940-a434-5e3953022541.gif)

# Queries with regex

You can use regular expressions to match course ids that start with a certain subject area.  For example, this will find courses
in quarter `20231` where the `courseInfo.courseId` field starts with `MATH`:

```
{ 'courseInfo.quarter' : '20231', 'courseInfo.courseId': { $regex: /MATH/ }}
```

# Staff Setup for proj-courses 

<details markdown="1">
<summary markdown="1">
This section is for the staff and instructor.  Students and others are welcome to look at it, but it typically doesn't pertain unless you are on the staff of the course (instructor/TA/LA).  Click the triangle to reveal the details.
</summary>


## Set up on MongoDB.com

Dokku does have the ability to create MongoDB instances, and eventually it would be nice to migrate to that solution.  For the time being, however, we have not figured out how to take advantage of that capability and connect it to our Spring Boot code bases. Therefore, for the time being, we are using the free tier of <https://mongodb.com> to provision mongodb databases for our courses.

To set up resources for proj-courses for CS156 using mongodb.com, here is how we've proceeded in the past.

First, login to MongoDB.com with your UCSB Google Account.

### Creating an organization

Here is how you navigate to the page where you can create a new organization, as illustrated in the animation below:

1. Select the dropdown, upper left, that shows your organizations.
2. Scroll to the bottom where it says: `All Organizations`
3. On that page, a `Create New Organization` button appears at upper left.

![mongodb-navigate-to-create-new-org](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/4d1979d4-6230-4e42-ae1f-aab771ccc5f7)

The form to create a new organization has multiple pages.  On the first page, put in the name
of your organization (e.g. `ucsb-cs156-f23`), select `MongoDB Atlas` and then scroll down and click `Next`

<img width="781" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/06817ce4-583a-47f6-acd6-913888a169c5">

<img width="820" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/327d3573-8f01-4450-9d21-f8d8d1918646">

On the next screen, take the default (which is that the option `Require IP Access List for the Atlas Administration API` is selected) and click `Create Organization`

<img width="716" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/bb16b946-68df-404a-9d41-7333bb514ec7">

That takes you to this screen, where you can create projects:

<img width="1082" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/53052694-18ab-4102-9390-268a3902d571">

### Creating Projects in a MongoDB Organization

If you just created your organization, it will probably be selected as the default organization, upper left, but if not, select your organization like this:

![mongo-db-select-org](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/abb89820-a37a-4eb9-89f7-40f6a904389f)

Then, click `Projects` in the left nav to get to the Projects page where you can see your projects and create a new project by clicking the `New Project` button.  I suggest creating one project per team (for the teams that need a MongoDB deployment, which includes, at least, all teams working on proj-courses).  Here, we'll just create the projects, and deal with adding users as a separate step.

![mongo-db-create-projects](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/9d65cc3f-416f-44e5-a16a-01d69982c5fc)

Now that we have one project per team, we'll add users and create deployments.

### Adding Users to a Project

Next, pull up a roster with the `@ucsb.edu` email addresses of the members of each of the teams
for which you set up a project; in the example here, that's `f23-7pm-1`, `f23-7pm-2`, `f23-7pm-3`, `f23-7pm-4` as shown on the project page:

<img width="1048" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/6ce41d3d-0fdf-49d9-9b35-07e420fa2377">

Choose the first project, e.g. `f23-7pm-1` by clicking its name; that takes you to a page like this one:

<img width="1061" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/492fd4fb-46ec-4d03-b9b1-cf19dea70e69">

Find the `Access Manager` tab at the top of the page, like this, and select `Project Access`

<img width="535" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/dc30014a-53d6-46fc-993b-d98e5dbb9db0">

That takes you here:

<img width="1059" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/5928a130-5ae6-4d44-9b82-9b8eb0a7066c">

Clicking `Invite to Project` takes you here:

<img width="1057" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/195958a6-ca83-4b0e-af4d-8012d423eb5f">

Regrettably, it does not seem to be possible to paste in multiple email addresses, even if
separated by spaces or commas; this has to be done one at a time.

Paste in each email address to create an invitation.  As you do, for each invitation,
click `Project Owner` in addition to `Project Read Only`; this makes it unnecessary to click
each individual box, and gives students full permission over their project.

<img width="825" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/62c19dc2-cd81-4ec7-8f41-2ae9b68d3846">

Repeat for each student on the team.  If you want to delegate this to a TA or LA, you can
add them as organization owners (we'll cover this below).

After inviting all students, it may be helpful to post a message on each of their team slack channels, or on the proj-courses slack channel saying something like the following.

```
@channel Please look in your email for an invitation to create a MongoDB.com account, and join the project for your team (e.g. `f23-7pm-1`, `f23-7pm-2`, `f23-7pm-3`, `f23-7pm-4`).  Please accept that invitation before your next scheduled class, or during your next scheduled class. 

You will need this access in order to work on proj-courses. We'll explain more in class, and/or in future posts to this slack channel.

We'd like to see that all team members have done so by the end of the next scheduled class.
```

### Creating Deployments

For each team (in course terms), i.e. each project (in Mongodb.com terms), it is now necessary to create a deployment.  The deployment is where the MongoDB databases and collections are actually deployed, i.e. it is a kind of virtual server where the databases are deployed.

To create a deployment for a team/project, navigate to the project page and select the `Data Services` tab (leftmost at top).  If it is a new project with no deployments yet, you'll likely see
the very prominent `Create a deployment` card with a `Create` button in the middle of it, like this:

<img width="1039" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/97206e4e-fab3-4e31-b004-653e942fa420">

When you click that button you'll be taken to this screen, where the obvious choice is the free tier.  Click on that to select it so that it is outlined in dark green, like this (note that the free tier is *not* the default option!)

<img width="1163" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/fa1fcabd-f9a3-40cb-9258-8dad18fb11ac">

The scroll down, where you can choose a provider: AWS, Google Cloud, or Microsoft Azure.  At present, all three are options for the free tier, so choose whichever you like.  AWS is the current default, so that's what I usually choose.

The default region is `US East (Virginia)`; I typically change this to `US West (Oregon)` since we are located on the West Coast, but that's again up to you.

<img width="501" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/9debca75-2fe0-4e36-891d-622c106644a4">

I typically take the default name for the cluster:

<img width="455" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/fab0bfd3-078a-4082-869d-7429713481c2">

Finally, click `Create`:

<img width="1112" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/c7b94d9f-31da-4677-9a29-056945ca49a2">

When you do, you'll be directed to this screen where we'll set up the security for the cluster:

<img width="1061" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/4d63ad15-127f-4b38-a62f-2f795ca873cc">

For the first question, take the default (Username/Password authentication):

<img width="816" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/9ec8063b-488d-4c04-9bc9-ace365641df8">

Scroll down to this page.  Here, the default username will probably be the  username from email address of the person creating the deployment; *you should not take this default*.  This username is the one that will be embedded in the credentials for the database, so it's more typically something like `user`.  I suggest changing it to `user`.

<img width="739" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/ae607a84-a9c5-40ef-a2f3-df97d8b1b574">

So change it to this:

<img width="755" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/d2c1650a-de2b-40df-b412-9e375e885286">

The default generated password is fine; the one shown in this screenshot is NOT the one I used; I clicked the `Autogenerate Secure Password` to create a new one after taking this screenshot.

Click `Create User`.  Note that the password is now no longer available; it will be necessary, later, for the students to generate their own password when they want to embed the password in their URL.  That's fine; we'll provide instructions to walk them through that.

The next step is to scroll down to this section, where you'll need to change the IP address restrictions:

<img width="821" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/caea17e5-76c0-47ef-9b37-9a8acbfeddca">

We need to change this to allow connections from all IP addresses.  An alternative would be to get the public IP address of their dokku server, or the IP address range for UCSB, and put that in.   That would be preferable, but as of this writing, we are still just leaving this open; we used to have to do that since we were using Heroku, and could not predict the IP address ranges that Heroku would be coming from when connecting to MongoDB.

Here's how to open the deployment to connections from all IP addresses:

1. Enter `0.0.0.0` for the IP address, and `Entire internet` as the description.
2. Add that entry
3. If desired, remove the specific entry for the ip address you were at when you create the deployment.
4. Then click `Finish and Close` to save the changes

That is illustrated here:

![mongo-all-ip-addresses](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/27e582f5-3ca6-4b9e-8c78-589e743aa2ed)


### Updating Access 

If you need to modify the user or password, you can get back to edit those from the project page by selecting `Database Access` from the left nav of the project page, as shown below.  Be sure that if you change the password, you click `Save Changes`, or they *will not take effect* and the old password will still be the one in use.

![mongo-db-access](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/694fa093-83ed-467f-8bad-a1fc5bc9c32f)


</details>



