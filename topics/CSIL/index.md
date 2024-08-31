---
parent: Topics
layout: default
title: "CSIL"
description:  "Computer Science Instructional Lab machines"
category_prefix: "csil: "
has_children: true
---

# What is CSIL?

The term CSIL (pronounced "see sill") is used by members of the Computer Science community at UCSB to refer to two different things:

1. A physical computer lab on the first floor of Harold Frank Hall.
2. A network of computers that includes the machines in the CSIL lab, plus other systems that share the same home directories
    and software.   These machines are available for remote access via ssh clients (more information below).

Here's a bit more information on each of these

# The CSIL network 

* Includes 48 machines numbered: `csil-01.cs.ucsb.edu`, `csil-02.cs.ucsb.edu`, `csil-03.cs.ucsb.edu`... through `csil-48.cs.ucsb.edu`.
* Includes the main time-sharing machine `csil.cs.ucsb.edu`
* Includes the 36 machines in Phelps 3525 lab, named `cstl-00.cs.ucsb.edu` (instructor lectern), and `cstl-01.cs.ucsb.edu` through
  `cstl-35.cs.ucsb.edu` (student workstations).
   
# Remote Access via ssh:    

The machines of the CSIL network can be accessed remotely using an SSH connection.   The following articles
have more information about connecting via ssh from various operating systems:

* [CSIL: via ssh from Windows](csil_via_ssh_from_windows.md)
* [CSIL: via ssh from Mac OS](csil_via_ssh_from_macos.md)
* [CSIL: via ssh from Linux](csil_via_ssh_from_linux.md)

  
  
# The Physical CSIL Lab
    
* This lab has 48 computers running the Linux operating system.
* During regular quarters, it is available from early morning until rather late at night, most days.    
* These are the main systems provided for student use in undergrad and graduate Computer Science courses.
* The account you use is a CoE account, available here: [https://accounts.engr.ucsb.edu](https://accounts.engr.ucsb.edu).   Students
        that are enrolled in any CoE Computer Science or CCS Computing course are eligble for an account, 
        even if they are not students in a College of Engineering degree program. 
* To find this lab: Go to the covered patio in front of the main, ocean side front entrance of Harold Frank Hall.   If you are standing
       with your back to the ocean, facing the glass doors that lead into the building, you can enter CSIL through a separate set of 
       two outside doors on your right.


# Support Information 

* All of the CSIL network machines (`csil-nn.cs`, `csil.cs` and `cstl-nn.cs`) are supported by the ECI system staff [https://eci.ucsb.edu/eci/](https://eci.ucsb.edu/eci/).  
* All of these machines mount the same home directories.
* In principle, all three have the same software distributions available.
* In practice, because the hardware for all three labs is subtly different and may require different "tweaks" to the operating system
drivers, etc., there can be cases where the `csil-xx.cs`, `cstl-xx.cs`, and `csil.cs` diverge, 
* If/when a divergence occurs, it is likely either 
    * (a) a temporarily situation while a rolling upgrade is being made (e.g. to patch a security vulnerability, or address a bug)
    * (b)  an inadvertent oversight.
    
# Reporting system issues

Students/TAs/Instructors are encouraged, if/when they find significant differences between/among systems, or other unexpected
behavior, to report these problems.

<b>Students</b> should typically report system problems to their instructional staff first, rather than contacting ECI staff directly.
When it is being used, Piazza is a good forum for this.   If Piazza is not being used, then email your TA/Instructor.

Your TA/Instructor can then check the situation, and if necessary, escalate 
to the ECI staff via the email address `help@engineering.ucsb.edu`

When reporting a problem, document as carefully as possible:
* Include a complete transcript of what you typed at the command prompt, and what all of the output was.
* Describe the difference between what you got, and what you expected the result to be.
* If you get the expected result on one system (system "A") and a different result on another system (system "B"), it is helpful to include a transcript of each 

In your transcript, include the commands:

   * `hostname` to echo the hostname of the system
   * `date` to indicate the date/time 
   * `whoami` to print the current username
   * `pwd` to print the current working directory
   
Example:   

```
-bash-4.3$ hostname
csil-07.cs.ucsb.edu
-bash-4.3$ date
Fri Sep 23 07:31:12 PDT 2016
-bash-4.3$ whoami
pconrad
-bash-4.3$ pwd
/cs/faculty/pconrad
-bash-4.3$    
```

