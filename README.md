# Bloom / Wilt
Submission for the L5lua Community Jam

## Overview
An exploration in L5 based loosely off of a previous project in p5.js that reads an image and recreates a pixelated version of the image where every pixel is an object that can be moved. The previous project can be viewed here:
<https://editor.p5js.org/cthompto/sketches/tGZDawaAG>

This version of the idea uses the same principle of creating an object for each pixel but instead of having user controlled changes, "Bloom / Wilt" uses autonomous means of changing pixels. 

## Concept
This project takes inspiration from the "glitch garden" prompt of the L5 jam call. This year is the first time in my life that I have been able to grow a garden and I have had the joy of watching plants bloom and now wilt as time goes on. This inspired me to create a piece that uses blooming and wilting as an abstract idea for manipulating an image. Additionally, the piece uses nature/garden photos I have taken as the base images of the work. 

The intent of this work was to create a piece that could change, undulate, and warp overtime without human input. The piece will change indefinitely, with forms like valleys and peaks emerging over time.

## Techincal Details
This piece was written in [L5](https://l5lua.org/), with no generative "AI" tool uses at any stage of it's development. The piece works by:
1. Loading an image and reading the color value for the area of each pixel.
2. Storing each pixel's the color value and position in a table.
3. Rendering the color value and position as a larger rectangle. 
4. Manipulating the pixels through a "bloom" and "wilt" spotlight.
    - The spotlights are traveling points around the screen. 
    - When a pixel is within these spots they either bloom or wilt.
        - Bloom is defined by rotating clockwise and expanding.
        - Wilt is defined by rotating counterclockwise and shrinking.
5. Rendering the new pixel state on the screen.

## To-Dos
~~- add prior versions~~
~~-add title screen~~
~~- add start button~~
~~- add credits~~
~~- add random picture chooser~~
~~- add include more images~~