---
title: "Crop an Image into a Circle with ImageMagick"
date: 2024-09-08T17:11:23+10:00
# weight: 1
# aliases: ["/first"]
tags: ["ImageMagick", "Circular Mask", "Image Cropping", "Photo Editing", "Command Line Tools", "Image Processing", "Graphics", "Image Manipulation"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Crop an image into a perfect circle using ImageMagick. Follow this step-by-step guide to create a circular mask and apply it to your image, achieving professional-looking results with ease. Ideal for those looking to master image editing with command-line tools."
disableHLJS: true # to disable highlightjs
disableShare: true
disableHLJS: false
hideSummary: false
searchHidden: true
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
cover:
    image: /images/logos/imagemagick_logo.png # image path/url
    alt: "imagemagick" # alt text
    caption: 'imagemagick' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

If you have an image that you'd like to crop into a perfect circle, ImageMagick is a powerful tool that can help you achieve this. Here's a straightforward guide to create a circular mask and apply it to your image using ImageMagick.

## 1. Create a Circular Mask

You'll need to create a circular mask. This mask will define the circular area you want to keep from your original image. Use the following comand to generate a circular mask

```sh
convert -size 1290x1290 xc:none -fill white -draw "circle 645,645 645,0" circle_mask.png
```

Here's a breakdown of the command:

- `size 1290x1290` specifies the dimensions of the mask to match your image.
- `xc:none` creates a transparent canvas.
- `fill white` sets the color of the circle to white.
- `draw "circle 645,645 645,0"` draws a circle centered at (645,645) with a radius of 645 pixels. This circle will be fully white, defining the visible area in the mask.
- `circle_mask.png` is the name of the mask file you'll create.

## 2. Apply the Mask to your Image

With the mask created, the next step is to apply it to your original image. Use the following command to apply the circular mask:

```sh
convert static/images/authors/danijeljw.png circle_mask.png -alpha off -compose CopyOpacity -composite static/images/authors/danijeljw_cropped.png
```

Here's what this command does:

- `static/images/authors/danijeljw.png` is your original image.
- `circle_mask.png` is the circular mask you just created.
- `alpha off` turns off the alpha channel of the mask.
- `compose CopyOpacity` specifies how the mask should be applied.
- `composite combines` the original image with the mask.
- `static/images/authors/danijeljw_cropped.png` is the final output file with the circular crop applied.

After running these commands, `danijeljw_cropped.png` will be your image cropped into a perfect circle.

In the command `convert -size 1290x1290 xc:none -fill white -draw "circle 645,645 645,0" circle_mask.png`, the numbers used in the `circle` command are derived from the dimensions of the image and the desired position of the circle. Let’s break down how these numbers are determined:

### Understanding the Numbers

1. **Image Size:** The image size is 1290x1290 pixels. This means the image is a square, with both width and height equal to 1290 pixels.

1. **Circle Command:** The circle command format in ImageMagick is:

```sh
circle cx,cy radius_x, radius_y
```

Here:
- `cx,cy` is the center of the circle.
- `radius_x, radius_y` is a point on the circumference of the circle that is along one of the radii.


1. **Center of the Circle:**

- The center of the circle is calculated as the midpoint of the image. For a 1290x1290 image, the center coordinates are:

```sh
cx = 1290 / 2 = 645
cy = 1290 / 2 = 645
```

So, `645,645` represents the center of the circle.

1. **Radius of the Circle:**

The radius of the circle is half of the image width or height, which is:

```sh
radius = 1290 / 2 = 645
```

This makes the radius point used in the command `645,0`, meaning that this point is located 645 pixels horizontally from the center of the circle, on the edge.

### Summary of Numbers

- **Center of the Circle:** `645,645` (Midpoint of the image)
- **Edge Point of the Circle:** `645,0` (Radius of 645 pixels from the center, directly to the right edge)

By using these coordinates, you create a mask where the circle covers the entire image area, giving you a perfect circular crop with a radius equal to half of the image's width or height.

Adjust the size and radius in the mask creation command to fit different image dimensions and desired circle sizes.
