---
parent: Axios
grand_parent: Topics
layout: default
title: "The Axios-Mock-Adapter: Best Practices"
description:  "Using the axios-mock-adapter"
---

# {{page.title}}
The `axios-mock-adapter` is a package used in React to mock Axios calls to elsewhere, usually the backend. It is commonly seen in many pages and tables in CS156. Over time, our use of the package
and our best practices have evolved, so examples seen in the codebase may not conform to current standards. It operates like a REST api, and can mock `GET`, `PUT`, `DELETE`, and `POST` calls, as well as
mocking the responses.

## Best Practices
There are a couple of ways to use AxiosMockAdapters and Jest/Vitest mocks in general. The most straightforward way is to declare it as a const at the top of the file like so:
```javascript
const axiosMock = new AxiosMockAdapter(axios);
```

Then, all you have to do is place the following snippet in a beforeEach for each block (appropriately):
```javascript
beforeEach(() => {
  axiosMock.reset();
  axiosMock.resetHistory();
});
```

**This way is recommended because it is the easiest way to do it. The mock is cleared prior to each test, ensuring that though they use the same mock, there is no shared history.**

Alternately, if only one test requires a mock, you can do the following:
1. Declare the mock at the beginning of the test:
```javascript
const axiosMock = new AxiosMockAdapter(axios);
```

2. At the end of the test, remove the mock entirely:
```javascript
axiosMock.restore();
```

You can also do the the same if only a single describe block requires the mock, however you also will need to clear the mock before each test, like above:
```javascript
beforeEach(() => {
  axiosMock.reset();
  axiosMock.resetHistory();
});
```

<details markdown="1">
<summary>
If you're interested in why these are best practices, click here.
</summary>
In Jest and Vitest (as it's drop-in replacement), mocks are something called "hoisted". Essentially, when you create a mock of something, the declaration of that mock is placed at the top of the file 
(credit to [https://dev.to/jobber/serious-jest-making-sense-of-hoisting-253i](https://dev.to/jobber/serious-jest-making-sense-of-hoisting-253i) for the explanation of hoisting).

As a result, if your mock is not properly restored (had the mock removed) at the end of whatever context it is operating in, it can interfere with other mocks of the same file. There will be two 
mocks both attempting to do the same thing, and it's a tossup for which one will come out on top, resulting in flaky testing.
</details>
