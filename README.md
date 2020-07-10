
[![CircleCI](https://circleci.com/gh/cyber-dojo/languages-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/languages-start-points)

- The source for the languages-start-points docker-containerized micro-services for [https://cyber-dojo.org](http://cyber-dojo.org)
- Image is here [cyberdojo/languages-start-points](https://hub.docker.com/r/cyberdojo/languages-start-points/tags)

***

The preferred way to create a language start-point image is using tagged urls.
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
Eg
```bash
  cyber-dojo start-point create cyberdojo/languages-start-points \
    --languages \
      $(cat git_repo_urls.tagged)
```

***

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
