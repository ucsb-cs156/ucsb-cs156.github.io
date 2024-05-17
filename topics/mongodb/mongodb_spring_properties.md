---
parent: MongoDB
grand_parent: Topics
layout: default
title: "MongoDB: Spring Properties"
description:  "How to set properties for connecting to MongoDB when using Spring"
category_prefix	: "MongoDB: "
indent: true
---

The best way to set the connection to a MongoDB database when using Spring is to set the value of the property `spring.data.mongodb.uri`, which
is initialized in our code bases (e.g. `proj-courses`) from the environment variable `MONGODB_URI`.

Accordingly, you'll see this in the `.env.SAMPLE`:
```
MONGODB_URI=see-instructions-in-readme
```

Sometimes you'll be provided with a connection URI such as this one:

```
mongodb+srv://<username>:<password>@cluster0.a1bcd.mongodb.net/<dbname>?retryWrites=true&w=majority
```

It is important to note that `<username>`, `<password>` and `<dbname>` need to be replaced with actual values that
you would be supplied with separately.

When you replace the values, do not include the `<>` characters.

# Creating the database

One person on the team will need to create the database.  Here's how that looks.

* Navigate to Database
* Click "Browse Collections"
* Click "Add my own data"
* Put in `database` as the name of the database and `courses` as the name of the collection

Now you have a database called "database"

![mongodb-create-db](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/f9a751dc-b7e4-4c56-a778-e3f290889eab)


# Get the value for the connection URI

This shows how to get the value for the connection string:

![get-connection-string](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/a1200926-bae6-468f-954b-ea3453e4eb82)


# Getting the value for password (from mongodb.com)

To get the value for password for a MongoDB database hosted on [MongoDB.com](https://mongodb.com),

* Navigate to Database Access
* Edit the user `dbuser`
* Change the password (note that you cannot get the current password; you can only change the password)
* Copy the password (and paste into your connection string in place of `<password>`
* IMPORTANT: scroll down and *save the changes* otherwise the new password will not take effect!

![get-mongo-password](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/4c2296ec-39e3-4301-8db8-c5523103b5f3)

You can also create a new user if you want to be sure that you will not impact other members
of your group; in that case, you need to change `dbuser` in your connection string (e.g. to `dbuserPhill`)

Note that you need to give your user a name, and you also need to select a role (I forgot that the first time in the example shown,
which is why the save doesn't work the first time):

![get-mongo-new-user](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/c321d32d-bb96-489f-b73e-410269b96f02)



# Configure for network access from anywhere

You may need to configure your MongoDb.com database for network access from anywhere.

Use this menu item:

<img width="209" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/dce7ff10-4be5-4a95-bbf1-3b642f8b9c78">

Then, add the network address `0.0.0.0`, which represents "the entire internet".

![add-all-internet](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/96d328ae-c382-425d-a118-51d2fca89368)

