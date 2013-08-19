#include "cv.h"
#include "highgui.h"
#include <stdio.h>



int main(int argc,char*argv[]){
 

	//load
	
	IplImage* cimg = cvLoadImage(argv[1],CV_LOAD_IMAGE_COLOR);
        
	IplImage* gimg = cvCreateImage(cvGetSize(cimg),8,1);
          
  	//char* data      = img->imageData;
  	printf("Processing a %dx%d image with %d channels\n",cimg->height,cimg->width,cimg->nChannels);
        //printf("Processing gray a %dx%d image with %d channels\n",gimg->height,gimg->width,gimg->nChannels);
        
        cvCvtColor(cimg,gimg,CV_BGR2GRAY);
        
	
	//save
        cvSaveImage("gray.tiff",gimg);
	//cvReleaseImage(&cimg);
	//cvReleaseImage(&gimg);
}
