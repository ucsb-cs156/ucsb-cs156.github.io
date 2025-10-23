

This is the dialog that recreates the correct line to put in the `known_hosts` file.

# A few more little security details

Should we have just said no to that dialog?  Well, it depends.

There are a few circumstances when you might have said `no` or `fingerprint`:

* If you were truly paranoid
* If you had actual reason to suspect that you or GitHub were under cyberattack
* If you were working on an application with very high security needs (e.g. nuclear weapons code)

Under those circumstances, you'd get the fingerprint for the GitHub public key through some means other than an internet connection (e.g. secure courier) and you'd verify it against the number shown there `SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU`.

Typically, however, we just trust that the connection is not under active attack, and we accept the number as valid.  

Then, if it later changes—as it did in this case—we verify that it was supposed to change (as we did, by reading the GitHub blog.)  If it wasn't supposed to change, then we might really believe that we were being subjected to a so-called "man-in-the-middle" attack.
