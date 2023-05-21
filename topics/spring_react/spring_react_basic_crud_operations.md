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
 
 ## Create page

 ## Edit page
 
 ## Details page
