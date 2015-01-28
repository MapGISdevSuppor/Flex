package assets
{
	import spark.skins.spark.PanelSkin;
	/**
	 * 解决Panel右键出不来的bug 
	 * @author zhaoqianjun
	 * 
	 */
	public class YPanelSkin extends PanelSkin
	{
		override public function YPanelSkin()
		{
			super();
			mouseEnabled = true;
		}
	}
}

//A workaround is provided in the above bug report:
//
//set mouseEnabled=true in Panel
//create a custom skin which inherits from spark.skins.spark.PanelSkin
//set mouseEnabled=true in the created custom skin
//Setting the mouseEnabled property and the custom Skin can be easily achieved in mxml:
//
//<s:Panel mouseEnabled="true" skinClass="demo.style.YPanelSkin">
//	Developers who define their panel in ActionScript have to remember that skinClass is a style and not a property:
//
//var panel:Panel = new Panel();
//panel.mouseEnabled = true;
//panel.setStyle("skinClass", YPanelSkin);
//The custom skin itself does nothing else than setting the mouseEnabled property to true:
//
//package demo.style
//{
//	import spark.skins.spark.PanelSkin;
//	
//	public class YPanelSkin extends PanelSkin
//	{
//		override public function YPanelSkin()
//		{
//			super();
//			mouseEnabled = true;
//		}
//	}
//}