---
parent: Topics
layout: default
title: "Markdown"
description:  "A simplified syntax to create formatted documents"
---

<style>
div.niceTable table {
   border-collapse: collapse;
}


div.niceTable table * td {
   border: 1px solid black;
   border-collapse: collapse;
   padding: 1em;
}
    
div.niceTable table * th {
   border: 1px solid black;
   border-collapse: collapse;
}
  
</style>


<b>Markdown</b> is an alternative to HTML (Hypertext <b>Markup</b> Language) for producing formatted text, specially for web content.

The chief advantage of Markdown is the simplicity of it's syntax.  As an example, compare the syntax for bulleted lists between HTML and Markdown

<div markdown="1" class="niceTable">

<table>
<tr><th>Desired Result</th><th>HTML syntax</th><th>Markdown syntax</th></tr>
<tr>
<td markdown="1">
* Thing one
* Thing two
* Thing three
</td>
<td markdown="1">
```html
<ul>
  <li>Thing one</li>
  <li>Thing two</li>
  <li>Thing three</li>
</ul>
```
</td>
<td markdown="1">
```markdown
* Thing one
* Thing two
* Thing three
```
</td>
</tr>
</table>

</div>

Or the difference between the syntax for hyperlinks:


<div markdown="1" class="niceTable">

<table>

<tr>
<th>Desired Result</th>
<td markdown="1">
Visit [UC Santa Barbara](https://www.ucsb.edu)
</td>
</tr>

<tr>
<th>HTML syntax</th>
<td markdown="1">
```html
Visit <a href="https://www.ucsb.edu">UC Santa Barbara</a>
```
</td>
</tr>

<tr>
<th>Markdown syntax</th>
<td markdown="1">
```markdown
Visit [UC Santa Barbara](https://www.ucsb.edu)
```
</td>
</tr>

</table>

</div>

A key advantage is for source code.  Suppose you want the following C++ source code to appear on a web page:

<pre>
   cout &lt;&lt; &quot;Hello, World&quot; &lt;&lt; endl;
</pre>


While the `<pre>` tag can be used for source code (e.g. Java, C++, etc.), there is still the problem that many characters have to be escaped.

For example, the following is not legal HTML:

```
<pre>
  cout << "Hello, World" << endl;
</pre>
```

The problems are highlighted here (by the automatic syntax highlighing of Markdown):

```html
<pre>
  cout << "Hello, World" << endl;
</pre>
```

To be strictly compliant HTML, this woudl have to be written as:

```html
<pre>
   cout &lt;&lt; &quot;Hello, World&quot; &lt;&lt; endl;
</pre>
```

That is obviously inconvenient.  Instead, in Markdown, one can simply write:

<pre>
&#96;&#96;&#96;cpp
   cout &lt;&lt; &quot;Hello, World&quot; &lt;&lt; endl;
&#96;&#96;&#96;
</pre>

And get this

```cpp
   cout << "Hello, World" << endl;
```

(Note that many systems that support Markdown processing have built-in syntax highlighting.)


