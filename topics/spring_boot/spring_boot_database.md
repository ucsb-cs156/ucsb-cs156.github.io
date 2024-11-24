---
parent: "Spring Boot"
grand_parent: Topics
layout: default
title: "Spring Boot: Database"
description:  "Setting up a new SQL database table"
category_prefix: "Spring Boot: "
indent: true
---

To set up a new SQL database table in Spring Boot, you need to add two files:

* An `@Entity` class.  Each instance of this class represents one row in the database, and the fields in this class are the columns in the database
* A `@Repository` interface, which is the abstraction that represents the actual database table as a whole.  
 
The `@Repository` file is an interface rather than a class, because Spring Boot will *automatically create a class, and an instance of the class for you*.  
It writes most of the code that you need, without you having to do anything other than specify any custom queries you might perform beyond the default
ones.

# The `@Entity` class

Here's an example of a simple `@Entity` class for type `Student` with three attributes, `perm`, `firstName`, `lastName`:

```java
package edu.ucsb.cs156.example.entities;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.AccessLevel;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
@Entity(name = "students")
public class Student {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;
  
  private int perm;
  private String firstName;
  private String lastName;
}
```

As you can see, if your needs are simple, it's pretty simple: just copy this template, and fill in the attributes for the data that you need in the space where this appears:

```java
  private int perm;
  private String firstName;
  private String lastName;
```

# The `@Repository` class

The basic repository class is quite simple. If our `@Entity` class is `Thing`, then the `@Repository` class, at a minimum, looks like this:

```java
@Repository
public interface ThingRepository extends CrudRepository<Thing, Long> {
}
```

Note that in the Spring Data Documentation, this takes this form, where `T` is the type of our entity, and `ID` is the type of our
primary key; in this course, we are always using `Long` as the primary key type unless there is a reason to do otherwise:

```
public interface CrudRepository<T, ID extends Serializable> extends Repository<T, ID> {
}
```

With this basic declaration, you get a lot of query types through inheritance.  

The full list can be found at the [JavaDoc page for CrudRepository](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/repository/CrudRepository.html)

Here is the complete list; here I've gone ahead and substituted `Long` for `ID`, but I've kept `T` for the entity type:


| Method | Explanation |
|--------|-------------|
| `long	count()`  | Returns the number of entities available. |
| `void	delete(T entity)` | Deletes a given entity. |
| `void	deleteAll()` | Deletes all entities managed by the repository.|
| `void	deleteAll(Iterable<? extends T> entities)`  | Deletes the given entities. |
| `void	deleteAllById(Iterable<? extends ID> ids)` | Deletes all instances of the type T with the given IDs. |
| `void	deleteById(ID id)` | Deletes the entity with the given id. |
| `boolean	existsById(ID id)` | Returns whether an entity with the given id exists. |
| `Iterable<T>	findAll()` | Returns all instances of the type. |
| `Iterable<T>	findAllById(Iterable<ID> ids)` | Returns all instances of the type T with the given IDs. |
| `Optional<T>	findById(ID id)` | Retrieves an entity by its id. |
| `<S extends T> S	save(S entity)` | Saves a given entity. |
| `<S extends T> Iterable<S>	saveAll(Iterable<S> entities)` | Saves all given entities. |
{:.table .table-sm .table-striped .table-bordered}

However, you can also add your own methods, as long as:
* The Entity class follows the *Java Bean* naming conventions (which the Lombok `@Data` gives you for free)
  - That basically means: a no-arg constructor, and getters and setters for all attributes.
* The query follows the Spring Boot naming conventions

As an example, if you have a field `private String lastName` in your `@Entity` class for `Thing`, you can define:

```
Iterable<Thing> findByLastName(String lastName);
```

The official documentation has a [section that explains the naming rules](https://docs.spring.io/spring-data/data-jpa/docs/current/reference/html/#jpa.query-methods).

# Special Case: Records "owned" by a user; an intro to *foreign keys*

One special case is when we want to express that certain rows in a database table "belong to" a particular user.

An example occurs in the `todos` table of the example code used in this course.  The idea is that:
* the `todos` table contains all of the todos for all of the users
* each ordinary user can work with only their *own* todos from the table
* an admin user can work with all of the todos in the table

A given is that we already have a `users` table such as this one,  with this `@Entity` class for `User` (shown only in part to save space):

```java
// imports omitted

@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
@Entity(name = "users")
public class User {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;
  private String email;
  private String fullName;
  private String givenName;
  private String familyName;
  private boolean admin;
  // note: some fields omitted to save space
}
```

This means that each user can be identified by their `id`. 
* When this `id` field appears in another table, it is called a *foreign key*.  
* The usual convention is that when the `id` of one table appears in another, we preface it with the name of the table.
* So, the `id` from the `User` entity becomes `user_id` when it appears in another table.

That brings us to to `Todo` entity, which looks like this:

```java
package edu.ucsb.cs156.example.entities;

import javax.persistence.Entity;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity(name = "todos")
public class Todo {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;

  // This establishes that many todos can belong to one user
  // Only the user_id is stored in the table, and through it we
  // can access the user's details

  @ManyToOne
  @JoinColumn(name = "user_id")
  private User user;
  
  private String title;
  private String details;
  private boolean done;
}
```

The important part here is this:

```java
  // This establishes that many todos can belong to one user
  // Only the user_id is stored in the table, and through it we
  // can access the user's details

  @ManyToOne
  @JoinColumn(name = "user_id")
  private User user;
  
```

Some things to notice:
* The `@ManyToOne` annotation indicates that "many todos can belong to one user".
* The `@JoinColumn(name = "user_id") indicates that rather than storing the `User` and their fields directly in this table, we are going to store
  just the `user_id` from the `User` entity, and map that to a `User` by looking up that `user_id` in the `id` column of the `users` table.
* We then use `private User user;` instead of `private Long user_id`; this allows us to directly access fields in the `User` via getters any time
  we have an instance of a `Todo`.  For example, for `Todo t;`, we can access `t.getUser().getFirstName()`.
  
Finally, this way of setting up relationships between entities is not limited to `User`.   We could use it for any kind of relationship among
entities.  

For example a `Course` entity and a `Staff` entity.  The `Staff` entity (representing instructors, TAs, LAs) could have this in the `Staff` entity,
indicating that many different `Staff` entities (an instructor, and multiple TAs and LAs) all belong to the same course.  An entry in the `staff` table
would have a field for `course_id`, which would be the `id` of a row in the `courses` table:

```
  @ManyToOne
  @JoinColumn(name = "course_id")
  private Course course;
```

For more information:
* <https://www.baeldung.com/hibernate-one-to-many>
* <https://www.baeldung.com/jpa-hibernate-associations>
  
# Timestamps on Database Rows

It is possible for Spring Data's JPA to automatically put created at and last modified time stamps on database rows as explained in [this article](https://www.baeldung.com/hibernate-creationtimestamp-updatetimestamp).

Here's how you do it.

1. On your main class (the one that has `SpringApplication.run` in it, and has `@SpringBootApplication` on it), add this annotation:

   [See code in context](https://github.com/ucsb-cs156/proj-happycows/blob/7a5456e61fffafa73a3464eb16360c4aa06cd50f/src/main/java/edu/ucsb/cs156/happiercows/HappierCowsApplication.java#L23)
   ```java
   @EnableJpaAuditing(dateTimeProviderRef = "utcDateTimeProvider")
   ```
   
   Along with a `utcDateTimeProvider` method, as shown in this example from `proj-happycows`: 

   [See code in context](https://github.com/ucsb-cs156/proj-happycows/blob/7a5456e61fffafa73a3464eb16360c4aa06cd50f/src/main/java/edu/ucsb/cs156/happiercows/HappierCowsApplication.java#L60)
   ```java
   @Bean
   public DateTimeProvider utcDateTimeProvider() {
      return () -> {
        ZonedDateTime now = ZonedDateTime.now();
        return Optional.of(now);
      };
   }
   ```
   
2. On your entity class, also add this annotation:

   [See code in context](https://github.com/ucsb-cs156/proj-happycows/blob/7a5456e61fffafa73a3464eb16360c4aa06cd50f/src/main/java/edu/ucsb/cs156/happiercows/entities/jobs/Job.java#L20)
   ```java
   @EntityListeners(AuditingEntityListener.class)
   ```
   

3. On your entity class, add data members like these (the names `createdAt` and `updatedAt` are up to you,
   but the annotations must be as shown here:

   ```
   @CreatedDate
   private LocalDateTime createdAt;
   @LastModifiedDate
   private LocalDateTime updatedAt;
   ```

