# rip.rb
### What's this?
rip is a simple yet quite useful web site ripper, meaning that it copies the HTML document from a given URL with its referred resources (i.e. css- and js-links). The resources is copied and created with matching folders.

### Note
This script is meant to be used to ease your work when creating a new website - i.e. to skip all the manual file copying.

Don't use this to steal other peoples work.

### Usage
##### Arguments
`-u`/`--url` The web in which to copy
`-p`/`--path` The path in which to store the copied content


##### Example
```
$ ruby rip.rb -u '<some website>' -p 'output'
```

### Example
So let's say you want to copy the content of a web site with following html:
```
$ ruby rip.rb -u 'http://localhost/ninja/' -p 'output'
```
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Some page</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
  </head>

  <body>

    <div>
    <!-- Some content... -->
    </div>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.min.js"></script>
    <script src="/js/super_cool_scripts/ninjascript.min.js"></script>
  </body>
</html>
```

Ripping the above will create an output as follows:
```
output/index.htm
output/css/bootstrap.min.css
output/css/style.css
output/js/bootstrap.min.js
output/js/jquery.min.js
output/js/super_cool_scripts/ninjascript.min.js
```

### License
The MIT license
