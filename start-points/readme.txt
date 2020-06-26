
The preferred way to create a language start-point image is using tagged urls.
Eg
   cyber-dojo start-point create ruby-all --languages \
     0ca1b04@https://github.com/cyber-dojo-start-points/ruby-approval \
     bdbf761@https://github.com/cyber-dojo-start-points/ruby-cucumber \
     f618605@https://github.com/cyber-dojo-start-points/ruby-minitest \
     3371ebc@https://github.com/cyber-dojo-start-points/ruby-rspec    \
     b5e366e@https://github.com/cyber-dojo-start-points/ruby-testunit

Eg
  cyber-dojo start-point create all --languages $(cat git_repo_urls.all.tagged)
