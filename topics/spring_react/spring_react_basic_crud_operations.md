---
parent: "Spring/React"
grand_parent: Topics
layout: default
title: "Spring/React: Basic CRUD operations"
description:  "Create/Read/Update/Destroy for an SQL database table"
category_prefix: "Spring React: "
indent: true
---

# {{ page.title } &mdash; {{ page.description }}

CRUD refers to Create/Read/Update/Destroy, which are the four basic operations that users need to do on a database table.

Our implementation of the basic CRUD operations includes the following features.  Note that this is the basic version; it may need to be tweaked or customized for particular applications.

* Backend Controller methods to implement api endpoints for:
  - `GET` (read) for the entire colletion 
  - `GET` (read) for a single row (specified by its primary key, usually `id`)
  - `POST` (create) to create a single row
  - `PUT` (update) to update an existing row
  - `DELETE` (destroy) to delete a single row
* Frontend React components for:
  - a form for creating and/or updating a single database row
  - a table for listing either a single row, or a collection of many rows
* Frontend React pages:
  - An **index** page that
    - uses the table component and a backend `GET` endpoint for all records in the table to list the entire table. 
    - has a button at the top of the page that links to the Create page.
    - has a button in each row to navigate to a **details** page for that row
    - has a button in each row to navigate to an **edit** page for that fow
    - has a button in each row that invokes the backend `DELETE` method and then refreshes the page
  - A **create** page that uses the form component and the `POST` endpoint to create a new row
  - An **edit** page that:
    - uses the `GET` endpoint to populate the form component with data
    - allows the user to edit the data
    - submits the updated row with a `PUT` operation to update the data
  - A **details** page that:
    - Uses the `GET` endpoint for a single row to populate the table with a single row to show the data
    - On this page, the detail button should not appear; the edit and delete buttons are nice to have but optional.
 
 # Integration of the Frontend and Backend
 
 ## Index page
 
Here is some example code for integrating the frontend of an index page with the backend, along with explanation. The sample code is 
 [`frontend/src/main/pages/UCSBDates/UCSBDatesIndexPage.js`](https://github.com/ucsb-cs156-s23/STARTER-team03/blob/main/frontend/src/main/pages/UCSBDates/UCSBDatesIndexPage.js) from <https://github.com/ucsb-cs156-s23/STARTER-team03>.
 
The parts that may need some explanation are these:

```js
  const currentUser = useCurrentUser();
```

This gets an object representing the current user.  This object can be used to determine:
* whether the user is logged in or not
* whether the user is, or is not, an admin (or has any other application specific roles)

That object can be passed into the table component, as shown here, so that the table component can hide or show specific columns:

```jsx
  <UCSBDatesTable dates={dates} currentUser={currentUser} />
```

You can look inside the code for [`UCSBDatesTable`](https://github.com/ucsb-cs156-s23/STARTER-team03/blob/main/frontend/src/main/components/UCSBDates/UCSBDatesTable.js) to see how `currentUser` is used to hide or show columns based on whether the user is, or is not, an admin.   

The next code that may need some explanation is this.

```js
 const { data: dates, error: _error, status: _status } =
    useBackend(
      // Stryker disable next-line all : don't test internal caching of React Query
      ["/api/ucsbdates/all"],
      { method: "GET", url: "/api/ucsbdates/all" },
      []
    );
```

This code invokes a hook called `useBackend` that is custom for UCSB's CMPSC 156 course, and it a a wrapper around three methods from
the library `react-query` (documented here: <https://tanstack.com/query/latest>) namely: `useQuery`, `useMutation` and `useQueryClient`).

There are three parameters to useBackend:
* `queryKey` (e.g. `["/api/ucsbdates/all"]` in the example above)
* `axiosParameters` (e.g. ` { method: "GET", url: "/api/ucsbdates/all" },` in the example above)
* `initialData` (e.g. ` []` in the example above)

Here's what each of them do:

* `queryKey` is a list of keys to a cache that is used to store the results of the query to the backend.  Query results are cached and reused until the key is invalidated, e.g. by an operation such as `POST`, `PUT` or `DELETE` that might affect the results of the query.  The idea is that mutations to the table should specify this key if they would cause the query to need to be performed again. We'll see examples of this when we discuss the implementation of Create, Update and Destroy operations.
* `axiosParameters` is an object passed to the `axios` library (documented here: <https://axios-http.com/docs/intro> ) that is used to retrieve data from the backend.  This is where we specify the http method (e.g. `GET`) and the url ( e.g.  "/api/ucsbdates/all").  Typically `useBackend` is used only for `GET` operations; for `POST`, `PUT` or `DELETE` we use a different hook called `useBackendMutation` which we'll cover below.
* `initialData` specifies what should be used initially as the result of the query until the api call completes.  For example, in the case of a table that shows all of the database records, the initial value is an empty array.  That will be replaced by an array containing one object for each row when the api call completes.

The lefthand side of the call to `useBackend` uses Javascript destructuring; the result that is returned is an object with keys as defined by the specification for the return value of [`useQuery` from `react-query`](https://tanstack.com/query/v4/docs/react/reference/useQuery).  In this example, we have:

```js
 const { data: dates, error: _error, status: _status } =
```

This shows that the data is being placed into a variable called `dates`, and information on errors and status is placed into variables `_error` and `_status`, with the leading underscores indicating that we are not currently using the values of those variables.

The value that is returned, `dates` is passed into the component to render the table:

```
   <UCSBDatesTable dates={dates} currentUser={currentUser} />
```

A common error is getting this variable incorrect due to copy/paste errors from example code (e.g. forgetting to change `dates` to `hotels`).

 ## Create page
 
 TODO: fill this in

 ## Edit page
 
 TODO: fill this in
 
 ## Details page
 
 TODO: fill this in
