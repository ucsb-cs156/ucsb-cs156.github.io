---
parent: Topics
layout: default
title: "React: Router"
description:  "Using React Router in a spring/react app"
category_prefix: "React: "
indent: true
---

We show how to use React Router along with Spring in this demo repo:
* <https://github.com/ucsb-cs156-f20/demo-spring-react-minimal>

In our projects, we typically put the React Router code into a file called `App.js`, which represents the 
"main" file for the user interface of the application.

Here is an excerpt of that code.  
```javascript
return (
    <div className="App">
      <AppNavbar />
      <Container className="flex-grow-1 mt-5">
        <Switch>
          <Route path="/" exact component={Home} />
          <PrivateRoute path="/profile" component={Profile} />
          <AuthorizedRoute path="/admin" component={Admin} authorizedRoles={["admin"]}/>
          <Route path="/about" component={About} />
        </Switch>
      </Container>
      <AppFooter />
    </div>
  );
```

As you can see, there are three types of routes shown:

* `Route` does not require you to be logged in
* `PrivateRoute` requires you to be logged in
* `AuthorizedRoute` requires you to be logged in with a specific role

Here's some more detail on each of these:

`<Route ... />` does not require you to be logged in; these routes are always available.  Use this for routes to read-only views of public information.

`<PrivateRoute ... />`requires the user to be logged in, but with no particular role.   Anyone on the internet that has a Google account (assuming
  the app uses Google as the souce of OAuth info) would be able to access these routes.

`<AuthorizedRoute ... />`requires the user to be logged in with a specific role (e.g. `member`, `admin`).  

* Use this with `member` when you want to restrict the users
  based on application-specific notion of *member* (e.g. they have a UCSB email address, or their email appears in a database table/ or file of "members").
* Use this with `admin` for functions that should be restricted to a very small number of admin users.  Initial admins may be defined
  in an `.properties` value (e.g. `secrets-localhost.properties`); these might be supplemented by admins in an admin database table.
    
    
