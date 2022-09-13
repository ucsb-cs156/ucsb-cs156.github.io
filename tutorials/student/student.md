---
topic: "Student"
description: "A class for students, and starting point for learning Java, and the Maven-based Java toolchain"
---

<div class="github-preview-only">On website: https://ucsb-cs156.github.io/tutorials/student/</div>


This is a set of tutorial examples of a class to represent a `Student`.  

It illustrates various concepts/techinques of Java Coding (a list of these appears below.)

These examples are intended as support for a course in which there are also reading assignments and lectures; this tutorial is not intended to be a stand-alone curriculum for learning Java.  

Having said that, if you follow the code examples in order, and look up the concepts that are new to you at each step, that will probably go a long way towards learning some important basic concepts of Java programming.


<style>
div.tutorial-table * table { border-collapse: collapse; }
div.tutorial-table * table * th { border: 1px solid black; padding: 4px; }
div.tutorial-table * table * td { border: 1px solid black; padding: 4px; }
</style>

<div class="tutorial-table" data-role="collapsible" data-collapsed="false">
  <h2 markdown="1">`Student` tutorials: table of contents</h2>
  <table class="table table-sm table-striped table-bordered">
   <tr>
           <th>Section</th>
           <th>Code <br>(github repo)</th>
           <th>Topics Covered</th>
   </tr>
   {% for t in site.tutorials %}
       {% if t.topic contains "Student: "%} 
           <tr>
           <td><a href="{{t.url}}">{{ t.topic }}</a></td>
           <td>{% if t.code_repo and t.code_branch %} <a href="{{t.code_repo}}/tree/{{t.code_branch}}">code</a>  {% else %} &nbsp; {% endif %}</td>
           <td>{{t.desc}}</td>
           </tr>
       {% endif %}
   {% endfor %}
  </table>
</div>



<div class="github-preview-only">On website: https://ucsb-cs156.github.io/tutorials/student/</div>
