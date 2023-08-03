---
parent: Storybook
grand_parent: Topics
layout: default
title: Mocking APIs
description:  "Mocking the backend for a React component that expects one"
---

Sometimes you may have a React component in your storybook that make calls to a backend API, and will not function properly if that API
is unreachable.

Just as we mock backend API endpoints in unit tests for React components, we can do the same in React Storybook.

# Using Axios

* <https://rafaelrozon.medium.com/mock-axios-storybook-72404b1d427b>

# Other approaches

Here are some articles on how to do it in various ways:

Using `storybook-addon-mock`
* <https://storybook.js.org/addons/storybook-addon-mock> 

Using `msw` (Mock Service Worker) addon:
* <https://daily-dev-tips.com/posts/storybook-mocking-api-calls/> 
* <https://www.thisdot.co/blog/mocking-api-on-storybook-using-msw/>
* <https://blog.logrocket.com/using-storybook-and-mock-service-worker-for-mocked-api-responses/>
* <https://itnext.io/api-mocking-in-unit-test-and-storybook-a0e774f7296> (also covers two other options)

Using `MockResolver`:
* <https://resthooks.io/docs/guides/storybook>

Using `FetchMock`:
* <https://www.talentica.com/blogs/implementing-mock-api-through-storybook-with-fetch-mock/>
