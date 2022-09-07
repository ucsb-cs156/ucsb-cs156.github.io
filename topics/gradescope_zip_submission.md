---
parent: Topics
layout: default
title: "Gradescope: Zip Submission"
description:  "Submitting a git repo for autograding via zip file"
indent: true
category_prefix	: "Gradescope: "
---

The best way to submit an git repository to Gradescope is to use the direct GitHub link in Gradscope.

However, if that is not working, an alternative is to submit a zip file.

# To submit a zip file

1. Locate the button to download a zip file and click it, as shown in the diagram below.  You first locate the Green `Code` button, and then click it to expose the
   `Download Zip` button.
   
   ![download zip](zip_button_50.png)

2. The downloaded file name will be similar to this one, with the name of the repo, followed by the name of the current branch, followed by `.zip`.  

   ![zip filename](zip_filename_50.png)

   NOTE: Be careful that your browser/OS is not set to automatically unzip downloaded zip files.  (This problem occurs frequently on Safari on Macs, for example, and sometimes on Windows.)   The .zip file needs to *stay zipped*.  Unzipping it and rezipping it can sometimes introduce an extra layer of directory, or remove a layer of directory, causing the Gradescope autograder to give unexpected results.
   
3. Upload the .zip file to Gradescope as your submission.  As you do, you should see that Gradescope is automatically unzipping the files as you submit; that's fine.

      ![upload file](upload_file_50.png)

That's it.  With luck, your submission will be accepted by Gradescope and you'll get back useful output.
