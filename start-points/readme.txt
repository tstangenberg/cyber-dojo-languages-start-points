
Currently there are two ways to create a language start-point image:

$ cyber-dojo start-point create NAME --languages <url>...
Eg
   cyber-dojo start-point create gcc-small --languages \
     https://github.com/cyber-dojo-start-points/gcc-assert \
     https://github.com/cyber-dojo-start-points/gcc-googletest


$ cyber-dojo start-point create NAME --languages <tagged-url>...
Eg
   cyber-dojo start-point build ruby-all --languages \
     0ca1b04@https://github.com/cyber-dojo-start-points/ruby-approval \
     bdbf761@https://github.com/cyber-dojo-start-points/ruby-cucumber \
     f618605@https://github.com/cyber-dojo-start-points/ruby-minitest \
     3371ebc@https://github.com/cyber-dojo-start-points/ruby-rspec    \
     b5e366e@https://github.com/cyber-dojo-start-points/ruby-testunit
