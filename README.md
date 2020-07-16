
[![CircleCI](https://circleci.com/gh/cyber-dojo/languages-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/languages-start-points)

- The source for the languages-start-points docker-containerized micro-services for [https://cyber-dojo.org](http://cyber-dojo.org)
- Image is here [cyberdojo/languages-start-points](https://hub.docker.com/r/cyberdojo/languages-start-points/tags)
- The file [git_repo_urls.tagged](https://github.com/cyber-dojo/languages-start-points/blob/master/git_repo_urls.tagged) lists all the language-test-framework repositories (each one has its own `manifest.json`) included in this image.
- The file [compressed.image_sizes.sorted](https://github.com/cyber-dojo/languages-start-points/blob/master/compressed.image_sizes.sorted) lists all the images named in these `manifest.json` files, together with their (compressed) sizes, in descending order.

***

The preferred way to create a language start-point image is using 'tagged' urls (where the seven
character url prefix is the first seven characters of a commit sha for the url).  
Eg
```bash
  cyber-dojo start-point create cyberdojo/languages-start-points \
    --languages \
      $(cat git_repo_urls.tagged)
```
Eg
```bash
   cyber-dojo start-point create ruby-all \
      --languages \
        0ca1b04@https://github.com/cyber-dojo-start-points/ruby-approval \
        bdbf761@https://github.com/cyber-dojo-start-points/ruby-cucumber \
        f618605@https://github.com/cyber-dojo-start-points/ruby-minitest \
        3371ebc@https://github.com/cyber-dojo-start-points/ruby-rspec    \
        b5e366e@https://github.com/cyber-dojo-start-points/ruby-testunit
```

***

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
