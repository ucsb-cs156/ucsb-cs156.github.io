---
parent: Topics
layout: default
title: APIs
description: Application Programming Interfaces
has_children: true
---

# {{page.title}}

The term *Application Programming Interface* or *API* is used in various ways.  Here are some meanings of API that arise in this course:

1. A collection of public methods and properties of some specific collection of classes/objects 
   - e.g. the standard library that comes with Java is an API, as documented here:  
   
     [Java® Platform, Standard Edition & Java Development Kit
Version 17 API Specification](https://docs.oracle.com/en/java/javase/17/docs/api/index.html)
   - the classes/objects/methods that are part of Spring Boot, as documented here:  
   
     [Spring Boot 2.6.2 API](https://docs.spring.io/spring-boot/docs/current/api/)
3. A publically available web service that can be used to exchange messages that retrieve or update information in another application.
  - Sometimes such services are called RESTful APIs, though this term has a very specific meaning that doesn't really apply to all such APIs.
  - Examples: [NOAA API](https://www.ncdc.noaa.gov/cdo-web/webservices/v2), [GitHub API](https://docs.github.com/en/rest), [UCSB APIs](https://developer.ucsb.edu/apis)
4. The endpoints exposed in the backend of a web application that the front end communicates with (this is a special case of meaning 2 above.).  These APIs
   can be documented and tested using Swagger.

## Examples in course assignments

The assignment [team01 from w22](https://ucsb-cs156.github.io/w22/lab/team01/) deals with creating a 
backend only web-application that involves *all three definitions of APIs*:

* Exposes an API (definition 3 above) that is specified in the assignment, and developed by the team.
* Uses various public APIs (definition 2 above) to obtain the information that the backend makes available.
* Makes uses of many features from the Java Platform, Spring Boot, and other libraries (defintion 1 above.)

## Lists of APIs (definition 2)

These websites advertise lists of free/open APIs (no authentication/payment needed).  These may be good bases for future assignments and/or project ideas:

* <https://apipheny.io/free-api/>
* <https://mixedanalytics.com/blog/list-actually-free-open-no-auth-needed-apis/>

Here are some other list of APIs that may be of interest (note that these are not necessarily free, and/or may require authentication)

* List of APIs for academic citations: 
  * [List from UC Berkeley Library](https://guides.lib.berkeley.edu/information-studies/apis)  
  * [List from MIT Library](https://libguides.mit.edu/comptools) 

