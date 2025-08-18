---
parent: Strategies
layout: default
title: Design
description:  "General design principles"
---

# {{page.title}} - {{page.description}}

This covers some high level design principles that don't seem to fit anywhere else.

# Sorting/Filtering in the backend is better than Sorting/Filtering in the Frontend

If you have a page where you are presenting information that always needs to be presented to the user initially
in a certain order, you have two choices:

* Sort/filter the data in the backend at the API endpoint
* Sort/filter the data on the frontend

It will almost always be a better choice to sort the data in the backend.

* It's typically easier to code and test.  
* It's typically faster, performance wise

You have two choices in the backend:

### Choice 1: Let the database do the sorting/filtering

This is almost always the better option when it's possible:  For example, consider this [example PR from proj-dining](https://github.com/ucsb-cs156/proj-dining/pull/76/files)
 
**Moving Filtering to backend**:

Before:
```java
 Iterable<Review> reviews = reviewRepository.findAll();
```

After:
```java
 Iterable<Review> reviews = reviewRepository.findByItemAndStatus(item, ModerationStatus.APPROVED);
```

This eliminates the need for frontend filters such as:

```js
const filteredReviews =
    reviews?.filter((review) => review.status === "AWAITING_REVIEW") || [];
```
or
```
const filteredReviews =
    reviews?.filter((review) => review.item.id === Number(itemid)) || [];
```


**For sorting:**

Consider this example from proj-courses:

Before:
```java

```

After: 

```java

```



### Choice 2: Do it with JJava collection utilities]


Sorting of Java Collections is described in [this article on the CS156 website](https://ucsb-cs156.github.io/topics/java/java_sorting.html#how-to-sort-an-arrayliststring).

Here's an example from proj-courses:
```java
    courseResults.sort(new ConvertedSection.ConvertedSectionSortDescendingByQuarterComparator());
```

A few things to watch out for:
* Is this backend endpoint used by *only one page* in the app (which means you can sort any way you please for that page), or *multiple pages in the app*

### If you must do it in the frontend, use React-Table

If you **have** to do it in the frontend, you can do it with [React-Table](https://tanstack.com/table/latest/docs/guide/sorting).

Here's an example of sorting a table descending by it's id from a version of JobsTable (before we refactored it to sort on the backend):

```js
 const sortByIdDescending = {
    sorting: [
      {
        id: "id",
        desc: true, // sort by name in descending order by default
      },
    ],
  };

  return (
    <OurTable
      data={jobs}
      columns={columns}
      testid={testid}
      initialState={sortByIdDescending}
    />
  );
```

But then you have to cover it in tests: for example:

```js
    // Check that rows are sorted by id in descending order
    const rows = screen.getAllByRole("row");
    expect(rows).toHaveLength(7); // 6 jobs + 1 header row
    expect(rows[1]).toHaveTextContent("6");
    expect(rows[2]).toHaveTextContent("5");
    expect(rows[3]).toHaveTextContent("4");
    expect(rows[4]).toHaveTextContent("3");
    expect(rows[5]).toHaveTextContent("2");
    expect(rows[6]).toHaveTextContent("1");
```
