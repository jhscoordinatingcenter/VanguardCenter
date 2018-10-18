**Set project directory   
cd "C:\Users\cblackshear\Box Sync\JHS\CC\JHS01-StudyData\AncillaryStudies\ASN0042Liu-CT"

**Load data
usesas using "1-data\liverattenuation", clear

*How can we visualize the noise in our liver attenuation?******************************************

*how many values?
mdesc lfat_roi_1 lfat_roi_2 lfat_roi_3
    
*sort by noise
gsort +lfat_std1
  gen roi1noise = _n	
gsort +lfat_std2
  gen roi2noise = _n	
gsort +lfat_std3
  gen roi3noise = _n	

*create numeric participant ID
sort subjid
gen subjidNum = substr(subjid, 2, 6)
  destring subjidNum, replace  
	
*create sd steps from mean

  *region 1
  gen lfat_roi_1_1sd_ll = lfat_roi_1 - 1*lfat_std1
  gen lfat_roi_1_1sd_ul = lfat_roi_1 + 1*lfat_std1
  gen lfat_roi_1_2sd_ll = lfat_roi_1 - 2*lfat_std1
  gen lfat_roi_1_2sd_ul = lfat_roi_1 + 2*lfat_std1
  gen lfat_roi_1_3sd_ll = lfat_roi_1 - 3*lfat_std1
  gen lfat_roi_1_3sd_ul = lfat_roi_1 + 3*lfat_std1
  		 
  *region 2
  gen lfat_roi_2_1sd_ll = lfat_roi_2 - 1*lfat_std2
  gen lfat_roi_2_1sd_ul = lfat_roi_2 + 1*lfat_std2
  gen lfat_roi_2_2sd_ll = lfat_roi_2 - 2*lfat_std2
  gen lfat_roi_2_2sd_ul = lfat_roi_2 + 2*lfat_std2
  gen lfat_roi_2_3sd_ll = lfat_roi_2 - 3*lfat_std2
  gen lfat_roi_2_3sd_ul = lfat_roi_2 + 3*lfat_std2
  		 
  *region 3
  gen lfat_roi_3_1sd_ll = lfat_roi_3 - 1*lfat_std3
  gen lfat_roi_3_1sd_ul = lfat_roi_3 + 1*lfat_std3
  gen lfat_roi_3_2sd_ll = lfat_roi_3 - 2*lfat_std3
  gen lfat_roi_3_2sd_ul = lfat_roi_3 + 2*lfat_std3
  gen lfat_roi_3_3sd_ll = lfat_roi_3 - 3*lfat_std3
  gen lfat_roi_3_3sd_ul = lfat_roi_3 + 3*lfat_std3
  	
  *draw plot
  twoway (rbar    lfat_roi_1_3sd_ll lfat_roi_1_3sd_ul roi1noise) ///
         (rbar    lfat_roi_1_2sd_ll lfat_roi_1_2sd_ul roi1noise) ///
	     (rbar    lfat_roi_1_1sd_ll lfat_roi_1_1sd_ul roi1noise) ///
         (scatter lfat_roi_1 roi1noise, msize(tiny))               ///
		 (lowess  lfat_roi_1 roi1noise)                            ///
	if !missing(lfat_roi_1)                                        ///
    , title(Region of Interest 1)                                    ///
	  yline(40)                                                      ///
	  ylabel(, angle(forty_five))                                    ///
	  xscale(off)                                                    ///
	  legend(off)                                                    ///
	  /*legend(order(3 "1 SD Interval" 2 "2 SD Interval" 1 "3 SD Interval" 4 "Liver Attenuation"))*/ ///
	  name(roi1, replace)
	
  twoway (rbar    lfat_roi_2_3sd_ll lfat_roi_2_3sd_ul roi1noise) ///
         (rbar    lfat_roi_2_2sd_ll lfat_roi_2_2sd_ul roi1noise) ///
	     (rbar    lfat_roi_2_1sd_ll lfat_roi_2_1sd_ul roi1noise) ///
         (scatter lfat_roi_2 roi2noise, msize(tiny))               ///
		 (lowess  lfat_roi_2 roi2noise)                            ///
	if !missing(lfat_roi_2)                                        ///
    , title(Region of Interest 2)                                    ///
	  yline(40)                                                      ///
	  ylabel(, angle(forty_five))                                    ///
	  xscale(off)                                                    ///
	  legend(off)                                                    ///
	  name(roi2, replace)
	
  twoway (rbar    lfat_roi_3_3sd_ll lfat_roi_3_3sd_ul roi1noise) ///
         (rbar    lfat_roi_3_2sd_ll lfat_roi_3_2sd_ul roi1noise) ///
	     (rbar    lfat_roi_3_1sd_ll lfat_roi_3_1sd_ul roi3noise) ///
         (scatter lfat_roi_3 roi3noise, msize(tiny))               ///
		 (lowess  lfat_roi_3 roi3noise)                            ///
	if !missing(lfat_roi_3)                                        ///
    , title(Region of Interest 3)                                    ///
	  yline(40)                                                      ///
	  ylabel(, angle(forty_five))                                    ///
	  xscale(off)                                                    ///
	  legend(off)                                                    ///
	  name(roi3, replace)
		
  graph combine roi1 roi2 roi3, cols(1) xcommon l1title(Liver Attenuation (Hounsfield Units))
