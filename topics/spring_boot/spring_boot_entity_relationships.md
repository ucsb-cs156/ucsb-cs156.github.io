---
parent: "Spring Boot"
grand_parent: Topics
layout: default
title: "Spring Boot: Entity Relationships"
description:  "One to One, One to Many, Many to One, Many to Many, and Hibernate"
---

## Getting Started

In Spring Boot, Entities can have relationships to one another.

* One to One
* One to Many
* Many to One
* Many to Many

These are representations of the many different sorts of foreign key database representations. A many-to-many represents a join table, whereas a one-to-one and one-to-many (and its inverse) represent two tables' relation of foreign keys to each other. A one-to-one means that one row has one mapping to one row in another table. One to many means that many rows in a different table have a foreign key that points to one row. In JPA, they are usually arranged like this:
```java
public class Course{
@OneToMany(mappedBy="course")
Set<Student> students;
}

public class Student{
@JoinColumn(name="course_id")
@ManyToOne
Course course;
}
```

Let's go through what these mean and how these are reflected in the actual database. Even though it's listed second, let's start with `Student`. On it's field `course`, it has a couple of annotations:
* `JoinColumn`: This is a JPA annotation that informs the provider that an actual column in the database is in fact a reference to another table. Specifically, it says the column named "course_id" in the `Student` table is a foreign key.
* `ManyToOne`: This annotation informs JPA that there are a number of students that map to one course.

`Course`, on the other hand, only has one annotation: `OneToMany`. This informs the JPA provider that it should go out and look for a field in the class the annotation is referencing. It tells it that the id of the course in question will be relating to this field

https://www.baeldung.com/jpa-hibernate-associations

## Best Practices

* If you are modifying child objects (ie, in the earlier example, a student), you should set the `cascadeType` in `@OneToMany` -- Usually, we use `CascadeType.ALL` to allow saving child objects, modifying child objects, and removing all child objects when the parent is deleted. However, ensure you know the proper use case for your case.
* According to the [Hibernate 6.6.8 user guide](https://docs.hibernate.org/orm/6.6/userguide/html_single/#associations-many-to-one), it is best practice to keep both sides of the object in sync -- if you are deleting a child object, you should also remove it from the parents' collection.
* The deletion of objects should be done inside of a method that is both a) inside of the spring context and b) inside of a method marked `@Transactional` (or called from a method that fulfills both of those)
  * This is due to the fact that when you actually retrieve an object from a repository, Hibernate creates a "session" and builds an object graph of how the retrieved values are related. Normally, Spring Data JPA will simply close this session immediately. As a result, when you try to delete these objects (especially child objects), Hibernate is unsure of how they relate. Without an object graph, it takes the safe approach, and takes no action.
  * Inside of an `@Transactional` method, however, this session remains open along with Hibernate's constructed object graph. As a result, when the object is retrieved, Hibernate knows what to delete. However, make sure you still manage the object's relationships, otherwise it can still behave unpredictably.
  * Additionally, you cannot try to delete an object that has not been retrieved within the `@Transactional` boundary -- if you retrieve the object and try to delete it, it will be outside of Hibernate's object graph and take no action.
* Object relations should be excluded from hashCode and equals. Without doing so, you are liable to create a loop (ie, course references student and student references back to course) while testing that will cause a stack overflow.
* If your object is owned by one parent that fully controls it's lifecycle, consider adding `orphanRemoval = true` to the `OneToMany` side. This will allow you to simply remove the object from the parent's collection and Hibernate will figure out the rest (as long as you're inside a transaction).

##  `@ToString.Exclude`
When creating an object, Lombok will automatically generate a `toString` method that includes every object property. As a result, when implementing `ManyToOne` and `OneToMany` relationships, the `toString` method of an object can cause an infinite recursion. Because these are usually for log purposes, it is likely unnecessary to include the linked entity files in the log output. As a result, we instruct Lombok to exclude these properties from the toString via `@ToString.Exclude`.

##  `@Fetch(FetchMode.JOIN)`
When creating an `SQL` query to retrieve entities from a database, the Hibernate API does not include linked objects by default. The property is only loaded once it has reason to, like when the property is called. As a result, by then the session is usually closed, and Hibernate will throw an error. So, we instruct Hibernate to retreive the associated objects at the same time as the main entity with the SQL `JOIN` command. 

More information can be found here: https://www.baeldung.com/hibernate-fetchmode

Interested and need more information? See [Vlad Mihalcea's OneToMany guide](https://vladmihalcea.com/the-best-way-to-map-a-onetomany-association-with-jpa-and-hibernate/)
