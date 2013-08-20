OpenCV1.0-Emscripten 
===========

OpenCV1.0 example compiled to JavaScript. 

##Requirements:
  * [Emscripten](https://github.com/kripken/emscripten/wiki/Tutorial)

##Recommended reading:
 * [Mustache manual](http://mustache.github.io/mustache.5.html)
 * [Emscripten/wiki/Filesystem Guide](https://github.com/kripken/emscripten/wiki/Filesystem-Guide)
  
#####See: [template.mustache](https://github.com/sergio2540/FireSim-Emscripten/blob/master/crowdprocess/pre/template/template.mustache)

 * [Building projects with emscripten](https://github.com/kripken/emscripten/wiki/Building-Projects)
 * [HOWTO: Port a C/C++ Library to JavaScript (xml.js)@blog.mozakai](http://mozakai.blogspot.pt/2012/03/howto-port-cc-library-to-javascript.html)
 * [OpenCV 1.0 Docs](http://www.cognotics.com/opencv/docs/1.0/)


##Usage:

###Install: 

```bash
  git clone https://github.com/sergio2540/OpenCV1.0-Emscripten.git
  cd ./OpenCV1.0-Emscripten 
  make install
```

###Compile c code: 

```bash
  make c CC=cc
```
###Run c code: 

```bash
  make run-c
  make run-c ARGV=facebook.jpg
```
###Compile js code: 

```bash 
  make cp EMCC=path/to/emscripten/emcc
```
###Generate data.json:

######See: [Explain crowdprocess/pre/data](https://gist.github.com/sergio2540/b5b45f9e13e533ea056d)

###Generate program.js:

######See: [Explain crowdprocess/view/data](https://gist.github.com/sergio2540/fac873fccde43bb98b44)

###Run facedetect.js example: 

```bash
   make run-facedetect
   cd ./example
   gthumb result*.jpg
```

###Run gray.js example: 

```bash
   make run-gray
   cd ./example
   gthumb gray.tiff
```

###Run js with [program-editor](https://github.com/crowdprocess/program-editor): 

```bash
   make run-editor
```
###Run js with [crowdprocess-cli](https://github.com/CrowdProcess/crp-cli):
```bash
   make run-io
```

#####See: [Makefile](https://github.com/sergio2540/OpenCV1.0-Emscripten/blob/master/Makefile)
