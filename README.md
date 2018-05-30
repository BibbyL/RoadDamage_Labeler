# RoadDamage_Labeler
Label road damage part of an image 

Road Damage Label Tool_v0.2

1. Load Video file by the “Browse” button.
2. Frame Control: Select Image for the number of frame.
3. Select the crop size from the “Window Size” panel and crop the Image by “Cut” button.
4. Choose Parameters for 
	- Label size
	- Moving step
	- Dilate parameters (imdilate(‘line’)).
	- Gaussian filtering parameter (imgaussfilt())
5. Results path with be same folder as Video file.
	- Auto create 3 folders for saving result
  - Image: original image without label
  - Mat_File: intensity matrix 
  - Heatmap: convert from intensity matrix


Key	function
W/↑	Move down the label position 
S/↓	Move up the label position 
A/←	Move left the label position 
D/→	Move right the label position 
Swift	Crop the Image 
Ctrl	Save the Image, Heat map and intensity map 
Space	Save current label point 
R	Increase Label size by one 
T	Decrease Label size by one 
Q	Increase Step speed by one 
E	Decrease Step speed by one 
1	Set Label size to 10  
2	Set Label size to 20 
3	Set Label size to 30 
4	Set Label size to 40 
Caps Lock	Halved the Label size 
5	Ease Model On/Off 

