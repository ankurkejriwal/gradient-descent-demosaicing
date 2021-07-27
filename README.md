# Gradient based interpolation(Demosaicing) #


## Setup Instructions for MATLAB

1.  The project was completed in MATLAB, Please download MATLAB from the following link https://www.mathworks.com/downloads/ 

2.  The Image Processing Toolbox was used inorder to reshape the image into columns (to reduce multiplication cost), please install this as well

3.  Clone this repository 


## Repository Structure Breakdown

This section is a breakdown of the Repository for a new user of the program to understand and navigate through it. The next section will discuss how to run the actual program.  The `src` Folder will have the structure as shown in the picture below.

![image](https://user-images.githubusercontent.com/40211117/127087891-30adfab2-e6d5-45e8-88cc-c534fd84aa3f.png)


Below is a quick breakdown of what is inside the `src` folder.
  - `gradient_interp.m`
    - This is the main file of the MATLAB program. Downsampling, interopolation and MSE calculations are all done here.
   
  - `lighthouse.png`
    - This is the input image for the linear regression demosaicing program.

Below are the images produced after running the `gradient_interp.m` file

  - `CompleteImage.png`
    - This is the resulting image from the linear regression demosaic program. 

  - `DemosaicMatlab.png`
    - This is the resulting image from MATLAB's demosaic function. 

  - `Mosaic1Channel.png`
    - Intermediate image produced by the script 

  - `Mosaic3Channel.png`
    - Intermediate image produced by the script   


## How to Run the Program

All the user needs to do is specify the input images, and run `gradient_interp.m`. Simple instructions on how to do this are given below:

1.	By default, the program assumes that the input images are called `lighthouse.jpeg` . The input images can be changed in two easy ways:

      1. Re-name the images you want to input to the names specified above. 

      2. Or, open `gradient_interp.m` and edit `line 2`. Then simply just change the name to whatever the image is called in the string.
 
2.	To run the program now, first run `gradient_interp.m` in MATLAB.
    When the program finishes executing you will see the MSE calculated to compare our result to Matlab's native implementation of the demosaicking algorithm
    
3.	The resulting demosaiced images will be written and located in the `src` folder. Refer back to the Repository Break Down Section if more detail is needed on how the Program works. 

4.	Repeat from Step 1 with a new Input Image. Enjoy!
