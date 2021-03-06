@namespace s "library://ns.adobe.com/flex/spark";
@namespace mx "library://ns.adobe.com/flex/mx";
@namespace map "zdims.map.*";
@namespace othermap "zdims.othermap.*";
@namespace control "zdims.control.*";
@namespace myControls "myControls.*";
mx|ToolTip
{
	font-size:               13px;
	background-alpha:        0.8;
	background-color:        #87CEFA;
}
myControls|SuperPanel
{
	resize-grip-skin:          	Embed(source="/../sjd/assets/images/resizeHandler.png");
	
	actionAlpha:		 		0.75;
	border-color: 				#524f4f;
	border-alpha: 				0.6;
	border-thickness-left: 		0;
	border-thickness-top: 		0;
	border-thickness-bottom:	9;
	border-thickness-right: 	0;
	corner-radius: 				10;
	highlight-alphas: 			0, 0;
	header-colors: 				#524f4f,#524f4f;
	footer-colors: 				#ffffff, #ffffff;
	dropShadowEnabled: 			true;
	shadow-distance:			4;
	
	title-style-name:			"mypanelTitle";
	close-button-style-name:	"closeButton";
	minimize-button-style-name:	"minimizeButton";
	maximize-button-style-name:	"maximizeButton";
	
	inactive-header-colors: 	#524f4f, #524f4f;
	inactive-footer-colors: 	#ffffff, #ffffff;
	inactive-shadow-distance:	1;
	inactive-title-style-name:	"mypanelInactiveTitle";
	background-alpha:           0.7;
}

.closeButton
{
	icon: 						Embed(source="/../sjd/assets/WindowCloseButton.gif");
	up-icon: 					Embed(source="/../sjd/assets/WindowCloseButton.gif");
	over-icon: 					Embed(source="/../sjd/assets/WindowCloseButton2.gif");
	down-icon: 					Embed(source="/../sjd/assets/WindowCloseButton2.gif");
	disabled-skin: 				Embed(source="/../sjd/assets/images/clear.png");
	selected-up-skin: 			Embed(source="/../sjd/assets/images/clear.png");
	selected-over-skin: 		Embed(source="/../sjd/assets/images/clear.png");
	selected-down-skin: 		Embed(source="/../sjd/assets/images/clear.png");
	down-skin: 					Embed(source="/../sjd/assets/images/clear.png");
	over-skin: 					Embed(source="/../sjd/assets/images/clear.png");
	up-skin: 					Embed(source="/../sjd/assets/images/clear.png");	
}

.maximizeButton
{
	icon: 						Embed(source="/../sjd/assets/WindowMaxButton.gif");
	up-icon: 					Embed(source="/../sjd/assets/WindowMaxButton.gif");
	over-icon: 					Embed(source="/../sjd/assets/WindowMaxButton2.gif");
	selected-over-icon: 		Embed(source="/../sjd/assets/WindowMaxButton2.gif");
	down-icon: 					Embed(source="/../sjd/assets/WindowMaxButton.gif");
	selected-down-icon: 		Embed(source="/../sjd/assets/WindowMaxButton.gif");
	disabled-skin: 				Embed(source="/../sjd/assets/images/clear.png");
	selected-up-skin: 			Embed(source="/../sjd/assets/images/clear.png");
	selected-over-skin: 		Embed(source="/../sjd/assets/images/clear.png");
	selected-down-skin: 		Embed(source="/../sjd/assets/images/clear.png");
	down-skin: 					Embed(source="/../sjd/assets/images/clear.png");
	over-skin: 					Embed(source="/../sjd/assets/images/clear.png");
	up-skin: 					Embed(source="/../sjd/assets/images/clear.png");	
}

.minimizeButton
{
	icon: 						Embed(source="/../sjd/assets/WindowMinButton.gif");
	up-icon: 					Embed(source="/../sjd/assets/WindowMinButton.gif");
	over-icon: 					Embed(source="/../sjd/assets/WindowMinButton2.gif");
	selected-over-icon: 		Embed(source="/../sjd/assets/WindowMinButton2.gif");
	down-icon: 					Embed(source="/../sjd/assets/WindowMinButton.gif");
	selected-down-icon: 		Embed(source="/../sjd/assets/WindowMinButton.gif");
	disabled-skin: 				Embed(source="/../sjd/assets/images/clear.png");
	selected-up-skin: 			Embed(source="/../sjd/assets/images/clear.png");
	selected-over-skin: 		Embed(source="/../sjd/assets/images/clear.png");
	selected-down-skin: 		Embed(source="/../sjd/assets/images/clear.png");
	down-skin: 					Embed(source="/../sjd/assets/images/clear.png");
	over-skin: 					Embed(source="/../sjd/assets/images/clear.png");
	up-skin: 					Embed(source="/../sjd/assets/images/clear.png");
}

.mypanelTitle
{
	font-weight:				bold;
	color: 						#ffffff;
}

.mypanelInactiveTitle
{
	font-weight:				bold;
	color: 						#ffffff;
}