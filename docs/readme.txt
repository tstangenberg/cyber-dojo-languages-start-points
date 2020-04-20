
building and deploying a new languages-start-points image
is much slower than I would like. It is slow largely because it has
to clone each git-repo URL and some repos are big, eg contain jar files.
Possible redesign to make this much faster...

When, eg, cyber-dojo-languages/java-junit is in its CI pipe it:
o) gets image-name from start_point/manifest.json
   eg cyberdojofoundation/java_junit
o) creates a new image with a tag of :LSP
   which contains only the start_point/ dir.
   eg cyberdojofoundation/java_junit:LSP

The creation of a new languages-start-points image (in its CI pipe is)
o) still has list of git-repo URLs
o) assumes git-repo has start_point/manifest.json file
o) gets just that file
o) parses it to get the image_name
o) adds tag of :lsp
o) pulls _that_ image to get the start_point/

It may be that we can refactor to use a plain list of docker image names.
These are then simply pulled and their start_point/ dirs collected together
(like start-point-base does with its 0/1/2/3/4 index dirs)

This still leaves the problem that java-junit (eg) is split across two
images, one for the runner, one for the start-point.
I can't see any way round that unless I drop :latest and start to use
:sha tags. Eg
  cyberdojofoundation/java_junit:LSP
    has manifest.json containing
       "image_name":"cyberdojofoundation/java_junit:4edf92a"

  cyberdojofoundation/java_junit:4edf92a
    is an image created from git commit whose 1st 7 sha chars are 4edf92a

Now we could just let image-names such as cyberdojofoundation/java_junit:4edf92a
get to the runner, which does an auto-pull. This may timeout, but its not bad.

An improvement might be to hook into the deployed /ready? probe of
languages-start-points and get it to do a one-time only pull of the images.
Viz, pull all the named images, eg cyberdojofoundation/java_junit:4edf92a
and when they are all pulled, create a change of state (somehow)
so its one-time only. Eg, ignoring readonly file-system
   ready?
   if (all-pulled file exists)
      200
   else
      pull them all
      create all-pulled file
      200

Init-containers are Kubernetes only.


Are we guaranteed that
replicaCount == 3 means we get one per node?
Or does languages-start-points need to be a daemonSet?
