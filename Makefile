#Directory with c code
C_DIR= ./c

#Directory with js code, data.json (data/), 
#script to generate program.js (pre/)
#and script for post processing (post/)
CROWDPROCESS_DIR= ./crowdprocess

#C compiler
CC=cc

#Flags to C compiler
CFLAGS=-O0 `pkg-config --cflags opencv`


LIBC=`pkg-config --libs opencv`

#Libs: 
#cwd ./c
LIBJS= ../crowdprocess/libs/libcv.a ../crowdprocess/libs/libcvaux.a ../crowdprocess/libs/libhighgui.a ../crowdprocess/libs/libcxcore.a ../crowdprocess/libs/libml.a

#C sources
SOURCES= facedetect.c

#Executable name
EXEC=gray

#Emscripten C compiler
#EMCC=path/to/emscripten/emcc
#Example:
#EMCC= /home/sergio/emscripten/emcc 
EMCC=/home/sergio/emscripten/emcc

#Flags for emscripten C compiler
#-O<optimization level>
#See: https://github.com/kripken/emscripten/wiki/Optimizing-Code
EMCCFLAGS=-O0

#Various compiling-to-JS parameters.
#See https://github.com/kripken/emscripten/blob/master/src/settings.js
SETTINGS= -s ASMJS=0 -s LINKABLE=1 -s INVOKE_RUN=0

#gray arguments  

#./EXEC 1arg 
#node EXEC.js 1arg 

#1arg: filename.jpg

ARGV= facebook.jpg

#Img 
#See /img
IMG= ./img/facebook.jpg

#Data file
#See /crowdprocess/data/data.json and #gray arguments  

#Fixed
#Rows/Cols = 100
#slope file name = malcataSlope_100.grass 
#aspect file name = malcataAspect_100.grass 

#From data.json 
#filename.jpg = facebook.jpg 

DATA= ./data/data.json

RESULTS_DIR= $(CROWDPROCESS_DIR)/results

all: c cp

install:
	./install.sh

#tested:ok
c: 
	mkdir -p $(C_DIR)/build/;
	cd $(C_DIR) && \
	$(CC) $(CFLAGS) $(SOURCES) -o build/$(EXEC) $(LIBC) 

#tested:ok	
run-c:
	cp -r $(IMG) $(C_DIR)/build; 
	cd $(C_DIR)/build && \
	./$(EXEC) $(ARGV) && \
	rm -f $(C_DIR)/build/*.jpg

#tested:ok
cp: 
	mkdir -p $(CROWDPROCESS_DIR)/build
	mkdir -p $(CROWDPROCESS_DIR)/data
	mkdir -p $(CROWDPROCESS_DIR)/pre/build
	cd $(C_DIR) && \
	$(EMCC) $(EMCCFLAGS) $(SOURCES) $(LIBJS) $(SETTINGS) --embed-file lena.tiff -o ../$(CROWDPROCESS_DIR)/pre/build/$(EXEC).js ; 
	cd $(CROWDPROCESS_DIR)/pre/ && \
	cat ./data/data.json | gencpd --compress ./lib/LZString > ../$(DATA) && \
	cat ./view/view_face.json | gencpp --template ./template/template.mustache > ../build/$(EXEC).js


run-editor:
	@program-editor -p $(CROWDPROCESS_DIR)/build/$(EXEC).js

run-io: io 

io:
	mkdir -p $(RESULTS_DIR)
	cat $(CROWDPROCESS_DIR)/$(DATA) | crowdprocess io -p $(CROWDPROCESS_DIR)/build/$(EXEC).js > $(RESULTS_DIR)/results.json
	node post/processResults.js $(RESULTS_DIR)/results.json

run-example: 
	cd ./example && node gray.js
	

clean:
	rm -rf $(C_DIR)/build
	rm -rf $(CROWDPROCESS_DIR)/build
	rm -rf $(CROWDPROCESS_DIR)/data
	rm -rf $(CROWDPROCESS_DIR)/pre/build
	rm -f ./example/gray.jpg ./example/stdout

.PHONY: all c run-c cp run-editor install clean 
