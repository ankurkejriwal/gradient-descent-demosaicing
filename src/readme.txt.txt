The algorithm is implemented in Matlab with help from the image processing toolkit. 
The program consists of one file and image and produces a 3 channel Bayer image, 1 Channel Bayer image, and the interpolated image.
The main file is project1.m which contains all the relevant functions and code required to run the project and the image provided is the lighthouse.png image. 
To change the input image change the filename on line 2. 
The file outputs three images one of which is the mosaicked image in 3 channel format(mosaic3Channel.png), 
the other is a 1 channel representation of the same image(mosaick1Channel.png), and the last being the interpolated image (CompleteImage.png)

The mse is outputted to console for both my interpolation implementation and using Matlab’s demosaic function and are labeled accordingly. 
