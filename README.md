# A Comparative Study for Single Image Blind Deblurring (CVPR 2016)

### Introduction

This is the research code for the paper:

[Wei-Sheng Lai](http://graduatestudents.ucmerced.edu/wlai24/), 
[Jia-Bin Huang](https://sites.google.com/site/jbhuang0604/), 
[Zhe Hu](https://eng.ucmerced.edu/people/zhu), 
[Narendra Ahuja] (http://vision.ai.illinois.edu/ahuja.html), 
and [Ming-Hsuan Yang](http://faculty.ucmerced.edu/mhyang/), 
"A Comparative Study for Single Image Blind Deblurring", IEEE Conference on Computer Vision and Pattern Recognition, CVPR 2016 

[PDF](http://vllab.ucmerced.edu/~wlai24/cvpr16_deblur_study/paper/cvpr16_deblur_study_supp.pdf)

[Project page](http://vllab.ucmerced.edu/~wlai24/cvpr16_deblur_study/).


### Citation

If you find the code and dataset useful in your research, please cite:

    @inproceedings{Lai-CVPR-2016,
        author    = {Wei-Sheng Lai, Jia-Bin Huang, Zhe Hu, Narendra Ahuja, and Ming-Hsuan Yang}, 
        title     = {A Comparative Study for Single Image Blind Deblurring}, 
        booktitle = {IEEE Conferene on Computer Vision and Pattern Recognition},
        year      = {2016}
    }

### Contents
|  Folder    | description |
| ---|---|
|cache | cached data for vanishing point detection|
|data|Testing images of five datasets (Set5, Set14, Urban 100, BSD 100, Sun-Hays 80). All the images have been cropped according to the desired super-resolution factor. This avoids misalignment of the groundtruth high-resolution images and the super-resolved images|
|external|We use the vgg_interp2 from `imrender` to perform bilinear interpolation|
|quant_eval|Quantitative evaluation code|
|reference| A copy of the CVPR paper and the bibtex|
|source|MATLAB source code|

To run the algorithm on all datasets, simply run the `sr_demo_bacth.m`. Note that it is an educational code that is not optimized for speed. If timing is a concern, you can achieve visually similar results with small numbers of iterations, e.g., set the number of iterations `opt.numIter = 5;` in the file `sr_init_opt.m`. An example of the speed and quality trade-off can be found in Fig. 10 in the paper.

Feedbacks and comments are welcome! Feel free to contact me via jbhuang1@illinois.edu.