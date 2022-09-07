---
parent: Topics
layout: default
title: "MongoDB: Spring Boot - Nested Document"
description:  "Creating a document class for nested JSON"
category_prefix	: "MongoDB: "
indent: true
---

This article assumes you've already read through these first:

* [MongoDB: New Database](https://ucsb-cs156.github.io/topics/mongodb_new_database/) which covers setting up a MongoDB database at <https://cloud.mongodb.com>
* [MongoDB: Spring Boot - Basic Collection](https://ucsb-cs156.github.io/topics/mongodb_new_database/) which covers the basics of setting up a Document class, Collection class, and controller actions for a simple MongoDB collection where the JSON objects are flat, i.e. all values at the top level of the object are simple scalar values: numbers, strings, and booleans.

In particular, the previous article, [MongoDB: Spring Boot - Basic Collection](https://ucsb-cs156.github.io/topics/mongodb_new_database/), covered how
to set up a document class for JSON objects that look like one, representing a student:

```json
{
  "perm": 1234567,
  "firstName" : "Chris",
  "lastName" : "Gaucho"
}
```

And the Java class to represent this was quite simple:

```
package edu.ucsb.cs156.example.documents;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Document(collection = "students")
public class Student {
    @Id
    private String id;

    private String firstName;
    private String lastName;
    private int perm;
}
```

But, what if we have a far more complex object?

As an example, consider the objects used to represent Reddit posts.  You can see some live by visiting this link:

* <https://www.reddit.com/r/UCSantaBarbara/.json>

In fact, you can pretty much add `.json` to the end of just about any page on Reddit, and get a version of that page rendered in JSON syntax.

Examining some code for Reddit posts, we find it has this structure:

At the top level, we have an object with two keys, `kind` and `data`.  But `data` is itself an object.
```json
{
  "kind" : "Listing",
  "data" : { … }
}
```

Under `data` we have another object:

```json
{ 
  "kind" : "Listing",
  "data" : {
    "after"	: "t3_slh2js",
    "dist" : 	25,
    "modhash" :	"",
    "geo_filter" :	null,
    "children" :	[…],
    "before :	null
  }
}
```

And under `children` we have an array.  Here's what the content of that array look like.  There are 25 elements indexed 0..24,
each of which is an object with `kind` of `"t3"` and a `data` object.  (Incidentally, if you are wondering what the `t3` stands for, you can
consult the [Reddit API Documentation](https://www.reddit.com/dev/api/), but the short version is: 

| Type | Explanation |
|------|-------------|
|`t1_` | Comment |
|`t2_` | Account |
|`t3_` | Link |
|`t4_` | 	Message | 
|`t5_` | Subreddit |
|`t6_` | Award |
{:.table .table-sm .table-striped .table-bordered}


```json
[
  { 
    "kind": "t3",
    "data": { … }
  },
  { 
    "kind": "t3",
    "data": { … }
  }
]
```

Under the `data` object, we finally see an object representing a single Reddit post, like this one.  It is huge!  Scroll on through, and then 
after the listing, we'll describe how we can simplify things.

```json
{
    "kind": "t3",
    "data": {
        "approved_at_utc": null,
        "subreddit": "UCSantaBarbara",
        "selftext": "I keep weaving in and out existential dread,\n\nWhat am I doing? Where am I going? Tomorrow? Today?\n\nMy teeth are starting to crack as my jaw clenches, forcing another smile.\n\nI spend my weekends on the top floor of the library combing through books hoping to the find the answer.\n\nPre-established groups marked by their tightened blonde buns strapped to their scalps, like soldiers reluctantly obeying orders.\n\nI know I am not one of them as I disappear behind them, I go unnoticed.\n\nMaybe that is what I want, to stand on my own and declare independence.\n\nBut when I retreat back to my room and the door closes,\n\nI only hear my thoughts scraping on the walls trying to get out.",
        "author_fullname": "t2_imwkb1fa",
        "saved": false,
        "mod_reason_title": null,
        "gilded": 0,
        "clicked": false,
        "title": "College Student Blues",
        "link_flair_richtext": [
            {
                "e": "text",
                "t": "Social Life"
            }
        ],
        "subreddit_name_prefixed": "r/UCSantaBarbara",
        "hidden": false,
        "pwls": 6,
        "link_flair_css_class": "",
        "downs": 0,
        "thumbnail_height": null,
        "top_awarded_type": null,
        "hide_score": false,
        "name": "t3_sli4ob",
        "quarantine": false,
        "link_flair_text_color": "light",
        "upvote_ratio": 0.85,
        "author_flair_background_color": null,
        "subreddit_type": "public",
        "ups": 47,
        "total_awards_received": 0,
        "media_embed": {},
        "thumbnail_width": null,
        "author_flair_template_id": null,
        "is_original_content": false,
        "user_reports": [],
        "secure_media": null,
        "is_reddit_media_domain": false,
        "is_meta": false,
        "category": null,
        "secure_media_embed": {},
        "link_flair_text": "Social Life",
        "can_mod_post": false,
        "score": 47,
        "approved_by": null,
        "is_created_from_ads_ui": false,
        "author_premium": false,
        "thumbnail": "self",
        "edited": 1644182453.0,
        "author_flair_css_class": null,
        "author_flair_richtext": [],
        "gildings": {},
        "content_categories": null,
        "is_self": true,
        "mod_note": null,
        "created": 1644098859.0,
        "link_flair_type": "richtext",
        "wls": 6,
        "removed_by_category": null,
        "banned_by": null,
        "author_flair_type": "text",
        "domain": "self.UCSantaBarbara",
        "allow_live_comments": false,
        "selftext_html": "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;I keep weaving in and out existential dread,&lt;/p&gt;\n\n&lt;p&gt;What am I doing? Where am I going? Tomorrow? Today?&lt;/p&gt;\n\n&lt;p&gt;My teeth are starting to crack as my jaw clenches, forcing another smile.&lt;/p&gt;\n\n&lt;p&gt;I spend my weekends on the top floor of the library combing through books hoping to the find the answer.&lt;/p&gt;\n\n&lt;p&gt;Pre-established groups marked by their tightened blonde buns strapped to their scalps, like soldiers reluctantly obeying orders.&lt;/p&gt;\n\n&lt;p&gt;I know I am not one of them as I disappear behind them, I go unnoticed.&lt;/p&gt;\n\n&lt;p&gt;Maybe that is what I want, to stand on my own and declare independence.&lt;/p&gt;\n\n&lt;p&gt;But when I retreat back to my room and the door closes,&lt;/p&gt;\n\n&lt;p&gt;I only hear my thoughts scraping on the walls trying to get out.&lt;/p&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;",
        "likes": null,
        "suggested_sort": null,
        "banned_at_utc": null,
        "view_count": null,
        "archived": false,
        "no_follow": false,
        "is_crosspostable": false,
        "pinned": false,
        "over_18": false,
        "all_awardings": [],
        "awarders": [],
        "media_only": false,
        "link_flair_template_id": "e727032a-d9b8-11e9-bfdc-0eb22f89ee36",
        "can_gild": false,
        "spoiler": false,
        "locked": false,
        "author_flair_text": null,
        "treatment_tags": [],
        "visited": false,
        "removed_by": null,
        "num_reports": null,
        "distinguished": null,
        "subreddit_id": "t5_2shs9",
        "author_is_blocked": false,
        "mod_reason_by": null,
        "removal_reason": null,
        "link_flair_background_color": "#003660",
        "id": "sli4ob",
        "is_robot_indexable": true,
        "report_reasons": null,
        "author": "Educational-Yak-6279",
        "discussion_type": null,
        "num_comments": 7,
        "send_replies": true,
        "whitelist_status": "all_ads",
        "contest_mode": false,
        "mod_reports": [],
        "author_patreon_flair": false,
        "author_flair_text_color": null,
        "permalink": "/r/UCSantaBarbara/comments/sli4ob/college_student_blues/",
        "parent_whitelist_status": "all_ads",
        "stickied": false,
        "url": "https://www.reddit.com/r/UCSantaBarbara/comments/sli4ob/college_student_blues/",
        "subreddit_subscribers": 26873,
        "created_utc": 1644098859.0,
        "num_crossposts": 0,
        "media": null,
        "is_video": false
    }
}
```   

So, what do we we with this?

Here's how we tackle it.  Fortunately
* We *do not* have to represnent *every* field in the JSON in our Java code.
* We *only* need to represent the fields that we actually care about storing.

Furthermore, the initial structure of the JSON does not necessarily have to be the way that we store this in the MongoDB collection.  We may decide,
for example, that we want to store a collection of posts.  The outer wrapper of this JSON is mainly concerned with how we navigate through a collection
of posts, one page at a time.  However, we can decide that we want our collection to be at the level of an individual RedditPost.

On the other hand, we do also want to show how a MongoDB document can have nested parts, so we'll include a representation of this nested field:

```json
       "link_flair_richtext": [
            {
                "e": "text",
                "t": "Social Life"
            }
        ],
```

We need to start bottom up, so we'll begin by representing a `flair` as an object with two fields, `e` and `t`, both of type `String`.   We can define a simple "plain old Java class" using Lombok, called `RedditFlair`, like this.

Note that we are using Lombok annotations (e.g. `@Data`, `@NoArgsConstructor` `@AllArgsConstructor` and `@Builder` to avoid the tedious
work of writing getters, setters, contructors, `toString`, `equals` and `hashCode`.   But we wouldn't have to: we could leave those annotations off
and just make this a simple Plain Old Java Object (POJO).

We put this class in the `documents` package because we are going to
use it to build up a document (bottom up), even though strictly speaking, this will not be a document class.

```java
package edu.ucsb.cs156.example.documents;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RedditFlair {
    private String e;
    private String t;
}
```

Note that the field names `e` and `t` are not very descriptive.  There may be a temptation to replace these with something more meaningful.  *Don't*.  We are going to rely on a package called Jackson that automatically maps JSON objects to Java objects by matching up their field names.   So, as much as possible, we want our JSON field names and our Java field names to match exactly.  

Of course, there could be a problem if one of the fields in our JSON happens to be a Java keyword such as `class` or `for`; in that case, there are workarounds.  But let's focus on the simple case for now.

With this class in place, we can turn to the large listing for our `RedditPost`, and discuss what fields we are interested in.  Let's suppose that we
are interested in these:


So, for example, suppose that we only care about a few fields in the post.  Let's assume these are:

| Field name | Type | Explanation |
|------------|------|-------------|
| `id` | `String` | Identifier for this post on reddit (e.g. `li4ob`) |
| `subreddit` | `String` | Subreddit where post appeared, e.g. `UCSantaBarbara` |
| `selftext` | `String` | The text of the post in plain text |
| `selftext_html` | `String` | The text of the post, formatted in HTML |
| `title` | `String` | Title of the post |
| `author` | `String` | The reddit username that authored the post |
| `url` | `String` | Url of the post on Reddit |
| `link_flair_richtext` | `List<RedditFlair>` | An array of objects, each of which has fields `e` and `t` in it, representing flair (tags on posts) |
{:.table .table-sm .table-striped .table-bordered}


So our next move is to make a simple Java class that represents an object with these attributes, as shown below.    Note that since `link_flair_richtext` is an array in the JSON, where each element in the array is like the `RedditFlair` class we made, we make it a `java.util.List<RedditFlair>` in the Java class, 

Since this class, `RedditPost` is the one that will form the basis of our MongoDB collection, we will also:
* mark this class  with the `@Document(collection = "reddit_posts")` annotation, and
* add an `_id` field of type String, with the `@Id` annotation. This is different from the `id` field, which is a field in the actual data.  The `_id` field is the MongoDB identifier for the document.


```java
package edu.ucsb.cs156.example.documents;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RedditPost {
    @Id
    private String _id;    
    private String id;
    private String subreddit;
    private String selftext;
    private String selftext_html;
    private String title;
    private String author;
    private String url;
    private List<RedditFlair> link_flair_richtext;
}
```

Now the `RedditPost` class will form the basis of our MongoDB collection.  But if we want to be able to populate our database from
data that comes from the Reddit API, we will need to create classes that correspond to the JSON structure above this level.

So, let's go back and look at the top level object again:

```json
{ 
  "kind" : "Listing",
  "data" : {
    "after"	: "t3_slh2js",
    "dist" : 	25,
    "modhash" :	"",
    "geo_filter" :	null,
    "children" :	[…],
    "before :	null
  }
}
```

Recall that each item in the `children` array looked like this:

```java
{  
  kind: "t3",
  data: { ... }
}
```

where the object after `data` was a `RedditPost`.   So we need an object for this level; we'll call it a `RedditT3` object for lack of a better idea:

Here's what that one will look like.  Since the import statements are the same, we'll leave them out this time:

```
// imports fron RedditPost omitted

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RedditT3 {
    private String kind;
    private RedditPost data;
}
```

Notice that the `data` field is of type `RedditPost`.  My hope is that you can now see where this is leading, but we'll still work thorugh the rest
of the example.

Now that we have a Java object to represent one element in the `children` array, we can go up a level again. Here again is the top level object:


```json
{ 
  "kind" : "Listing",
  "data" : {
    "after"	: "t3_slh2js",
    "dist" : 	25,
    "modhash" :	"",
    "geo_filter" :	null,
    "children" :	[…],
    "before :	null
  }
}
```

The `children` field will be represented as a `List<RedditT3>`.  But we need an object to represent the `data` field.  We'll call this a `RedditListingData`.  Most of the imports are the same, but we do also need now to import `java.util.List`:

```java
// imports fron RedditPost omitted
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RedditListingData {
    private String after;
    private int dist;
    // leaving out "geo_filter" to illustrated that we can leave things out    
    private List<RedditT3> children;
    private String before;
}
```

Now we are finally ready to write a class that represents the top level JSON we get directly from Reddit.  We'll call this a `RedditListing`, taking our cue from the `kind` field in the object:

```java
package edu.ucsb.cs156.example.documents;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RedditListing {
    private String kind;
    private RedditListingData data;
}
```

Now that we have all of these classes, what can we do with them?

First, lets define a collection class for our `RedditPost` objects.  

```java
package edu.ucsb.cs156.example.collections;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import edu.ucsb.cs156.example.documents.RedditPost;

@Repository
public interface RedditPostsCollection extends MongoRepository<RedditPost, ObjectId> {
 
}
```

Next, we'll define a controller method that will allow us to see all of the objects in the collection:

```java
package edu.ucsb.cs156.example.controllers;

import edu.ucsb.cs156.example.collections.RedditPostsCollection;
import edu.ucsb.cs156.example.documents.RedditPost;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Api(description = "Reddit Posts")
@RequestMapping("/api/redditposts")
@RestController
@Slf4j
public class RedditPostsController extends ApiController {

    @Autowired
    RedditPostsCollection redditPostsCollection;

    @Autowired
    ObjectMapper mapper;

    @ApiOperation(value = "List all posts")
    @GetMapping("/all")
    public Iterable<RedditPost> allPosts() {
        loggingService.logMethod();
        Iterable<RedditPost> posts = redditPostsCollection.findAll();
        return posts;
    }
}
```

But without any way to get object *into* the collection, this isn't going to do us much good.

So, we'll add a special controller method; a post method that:
* Will take a subreddit name as a parameter
* Go to that subreddit and just grab the first post
* Store that post in the collection if it is not already there; but it if is there, we update the values.  This is called an `upsert` (as opposed to an `insert`)

