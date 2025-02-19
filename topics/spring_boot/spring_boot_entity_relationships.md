---
parent: "Spring Boot"
grand_parent: Topics
layout: default
title: "Spring Boot: Entity Relationships"
description:  "One to One, One to Many, Many to One, Many to Many"
---

In Spring Boot, Entities can have relationships to one another.

* One to One
* One to Many
* Many to One
* Many to Many

You can learn more about that here:

https://www.baeldung.com/jpa-hibernate-associations

There are also additional considerations that you may need to take into account when setting up relationships of this type.

## `@JsonIdentityInfo`
Creating entity relationships that involve both a `@ManyToOne` and a `@OneToMany` relationship can cause a loop when serializing an entity. The `JacksonObjectMapper` has several strategies to mitigate this, one of which is the `@JsonIdentityInfo` annotation.

`@JsonIdentityInfo` uses a strategy of identifying individual instances of an object, and replacing repeats with the id of the object. It has several required parameters: `generator` and `property`. First, `property` tells Jackson which property can be used to identify copies of an object: since it is unique, it knows every copy of the object with that value is the same. When it comes across a new instance of an object, it gives it an ID based on the generator property specified. Usually, we use `ObjectIdGenerators.PropertyGenerator.class`. Now, when the object mapper encounters repeats, it will replace it with it's Jackson ID. An example of a `JsonIdentityInfo` annotation looks like this:

```java
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
```

For example, `proj-dining` has a `Review` and a `MenuItem`. Each review has an associated Menu Item, and each Menu Item has a list of reviews associated with it. They are shown below (consolidated for brevity):
```java
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String comments;

    @ManyToOne
    @JoinColumn(name = "item_id", nullable = false)
    private MenuItem item;
}
```

```java
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class MenuItem {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;

  private String name;

  @ToString.Exclude
  @OneToMany(mappedBy = "item")
  @Fetch(FetchMode.JOIN)
  private List<Review> reviews;
}
```

With the annotations attached, let's say we have two Menu Items. There's Menu Item 1 with id 7 and two reviews, and Menu Item 2 with id 20 and two reviews. With the annotations, the output of the two Menu Items will look like this:
```json
[{
  "id" : 7,
  "name": "Pancakes"
  "reviews": [{
      "id": 2,
      "comments": "tastes interesting",
      "menuItem": [1]
    },
    {
      "id": 3,
      "comments": "tastes good",
      "menuItem": [1]
    }
  ]
},
{
  "id" : 20,
  "name": "Eggs"
  "reviews": [{
      "id": 28,
      "comments": "tastes odd",
      "menuItem": [2]
    },
    {
      "id": 62,
      "comments": "I'm not sure about this one",
      "menuItem": [2]
    }
  ]
}]
```

Other strategies for mitigating ObjectMapper loops can be found here: https://www.baeldung.com/jackson-bidirectional-relationships-and-infinite-recursion#bd-json-identity-info

##  `@ToString.Exclude`
When creating an object, Lombok will automatically generate a `toString` method that includes every object property. As a result, when implementing `ManyToOne` and `OneToMany` relationships, the `toString` method of an object can cause an infinite recursion. Because these are usually for log purposes, it is likely unnecessary to include the linked entity files in the log output. As a result, we instruct Lombok to exclude these properties from the toString via `@ToString.Exclude`.

##  `@Fetch(FetchMode.JOIN)`
When creating an `SQL` query to retrieve entities from a database, the Hibernate API does not include linked objects by default. The property is only loaded once it has reason to, like when the property is called. As a result, by then the session is usually closed, and Hibernate will throw an error. So, we instruct Hibernate to retreive the associated objects at the same time as the main entity with the SQL `JOIN` command. 

More information can be found here: https://www.baeldung.com/hibernate-fetchmode
