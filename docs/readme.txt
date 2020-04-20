
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
