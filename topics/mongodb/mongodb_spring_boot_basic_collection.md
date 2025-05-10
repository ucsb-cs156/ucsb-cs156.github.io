---
parent: MongoDB
grand_parent: Topics
layout: default
title: "MongoDB: Spring Boot - Basic Collection"
description:  "Accessing a MongoDB collection from Spring Boot"
category_prefix	: "MongoDB: "
indent: true
---

<div style="width:90%; margin-left: auto; margin-right: auto; border: solid red 5px;" markdown="1">

**NOTE**: As of Spring 2025, we recommend using the MongoDB that is provisioned directly by Dokku instead
of using MongoDB.com; we are retaining this page on the website only in case the need arises to use
MongoDB.com hosting again in the future.

</div>

This article assumes that you have worked through the steps in [MongoDB: New Database](https://ucsb-cs156.github.io/topics/mongodb_new_database/) to 
set up a MongoDB deployment on the site <https://cloud.mongodb.com>, with:

* a cluster than can accessed from `0.0.0.0/0`, i.e. from any IP address
* a username and password with read/write access
* a database called `database` and a collection called `posts`

From that starting point, we'll explain:

* How to set up a Java class that represents a single `Document` in the  collection
* How to set up a Java class that represents the entire collection
* How to use those classes in backend controller methods to do CRUD operations on the collection.


# Setting up the `pom.xml`

To work with MongoDB, we should add the following dependency to our `pom.xml`.  Check the URL in the comment for the latest version; at this writing
that is `2.6.3` but it may be later by the time you are reading this.

```xml
   <!-- https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-data-mongodb -->
   <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-mongodb</artifactId>
   </dependency>
```

If using the the `spring-boot-starter-parent` as many of our projects are, i.e. the code below, then it is not necessary to specify a version; that will 
be determined by the version in the `<parent>` element:

```xml
    <!-- https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-parent -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.3</version>
        <relativePath /> <!-- lookup parent from repository -->
    </parent>
```

Otherwise consult the URL in the comment to determine the latest version to use.

# Adjusting our collections

If you followed the  [MongoDB: New Database](https://ucsb-cs156.github.io/topics/mongodb_new_database/)  to set up your database, you
have:
* a database named `database`
* in that database, a collection named `posts`

To see that, here are the navigation steps you need:
* Select your organization:

  <img alt="" src="https://user-images.githubusercontent.com/1119017/152418744-43db11db-8d17-43ca-ad1d-a4feda301e73.png" width="800" />)

* Select your project:

  <img alt="" src="https://user-images.githubusercontent.com/1119017/152418808-cc834de9-d9ae-4cc7-8292-2875cbf802c7.png" width="800" />)
  
* When you see the cluster where your project is deployed, you can either click the `Browse Collections` button:

  <img alt="" src="https://user-images.githubusercontent.com/1119017/152418932-ee46623d-179b-4095-913a-5e62ce528552.png" width="800" />)

  Or you can click into the cluster, and then select the Collections tab:
  
  <img alt="" src="https://user-images.githubusercontent.com/1119017/152419023-81067c84-08ac-49e4-af44-0ef78efb46e3.png" width="800" />)

When you get there, you see this:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152419327-0d354c2f-68e2-4792-ad44-c39c5efa1a52.png" width="800" />)

# Renaming a collection

The first thing we will try to do is rename `posts` to `reddit_posts`.

Note that as far as I can tell, at the current time, there is no way to rename a collection in the web user interface.

Fortunately, since our collection is empty, we can just drop it and recreate it.  

To drop the collection posts, hover over `posts` and you'll see a trash can icon pop up:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152419662-632e4ca0-6b5b-4294-bef7-e9947b1ffe64.png" width="800" />)


Then, click the trash can and a confirmation modal appears. Type in `posts` and click `Drop`

<img alt="" src="https://user-images.githubusercontent.com/1119017/152419763-ef4a07a5-20c1-4c4e-bd8d-1dc8195686ab.png" width="800" />)

That returns us to a state of having no collections, which looks like this:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152419854-6840051e-c57c-4d39-b4e2-1b5b2095a7e8.png" width="800" />)

From here, we'll click `Add your own data` and create two collections: `reddit_posts` and `students`. The user interface
here is a bit tricky, so I'll walk you through it.  First click `Add my own data` which gets us here, where you can fill in `database` and `reddit_posts`

<img alt="" src="https://user-images.githubusercontent.com/1119017/152420104-e0d5bf9f-453c-494b-bd10-cba019e2b96f.png" width="800" />)

That results in this:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152420205-571cb9ce-01e8-493b-90c0-cc465628a5b3.png" width="800" />)


Then, to create the second collection (or additional ones after that), hover over the name `database`, and you'll see a plus sign pop up.  Click that to 
add the second collection.

<img alt="" src="https://user-images.githubusercontent.com/1119017/152420224-7dd408c0-ef0f-421a-bc19-4c4a7f31e532.png" width="800" />)

Enter `students` as the name of the second collection:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152420283-cab197bd-d759-4b9a-9b3b-b07d796f49e3.png" width="800" />)

Now we have a database named `database` and two collections: `reddit_posts` and `students`.  We are ready to start doing Java coding.




# Configuration for a connection to MongoDB


The place that you are supposed to set up Mongo DB Connection URI is in `.env` file (copied from `.env.SAMPLE`) as the value of the variable
`MONGODB_URI`.

Here's where to get the value of `MONGODB_URI`:

In the left hand navigation on the <https://cloud.mongodb.com> site, find `Database` in the left nav, and get to this page:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152425255-6e4eab59-21b1-41cf-98da-980485acd58f.png" width="800" />)

Then, click where it says `Connect`.  That brings up this Modal. Click the "Connect Your Application" link:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152425352-46061aa0-81a6-4f9e-8d2b-0cbca1b57e1b.png" width="800" />)

That brings up this.  *Do not worry about setting the programming language and version*.  
* That matters only if you are looking for example code, and it turns out the code the MongoDB site offers for Java is low level code that is not appropriate for Spring Boot anyway.
* The part that does matter, the connection string, is the same across all programming languages.

<img alt="" src="https://user-images.githubusercontent.com/1119017/152425583-f6cbc7f7-8db0-45b1-bf46-e3fbb5b21486.png" width="800" />)

Copy the connection string, and paste it in as the value for `MONGODB_URI`.  *But you are not finished*.  There is still the step of filling in the password, and replacing the `myFirstDatabase` with the correct name of the database.

```
MONGODB_URI=mongodb+srv://readWrite01:<password>@cluster0.v6z4u.mongodb.net/myFirstDatabase?retryWrites=true&w=majority
```

First, let's deal with the database, since that's easy.  If you called your database `database`, then just change `myFirstDatabase` to `database`, like this:

```
MONGODB_URI=mongodb+srv://readWrite01:<password>@cluster0.v6z4u.mongodb.net/myFirstDatabase?retryWrites=true&w=majority
```

Now, that places where it says `<password>` needs to be replaced with the correct password.  To do this, navigate back to `Database Access` in the left nav:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152426093-6ca3dd27-8067-4d28-89b1-16c1d341ad30.png" width="800" />)

Click `Edit` beside the user you are going to use.  

As an aside: note that you can have multiple users with different privilege levels, so if your application only needs read access to the data, it may be better to configure a read only user for your web app, and the upload data using a different user with a script.  (We'll provide an example of an uploader script in a different article.)  For now, though, we'll use a user with both read and write privileges.

Clicking `Edit` next to a user brings up this:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152426402-1a705f86-daec-4fe9-a5bf-a9d5fb0846d3.png" width="800" />)

Click where it says "Edit password".  That opens up this:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152426476-891c5c8c-eda1-4d1a-846c-c70096c0b666.png" width="800" />)

Note that it is *not possible to look up the password, only to change it.*  So, we are going to autogenerate a new-password, and then
paste it into our `.env` file in place of `password`.  (Note that example I'm using here is a fake one; so don't bother trying to hack with it.)

Click Autogenerate, then Show, so you see something like this:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152426627-3cef0f02-5647-4c75-8f96-4c1fc7c386f4.png" width="800" />)

Now copy the value `BkZGP3TZZJG0dAfE` and paste it into your `.env` file in place of the password.  Do not include the `<>` around `<password>`

* Correct:  `MONGODB_URI=mongodb+srv://readWrite01:BkZGP3TZZJG0dAfE@cluster0.v6z4u.mongodb.net/myFirstDatabase?retryWrites=true&w=majority`
* Incorrect: `MONGODB_URI=mongodb+srv://readWrite01:<BkZGP3TZZJG0dAfE>@cluster0.v6z4u.mongodb.net/myFirstDatabase?retryWrites=true&w=majority`

Now, the part that everyone always forgets:  Do not just click the X or navigate away from the window!  The password is not saved unless you
scroll down to the bottom of the modal and click `Update User`!

<img alt="" src="https://user-images.githubusercontent.com/1119017/152427199-b636b13b-ac41-4dcf-95d0-87d31ea8e459.png" width="800" />)


## But the documentation says `spring.data.mongodb.uri` ?

You may wonder: why `MONGODB_URI` when the Spring Boot documentation (and/or various tutorials) say that it should be set via `spring.data.mongodb.uri`?

The place to set up the connection string is indeed the application property `spring.data.mongodb.uri`; *however*, it is a *bad* idea to hard code
usernames and passwords in the application.property file:

```
spring.data.mongodb.uri=DO-NOT-HARD-CODE-THE-URI-HERE
```

Instead, we set it up to pick up the value from an environment variable `MONGODB_URI` and put in a fake default value that can be used as a fallback so that
the code will at least run to some extent if/when we fail to set a value:

```
spring.data.mongodb.uri=${MONGODB_URI:${env.MONGODB_URI:mongodb+srv://fakeUsername:fakePassword@cluster0.ulqcw.mongodb.net/fakeDatabase?retryWrites=true&w=majority}}
```

This says: try to get a property `MONGODB_URI`; failing that, try to get `MONGODB_URI` from the environment, failing that, use this hard coded fake default.

Note that the application will at least start up with fake values for the username, password, and database, but if the host in the URI does not exist, you
may get a fatal error on startup (i.e. at the `mvn spring-boot:run` stage.)


# Setting up a Document class

A MongoDB document is a representation of a JSON object.  As such, it can be nested arbitrarily deep.

The same is true when setting up a Java object to represent a MongoDB document. 

Suppose we have a simple JSON object, such as the following JSON object representing a student with a name and a perm:

```json
{
   "first_name" : "Chris",
   "last_name" : "Gaucho",
   "perm" : 1234567
}
```

In this case, it is straightforward to make a class `Student.java` that represents objects of this type. But our first step will be to create a directory under `src/main/java/` that is a sibling of our `controllers`, `services`, `entities`, etc. called `documents`, like this:


| Before | After |
|-|-|
| <img alt="" src="https://user-images.githubusercontent.com/1119017/152420561-712a7d15-a367-4622-90eb-ad33c8acd8e0.png" width="800" />) | <img alt="" src="https://user-images.githubusercontent.com/1119017/152420645-96628f71-45b2-4f3d-b029-57c715f3846e.png" width="800" />) |
{:.table .table-sm .table-bordered}


Under that folder, create `Student.java` like this:

```java
package edu.ucsb.cs156.example.documents;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Document(collection = "students")
public class Student {
    @Id
    private String id;

    private String firstName;
    private String lastName;
    private int perm;
}

```

Then, create a folder called `collections`:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152421273-0c11dd49-fb29-4c5f-bb5b-91b2cf9357aa.png" width="800" />)

In that folder, create a file `StudentCollection.java` like this:

```java
package edu.ucsb.cs156.example.collections;

import java.util.Optional;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import edu.ucsb.cs156.example.documents.Student;

@Repository
public interface StudentCollection extends MongoRepository<Student, ObjectId> {
  Optional<Student> findOneByPerm(int perm);
  Optional<Student> findOneByFirstNameAndLastName(String firstName, String lastName);
}
```


Finally, we can create a controller, `StudentsController.java`

```java
package edu.ucsb.cs156.example.controllers;

import edu.ucsb.cs156.example.collections.StudentCollection;
import edu.ucsb.cs156.example.documents.Student;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@Api(description = "Students")
@RequestMapping("/api/students")
@RestController
@Slf4j
public class StudentsController extends ApiController {

    @Autowired
    StudentCollection studentCollection;

    @Autowired
    ObjectMapper mapper;

    @ApiOperation(value = "List all students")
    @PreAuthorize("hasRole('ROLE_USER')")
    @GetMapping("/all")
    public Iterable<Student> allStudents() {
        loggingService.logMethod();
        Iterable<Student> students = studentCollection.findAll();
        return students;
    }

    @ApiOperation(value = "Add a Student to the collection")
    @PreAuthorize("hasRole('ROLE_USER')")
    @PostMapping("/post")
    public Student postStudent(
            @ApiParam("firstName") @RequestParam String firstName,
            @ApiParam("lastName") @RequestParam String lastName,
            @ApiParam("perm") @RequestParam int perm) {
        loggingService.logMethod();

        Student student = new Student();
        student.setFirstName(firstName);
        student.setLastName(lastName);
        student.setPerm(perm);

        // OR

        // Student student = Student.builder()
        //         .firstName(firstName)
        //         .lastName(lastName)
        //         .perm(perm)
        //         .build();

        Student savedStudent = studentCollection.save(student);
        return savedStudent;
    }

}
```

This will give us endpoints that we can test with Swagger:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152430009-460d64ff-5709-4b85-8e70-12890a4175cc.png" width="800" />)

A POST gives us a new Student:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152430358-704024a1-4cc8-4c04-bde1-d9e2c5c9c7da.png" width="800" />)

<img alt="" src="https://user-images.githubusercontent.com/1119017/152430387-1fd51583-9fed-4640-9fe7-4f5253609207.png" width="800" />)


And a GET shows that the student was added to the Collection:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152430425-daa45949-2715-426a-88bf-2e819d80ed58.png" width="800" />)

<img alt="" src="https://user-images.githubusercontent.com/1119017/152430454-9bf32183-93d7-444e-9614-33c80ac71b30.png" width="800" />)

Finally, we can navigate to our Collection on <https://cloud.mongodb.com> and see that the data is in the Collection:

<img alt="" src="https://user-images.githubusercontent.com/1119017/152430567-abb685ab-8fb4-4116-b9cc-be93b187a8a6.png" width="800" />)

# Next steps: A more complex collection

As you can see by the code above, it is relatively straightforward to set up a Document and a Collection for a simple flat JSON object.

However, for simple flat object with no nesting, an SQL database may be a better choice anyway.  The power of MongoDB is really for representing
hierarchical nested JSON data.

So in the next article, we'll look at RedditPosts, which have several layers of complexity, and describe how to set up a Java class hierarchy to 
represent these objects.




