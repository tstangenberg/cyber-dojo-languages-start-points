
ISSUE: Building and deploying a new languages-start-points image
is much slower than I would like. It is slow largely because it has
to clone each git-repo URL and some repos are big, eg contain jar files.

ISSUE: Sometimes you need to deploy a new start-point (eg Java,JUnit) _and_
an associated image (eg cyberdojofoundation/java_junit). At the moment to do
this you need to force a deploy on CI to get the start-point and then
[kubectl exec] into the 3 nodes and [docker pull] the new image.

Possible redesign to solve these issues...

When, eg, cyber-dojo-languages/java-junit is in its CI pipe it:
o) creates its java-junit image as per currently
   eg cyberdojofoundation/java_junit
o) tags this image with the 1st 7 chars of the git commit sha
   eg cyberdojofoundation/java_junit:4edf92a
o) creates a _new_ second image which contains _only_ the start_point/ dir
   eg cyberdojostartpoints/java_junit:4edf92a
   Its manifest.json contains the tagged cdf image_name as above :4edf92a
   This image is also tagged to :latest

The creation of a new languages-start-points image (in its CI pipe)
takes a list of plain docker image names, which are all
cyberdojostartpoints (cdsp) images as above, with :latest tags.
Viz, languages-start-points contains just start-points!

This opens up the ability to put a version number (eg java 14) into
the repo name, the display name, and the image name.
eg java-14-junit
   "Java 14, JUnit"
   cyberdojostartpoints/java_14_junit:4edf92a

 It would be nice if the languages-start-points container had an API method
 that returned json of all this info which could be displayed by the shas service.

A new languages-start-point image is created by simply pulling all
the cdsp images and their start_point/ dirs are collected together
(like start-point-base does with its 0/1/2/3/4 index dirs) and a last
check is made that all display_names are unique.

Now we could just let image-names such as cyberdojofoundation/java_junit:4edf92a
get to the runner, which does an auto-pull (which may timeout initially).

An improvement would be to hook into the k8s /ready? probe of
languages-start-points and get it to do a one-time only pull of the images.
Viz, pull all the named images, eg cyberdojofoundation/java_junit:4edf92a
Eg
   ready?
   if (/tmp/all-pulled marker file exists)
      200
   else
      pull them all
      create /tmp/all-pulled marker file
      200

With this you could of course get a 2nd, 3rd etc ready? request from
k8s while the 1st one is still completing.
If the ready? probe fails for too long does it enter the crash-loop-backoff?

languages-start-points then needs to become a daemonSet.

How would this work for a commander started server?

How would this affect start-point creation using the cyber-dojo script?
At the moment, lcoally, I do things like
  $ cyber-dojo start-point create jj --languages $PWD
Does this need to be modified to also create the java_junit:4edf92a image?
I think that would be ok.
