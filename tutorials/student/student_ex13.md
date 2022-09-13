---
title: "Student: ex13"
parent: Student
grand_parent: Tutorials
description: "Read all lines of a file"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex13
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# NOTE: NOT YET UPDATED FOR JAVA 17 and JUNIT 5 (TODO for W22, 01/05/22)


In this exercise we show how to read a list of students from a text file
in `.csv` format (comma separated values) into a list of `Student` object
in memory.   This is a preliminary step to showing how to do sorting of
lists in Java.

More specifically:

* Show how to read all lines from a text input file into a `List<String>`.   
* Show how to convert that list of strings into an list of `Student` objects,
  more specifically an `ArrayList<Student>`.
* Show how to define custom exceptions
* Show how to set up the code so that most of the work is done in the 
  `Student` class with full test coverage.

# Some background that would be helpful

You will better understand the code in this lesson if you have first
read about 
* `class` vs. `interface` in Java 
* Java Generics (the `<>` stuff in expressions such as `ArrayList<Student>`
* Java Collections (e.g. `List<E>`, `ArrayList<E>`, etc.)

You can find out more about these topics in:
* Chapters 6,7,8 and 16 in HFJ2
* Chapter 7 in JN7, pp. 143-158 (from start of chapter, stopping when you get to **Introducing Covariance**)
* The section titled **The `List` Interface** 
  in Chapter 8 of JN7 (pp. 270-274).  (Note that `ArrayList` is one concrete implementation of the `List` interface.)

# A few notes on `List<String>`

Note that `List` is an *interface*, rather than
a class; that means that all we know about the object that `List<String>`
refers to is that it implements all the methods of `List<E>`, namely, the
ones listed on this page of javadoc:

* <https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html>

The `List<String>` *might* be an instance of `ArrayList<String>`, but *not necessarily*.  It could also be a `LinkedList<String>` or a `Vector<String>` for example.

# A few notes on `ArrayList<Student>`

The `ArrayList<E>` (where `E` is the generic *element* type) is probably the most basic and most often used class
for a collection in Java.  A Java `ArrayList` is similar to a List in Python:
* It has some of the qualities of an array, i.e. you can directly index elements
* But it also has some of the qualities of a linked list, in that you can
  dynamically grow and shrink the size of the list.

One significant difference between a Java `ArrayList` and a Python list is that while a Python list can store any type of object, and indeed a mixture of different types in the same list, in Java, when we declare an `ArrayList`, we
typically give it a specific type, e.g. `ArrayList<Student>` or `ArrayList<Dog>`, and then it can only hold objects of that type.

(While it is *possible* to declare an `ArrayList<Object>` that can hold objects of any type (including primitives, through the wrapper classes, such as `Integer`, `Float`, etc.), the cases where that's a *good* design are rare.)

For a more complete discussion of `ArrayList`, see:
* Chapters 6 and 16 in HFJ2
* The section titled **The `List` Interface** in Chapter 8 of JN7 (pp. 270-274).  (Note that `ArrayList` is one concrete implementation of the `List` interface.)


# Reading All Lines from a file

The file `ReadStudents.java` is a new class introduced here in ex13.
It has a `main` method that will
* take a filename as a command line argument
* open that file
* read all lines from that file
* process each line, converting each line into a `Student` object 
* store each of those objects into an `ArrayList<Student>`

It is divided into two parts. First the main:

```java
   public static void main(String[] args) {

        String usageMessage = "Usage: java Main filename\n"
                + "  filename should be a text file containing students in CSV format";

        if (args.length != 1) {
            System.err.println(usageMessage);
            System.exit(1);
        }

        String filename = args[0];

        List<String> allLines = null;

        try {
            allLines = Files.readAllLines(Paths.get(filename));
        } catch (IOException e) {
            System.err.println("ERROR: could not open file " + filename);
            System.err.println(e);
            System.exit(2);
        }

        ArrayList<Student> students = linesToStudents(allLines);

        System.out.println(students);

    } // main
```

The job of `main()` is to do four things:
* Make sure there is a command line argument for a filename
* Open that filename and read its contents into a `List<String>`
* Pass those contents to a separate static method `linesToStudents` that
  converts a `List<String>` into an `ArrayList<Student>`
* Print that `ArrayList<Student>` on `System.out`

It does all of these things with appropriate error checking and 
messaging.

The separate function `linesToStudents` does the job of 
* setting up an empty `ArrayList<Student>`
* converting each separate line of input to a `Student`, checking for exceptions (and printing appropriate error messages)
* returning the `ArrayList<Student>`

# The `fromCSV` method

To support this code, we needed to add one additional method to the
`Student` class, one called `fromCSV`.  This is a static method because
it is not associated with any instance of the class.  

We could have written
this as a constructor, but instead, we wrote it as a *factory method*.

Factory methods are an alternative to constructors for producing new
instances of objects.  In this case, there is no particular reason to 
make this a factory method rather than a constructor; we did so to familiarize
you with the concept, since you'll see it in other people's code.

(There are situations where factory methods have advantages over constructors
but that's a topic for another time.)

The `fromCSV` method looks like this.  Note that we declare that this 
method throws two different exceptions.  These are custom exceptions;
we'll get to that in a moment.

```java
    public static Student fromCSV(String csv) throws InvalidCSVLineException, InvalidPermException {
            String [] parts = csv.split(",");

            if (parts.length != 2) {
                throw new InvalidCSVLineException("Invalid: "+csv);
            }

            String name=parts[0];
            int perm = 0;

            try {
                perm=Integer.parseInt(parts[1]);
            } catch (NumberFormatException nfe) {
                throw new InvalidPermException("Invalid: " + parts[1]);
            }

            if (!validPerm(perm)) {
                throw new InvalidPermException("Invalid: " + perm);
            }

            return new Student(name, perm);
    }
```

# The custom exceptions

The exceptions `InvalidCSVLineException` and `InvalidPermException` are custom
exception types that we created with these new lines of code in `Student.java`:

```java
    public static class InvalidCSVLineException extends Exception {
        private static final long serialVersionUID = 1L;
        public InvalidCSVLineException(String msg) {
            super(msg);
        }
    }

    public static class InvalidPermException extends Exception {
        private static final long serialVersionUID = 1L;
        public InvalidPermException(String msg) { 
            super (msg);
        }
    }
```

These are declared as `static` inner classes; that is they are a class
nested inside the class `Student`.   We could have made these standalone
classes, but because they are so very small and used only in connection
with the `fromCSV` method of `Student`, it is convenient to just tuck
them inside the same source file, `Student.java`.

The custom exceptions are declared as `static` inner classes.  If an inner class is *not* declared as `static`, then instances of that class have to be tied to instances of the outer class (in this case `Student`).  That's not appropriate in this case, because the instances of these exceptions are created *specifically* in the case where we *cannot* make an instance of the `Student` class.    

(There are many more things to say about inner classes
that are *not* static, but that's really a topic for another time; for now, it's sufficient to know that if we want an inner class where the objects are independent of any instance of the main class, we need to declare the class as `static`.)

The constructors for each of these classes have one job, and that's to pass the parameter `msg` to the constructor of the parent class, `Exception`.  This allows us to customize the exception with a message that is revealed by the
`toString()` method.

# Test coverage

We have excluded the `ReadStudents` class from both Jacoco and PIT (mutation) test coverage checks. But we've pushed a lot of the details of error checking of the CSV input into the `Student` class in the `fromCSV` method which is subject to test coverage.  Here are the additional tests we wrote to check the various cases for `fromCSV`.  Some of these test cases were written by iterating on the test coverage reports until each case was covered.


```java
    @Test
    public void test_fromCSV_1() {
        String csv = "Chris Gaucho,1111111";
        Student s = null;
        try {
            s = Student.fromCSV(csv);
        } catch (Exception e) {
        }
        assertEquals(s.getName(), "Chris Gaucho");
        assertEquals(s.getPerm(), 1111111);
    }

    @Test(expected=Student.InvalidCSVLineException.class)
    public void test_fromCSV_3() throws Student.InvalidCSVLineException, Student.InvalidPermException {
        String csv = "";
        Student s = null;
        s = Student.fromCSV(csv);
    }

    @Test(expected=Student.InvalidPermException.class)
    public void test_fromCSV_4() throws Student.InvalidCSVLineException, Student.InvalidPermException {
        String csv = "Chris Gaucho,not-an-integer";
        Student s = null;
        s = Student.fromCSV(csv);
    }

    @Test(expected=Student.InvalidPermException.class)
    public void test_fromCSV_5() throws Student.InvalidCSVLineException, Student.InvalidPermException {
        String csv = "Chris Gaucho,1111119";
        Student s = null;
        s = Student.fromCSV(csv);
    }

```

Note that because our custom exceptions are checked exceptions (see Chapter 11 in HFJ2), they have to be "caught or declared to be thrown".   In our test cases, since we want the exceptions to be thrown (that's what the test case
is checking for), we don't want to wrap the call to `fromCSV` in a try/catch.
Accordingly, we declare the exceptions on the first line of the method with
the `throws Student.InvalidCSVLineException, Student.InvalidPermException` between the closing `)` of the parameter list and the opening `{` of the method.

```java
public void test_fromCSV_5() throws Student.InvalidCSVLineException, Student.InvalidPermException {
```

# Example of Running `ReadStudents`

To test our program, we set up two files in the directory `data`: 

* The file `data/goodData.csv` contains these lines, each of which
  has valid data:

  ```
  Chris Gaucho,1111111
  Laurel del Playa,1234566
  Alex Sabado,999996
  ```

* The file `data/mixedData.csv has good data mixed in with bad data:

  ```
  Chris Gaucho,1111111
  This is a bad line of data
  Laurel del Playa,1234566
  Bad Perm,not-an-integer
  Alex Sabado,999996
  Luhn McBadperm,1234567
  ```

Next we compile the code to a `.jar` file with `mvn package`, then
run our program using the command:

<tt>java -cp <i>jar-file-name</i> <i>class-name</i> <i>cmd-line-args</i></tt>

where:
* <tt><i>jar-file-name</i></tt> is `target/student-1.0.0.jar`, the `.jar`
  (Java Archive) produced by the `mvn package` command
* <tt><i>class-name</i></tt> is the name of the class containing the `main`
  method that we want to run, with the full package name.
  
  In this case, that's `edu.ucsb.cs156.student.ReadStudents`

* <tt><i>cmd-line-args</i></tt> are the value we want to pass in to the
  command line arguments, in this case the filename of our data

  That can be `data/goodData.csv` for example.

Here's what that looks like. 
```
% mvn package
... [output omitted] ...
% java -cp target/student-1.0.0.jar edu.ucsb.cs156.student.ReadStudents data/goodData.csv
[[name: Chris Gaucho, perm: 1111111], [name: Laurel del Playa, perm: 1234566], [name: Alex Sabado, perm: 999996]]
% 
```

Notice that the type `ArrayList<Student>` has
a `toString()` method defined that outputs the entire array; it invokes the
`toString()` method of each `Student` object to output each student.

If we use a `.csv` file that has a few bad lines in it mixed in with the
good lines, we get this as output:

```
% java -cp target/student-1.0.0.jar edu.ucsb.cs156.student.ReadStudents data/mixedData.csv
Invalid line ignored: This is a bad line of data
Line with invalid perm ignored: Bad Perm,not-an-integer
Line with invalid perm ignored: Luhn McBadperm,1234567
[[name: Chris Gaucho, perm: 1111111], [name: Laurel del Playa, perm: 1234566], [name: Alex Sabado, perm: 999996]]
% 
```

# Summary

In this exercise, ex13, we:
* Added a new main class that reads from a file into an
  `ArrayList<Student>`
* Added a static method to `Student` to create a new `Student` object
  from a `String` instance that represents one line of a `.csv` file
* Added two custom exception types that allow us to customize the 
  error output in our main program.
* Unit tests for the conversion of the line from CSV
* Added lines in our `pom.xml` so that `ReadStudent` would not appear
  in test coverage reports. 

In ex14, we'll discuss how to sort `ArrayList<Student>` instances
by either `name` or `perm`.

