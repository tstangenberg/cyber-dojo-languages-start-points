
[![CircleCI](https://circleci.com/gh/cyber-dojo/languages-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/languages-start-points)

Specifies the start-points used to create the languages start-point images
* [cyberdojo/languages-start-points-all](https://hub.docker.com/r/cyberdojo/languages-start-points-all)
* [cyberdojo/languages-start-points-common](https://hub.docker.com/r/cyberdojo/languages-start-points-common)
* [cyberdojo/languages-start-points-small](https://hub.docker.com/r/cyberdojo/languages-start-points-small)

```bash
#!/bin/bash
set -e

GITHUB_ORG=https://raw.githubusercontent.com/cyber-dojo
LANGUAGES_START_POINTS="${GITHUB_ORG}/languages-start-points/master/start-points"
SCRIPT=cyber-dojo
curl -O --silent --fail "${GITHUB_ORG}/commander/master/${SCRIPT}"
chmod 700 ./${SCRIPT}

IMAGE_NAME=cyberdojo/languages-start-points-all:latest
./${SCRIPT} start-point create \
   "${IMAGE_NAME}" \
      --languages \
        $(curl --silent --fail "${LANGUAGES_START_POINTS}/all")

IMAGE_NAME=cyberdojo/languages-start-points-common:latest
./${SCRIPT} start-point create \
   "${IMAGE_NAME}"\
      --languages \
        $(curl --silent --fail "${LANGUAGES_START_POINTS}/common")

IMAGE_NAME=cyberdojo/languages-start-points-small:latest
./${SCRIPT} start-point create \
   "${IMAGE_NAME}" \
      --languages \
        $(curl --silent --fail "${LANGUAGES_START_POINTS}/small")
```

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
