---
parent: Topics
layout: default
title: "Testing: React"
description:  "How to use Jest and React Testing Library for various scenarios"
category_prefix: "Testing: "
indent: true
---

# Testing for presence of a link

Here's an example:

```javascript
 test("Links are correct", () => {
    const { getByText } = render(<AppFooter />);
    expect(getByText('CMPSC 156').closest('a')).toHaveAttribute('href', 'https://ucsb-cs156.github.io')
    expect(getByText('UCSB').closest('a')).toHaveAttribute('href', 'https://ucsb.edu')
    expect(getByText('GitHub').closest('a')).toHaveAttribute('href', 'https://github.com/ucsb-cs156-w21/proj-ucsb-courses-search')
  });
```


