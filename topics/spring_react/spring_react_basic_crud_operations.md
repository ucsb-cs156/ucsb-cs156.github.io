---
parent: "Spring/React"
grand_parent: Topics
layout: default
title: "Spring/React: Basic CRUD operations"
description:  "Create/Read/Update/Destroy for an SQL database table"
category_prefix: "Spring React: "
indent: true
---

# {{ page.title }} &mdash; {{ page.description }}

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
 
Here is some example code for integrating the frontend of an create page with the backend, along with explanation. The sample code is 
 [`frontend/src/main/pages/UCSBDates/UCSBDatesCreatePage.js`](https://github.com/ucsb-cs156-s23/STARTER-team03/blob/main/frontend/src/main/pages/UCSBDates/UCSBDatesCreatePage.js) from <https://github.com/ucsb-cs156-s23/STARTER-team03>.
 
The parts that may need some explanation are these:

First, we have this function, which takes an object representing one row in the database (i.e. a newly created object that we want to `POST` to the database) and turns it into an object that represents the parameters we pass to [`axios`](https://axios-http.com/docs/intro), which is the library we use to connect to the backend.

This function typically requires us to specify the url (e.g.`"/api/ucsbdates/post",` , the http method (`POST`), and then an object
that is in the format expected by the backend endpoint.

```js
  const objectToAxiosParams = (ucsbDate) => ({
    url: "/api/ucsbdates/post",
    method: "POST",
    params: {
      quarterYYYYQ: ucsbDate.quarterYYYYQ,
      name: ucsbDate.name,
      localDateTime: ucsbDate.localDateTime
    }
  });
```

The next section of code is a function that is called when the operation is succesful.  In this case, it uses the `react-toastify` library (documented here: <https://fkhadra.github.io/react-toastify/introduction/> ) to put a message on the screen with information to confirm that the add was sucessful.   This isn't always strictly necessary, but it can be helpful to have an indication that the operation worked, especially when debugging.   For real applications, it's up to the application designers whether this is helpful, or distracting.

```js
  const onSuccess = (ucsbDate) => {
    toast(`New ucsbDate Created - id: ${ucsbDate.id} name: ${ucsbDate.name}`);
  }
```

The next section of code is the part that is used to actually do the `POST` operation.  It uses the function `useBackendMutation` which is a wrapper around the `useMutation` function from `react-query`.  

```js
  const mutation = useBackendMutation(
    objectToAxiosParams,
     { onSuccess }, 
     // Stryker disable next-line all : hard to set up test for caching
     ["/api/ucsbdates/all"]
     );
```

`useBackendMutation` takes three parameters:

* `objectToAxiosParams`, which was explained above; but note that we actually *pass the function itself*, not the result of a function call, 
* `useMutationParams`, which is a way of adding parameters to the useMutation call.  
* `queryKey`, with a default value of `null`; this is a list of query keys for `useQuery` that should be invalidated by this mutation. For example, in this case, since we are adding a new record to the `ucsbdates` table, we invalidate the key for any previous `GET` operation to the url `"/api/ucsbdates/all"`.  Failing to do this means the table on the index page may not refresh properly.  Doing this means that the table will do a new `GET` operation and pick up the new record.

The next section of code is this:

```js
  const { isSuccess } = mutation
```

This pulls out the variable `isSuccess` from the return values of `useBackendMutation`; this variable is used in the later block of code:

```js
  if (isSuccess) {
    return <Navigate to="/ucsbdates/list" />
  }
```

This code says that if we've successfully added a new record, we can navigate back to the url shown (which is the URL for the index page.)

Finally, we skipped over this bit:

```
  const onSubmit = async (data) => {
    mutation.mutate(data);
  }
```

This is the function that is called to actually perform the mutation when we click the button; the code that links the button to this function is this:

```js
  <UCSBDateForm submitAction={onSubmit} />
```

### Be careful with the second parameter to `useBackendMutation`

A special note about the second parameter to `useBackendMutation`, which is called `useMutationParams`.  Since this parameter is a javascript object, **it is important to use the correct variable name**.  That's because the syntax:
```js
{onSuccess },
```

Is a shorthand for:
```js
{onSuccess: onSuccess },
```

So, if you need to rename the variable `onSuccess` for any reason (e.g. to `onPostSuccess`, make sure you replace this with:

```js
{onSuccess: onPostSuccess}, // correct
```

and not:

```js
{ onPostSuccess }, // incorrect
```

The return value `mutation` is an object, and is the return value from a call to the [`useMutation` function from `react-query`](https://tanstack.com/query/v4/docs/react/reference/useMutation).

The same advice applies to the left hand side of this assignment:

```
  const { isSuccess } = mutation
```

If you want to call it `foo` instead of `isSuccess`, use:

```
  const { isSuccess: foo } = mutation;  // correct
```

not:

```
  const { foo } = mutation;  // incorrect
```

## Edit page
 
 TODO: fill this in
 
## Details page
 
 TODO: fill this in
