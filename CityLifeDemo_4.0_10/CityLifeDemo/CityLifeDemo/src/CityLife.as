import Mapgis7.WebService.BasLib.EnumLayerStatus;

import flash.geom.PerspectiveProjection;
import flash.net.navigateToURL;
import flash.ui.ContextMenu;

import flashx.textLayout.factory.TruncationOptions;

import mx.collections.ArrayCollection;
import mx.containers.HBox;
import mx.controls.Alert;
import mx.controls.Text;
import mx.core.ApplicationGlobals;
import mx.core.UIComponent;
import mx.effects.Resize;
import mx.events.BrowserChangeEvent;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.events.ListEvent;
import mx.events.ResizeEvent;
import mx.managers.BrowserManager;
import mx.managers.IBrowserManager;
import mx.managers.PopUpManager;
import mx.printing.FlexPrintJob;
import mx.printing.FlexPrintJobScaleType;
import mx.utils.URLUtil;

import myControls.ContentBox;
import myControls.myPrintToolBox;

import sjd.managers.ResizeManager;

import zdims.control.IMSRoad;
import zdims.controls.EditMapView;
import zdims.drawing.GraphicsLayer;
import zdims.othermap.GoogleLayerType;
import zdims.othermap.TianDiLayerType;

public var container:HDividedBox;
public var vmapdoc:VectorMapDoc;
private var printset:myPrintToolBox;
private var browserManager:IBrowserManager;
public var historyManagementEnabled:Boolean=true;
private var mapEditView:EditMapView;
private var flag:Boolean=false;
private var menu_2D:ContextMenu=null;



//显示2D图层
protected function tilebtn_clickHandler():void
{
	this.mapContainer_Bing.height=0;
	this.mapContainer_2D.percentHeight=100;
	this.mapContainer_3D.height=0;
	this.mapContainer_Google.height=0;
	this.mapContainer_Tianditu.height=0;
	this.mapContainer_Yahoo.height=0;
	if(mapContainer_2D!=null&&mapDoc!=null)
	{
		mapDoc.visible=false;//设置2D视图下，矢量地图文档为不可见
		tileLayer.visible=true;		
		//设置当前激活图层
		this.mapContainer_2D.activeMapDoc=mapDoc;
		this.mapDoc.updateAllLayerInfo();
	}
	//复位及更新
	this.mapContainer_2D.restore();
	this.mapContainer_2D.refresh(); 
	//关联工具条及工具
	toolbox.imsmap=mapContainer_2D;
	magnifier.imsmap=mapContainer_2D;
	eagle.imsmap=mapContainer_2D;
	navigation.imsmap=mapContainer_2D;   //设置导航条与当前地图容器绑定
	markEdit.imsmap=mapContainer_2D;		
	//打印视图状态下的地图显示容器赋值
	//				if(mapEditView!=null)
	//				{
	//					mapEditView.imsMap=mapContainer_2D;
	//				    mapEditView.vectorMapDoc=this.mapContainer_2D.activeMapDoc;
	//				    mapEditView.graphicsLayer=graphicsLayer1;
	//					mapEditView.mapDocName=mapContainer_2D.activeMapDoc.mapDocName;
	//				}
	flag=true;
}

//显示2.5维立体图层
protected function thrbtn_clickHandler():void
{
	//地图切换
	this.mapContainer_2D.height=0;
	this.mapContainer_Bing.height=0;
	this.mapContainer_Google.height=0;
	this.mapContainer_Tianditu.height=0;
	this.mapContainer_Yahoo.height=0;
	this.mapContainer_3D.percentHeight=100;
	//当前激活文档置空，清除公交及自驾路线、结果
	this.mapContainer_2D.activeMapDoc=null;
	this.toolbox.search.clearAllRoad();//清除公交轨迹
	if(this.toolbox.search.road)
		this.toolbox.search.resetcar();  //清除自驾轨迹
	this.toolbox.search.clearMarker();   //清除本地搜索标注
	this.toolbox.search.busresult.location_grid.removeAllElements();
	this.toolbox.search.busresult.location_grid.visible=false;
	this.toolbox.search.busresult.busResult.removeAllChildren();//清除公交结果显示框
	this.toolbox.search.busresult.busResult.visible=false;  //设置公交结果显示框为不可见
	this.toolbox.search.busresult.roadResult.visible=false;//设置自驾结果显示框为不可见
	if(mapEditView!=null)
		mapEditView.enableFrame=false;//设置图框在当前状态下为不可见
	//复位及更新
	this.mapContainer_3D.restore();
	this.mapContainer_3D.refresh();
	//关联工具条及工具
	toolbox.imsmap=mapContainer_3D;//将工具条与地图容器绑定
	magnifier.imsmap=mapContainer_3D;//将放大镜与地图容器绑定
	markEdit.imsmap=mapContainer_3D;//将标注控件与地图容器绑定
	navigation.imsmap=mapContainer_3D;  //将导航条与地图容器绑定
	flag=false;
}

//显示google地图
protected function GoogleMapbtn_clickHandler():void
{	//地图切换	
	this.mapContainer_2D.height=0;
	this.mapContainer_3D.height=0;
	this.mapContainer_Bing.height=0;
	this.mapContainer_Tianditu.height=0;
	this.mapContainer_Yahoo.height=0;
	this.mapContainer_Google.percentHeight=100;
	
	
	//当前激活文档置空，清除公交及自驾路线、结果
	this.mapContainer_2D.activeMapDoc=null;
	if(this.toolbox.search.road)
		this.toolbox.search.resetcar();
	this.toolbox.search.clearAllRoad();
	this.toolbox.search.clearMarker();   //清除本地搜索标注
	this.toolbox.search.busresult.location_grid.removeAllElements();//清除本地关键字检索结果
	this.toolbox.search.busresult.location_grid.visible=false;
	this.toolbox.search.busresult.busResult.removeAllChildren();//清除公交结果显示框
	this.toolbox.search.busresult.busResult.visible=false;  //设置公交结果显示框为不可见
	this.toolbox.search.busresult.roadResult.visible=false;//设置自驾结果显示框为不可见
	if(mapEditView!=null)
		mapEditView.enableFrame=false;//设置图框在当前状态下为不可见
	//复位及更新	
	this.mapContainer_Google.restore();
	this.mapContainer_Google.refresh(); 
	//关联工具条及工具
	toolbox.imsmap=mapContainer_Google;
	magnifier.imsmap=mapContainer_Google;
	navigation.imsmap=mapContainer_Google;
	markEdit.imsmap=mapContainer_Google;
	flag=false;
}



//显示微软必应地图
protected function Bingbtn_clickHandler():void
{    
	//地图切换
	this.mapContainer_2D.height=0;
	this.mapContainer_3D.height=0;
	this.mapContainer_Google.height=0;
	this.mapContainer_Tianditu.height=0;
	this.mapContainer_Yahoo.height=0;
	this.mapContainer_Bing.percentHeight=100;
	
	//当前激活文档置空，清除公交及自驾路线、结果
	this.mapContainer_2D.activeMapDoc=null;
	if(this.toolbox.search.road)
		this.toolbox.search.resetcar();
	this.toolbox.search.clearAllRoad();
	this.toolbox.search.clearMarker();   //清除本地搜索标注
	this.toolbox.search.busresult.location_grid.removeAllElements();
	this.toolbox.search.busresult.location_grid.visible=false;
	this.toolbox.search.busresult.busResult.removeAllChildren();//清除公交结果显示框
	this.toolbox.search.busresult.busResult.visible=false;  //设置公交结果显示框为不可见
	this.toolbox.search.busresult.roadResult.visible=false;//设置自驾结果显示框为不可见
	if(mapEditView!=null)
		mapEditView.enableFrame=false;//设置图框在当前状态下为不可见
	//复位及更新
	this.mapContainer_Bing.restore();
	this.mapContainer_Bing.refresh();
	//关联工具条及工具
	toolbox.imsmap=mapContainer_Bing;
	magnifier.imsmap=mapContainer_Bing;
	navigation.imsmap=mapContainer_Bing;
	markEdit.imsmap=mapContainer_Bing;
	flag=false;
}

//显示雅虎地图
protected function Yahoobtn_clickHandler():void
{
	//地图切换
	this.mapContainer_2D.height=0;
	this.mapContainer_3D.height=0;
	this.mapContainer_Bing.height=0;
	this.mapContainer_Google.height=0;
	this.mapContainer_Tianditu.height=0;
	this.mapContainer_Yahoo.percentHeight=100;
	
	//当前激活文档置空，清除公交及自驾路线、结果
	this.mapContainer_2D.activeMapDoc=null;
	if(this.toolbox.search.road)
		this.toolbox.search.resetcar();
	this.toolbox.search.clearAllRoad();
	this.toolbox.search.clearMarker();   //清除本地搜索标注
	this.toolbox.search.busresult.location_grid.removeAllElements();
	this.toolbox.search.busresult.location_grid.visible=false;
	this.toolbox.search.busresult.busResult.removeAllChildren();//清除公交结果显示框
	this.toolbox.search.busresult.busResult.visible=false;  //设置公交结果显示框为不可见
	this.toolbox.search.busresult.roadResult.visible=false;//设置自驾结果显示框为不可见
	if(mapEditView!=null)
		mapEditView.enableFrame=false;//设置图框在当前状态下为不可见
	//复位及更新
	this.mapContainer_Yahoo.restore();
	this.mapContainer_Yahoo.refresh();
	//关联工具条及工具
	toolbox.imsmap=mapContainer_Yahoo;
	markEdit.imsmap=mapContainer_Yahoo;
	navigation.imsmap=mapContainer_Yahoo
	magnifier.imsmap=mapContainer_Yahoo;
	flag=false;
}

//显示天地图
protected function Tdtbtn_clickHandler():void
{
	//地图切换
	this.mapContainer_2D.height=0;
	this.mapContainer_3D.height=0;
	this.mapContainer_Bing.height=0;
	this.mapContainer_Google.height=0;
	this.mapContainer_Yahoo.height=0;
	this.mapContainer_Tianditu.percentHeight=100;
	
	//当前激活文档置空，清除公交及自驾路线、结果
	this.mapContainer_2D.activeMapDoc=null;
	if(this.toolbox.search.road)
		this.toolbox.search.resetcar();
	this.toolbox.search.clearAllRoad();
	this.toolbox.search.clearMarker();   //清除本地搜索标注
	this.toolbox.search.busresult.location_grid.removeAllElements();
	this.toolbox.search.busresult.location_grid.visible=false;
	this.toolbox.search.busresult.busResult.removeAllChildren();//清除公交结果显示框
	this.toolbox.search.busresult.busResult.visible=false;  //设置公交结果显示框为不可见
	this.toolbox.search.busresult.roadResult.visible=false;//设置自驾结果显示框为不可见
	if(mapEditView!=null)
		mapEditView.enableFrame=false;//设置图框在当前状态下为不可见
	//复位及更新
	this.mapContainer_Tianditu.restore();
	this.mapContainer_Tianditu.refresh();
	//关联工具条及工具
	toolbox.imsmap=mapContainer_Tianditu;
	magnifier.imsmap=mapContainer_Tianditu;
	navigation.imsmap=mapContainer_Tianditu;
	markEdit.imsmap=mapContainer_Tianditu;
	flag=false;
}

//窗口初始化加载内容设置
protected function application1_creationCompleteHandler(event:FlexEvent):void
{
	//初始化加载，显示为3D景观图
	this.mapContainer_2D.height=0;
	this.mapContainer_Bing.height=0;
	this.mapContainer_Google.height=0;
	this.mapContainer_Tianditu.height=0;
	this.mapContainer_Yahoo.height=0;
	this.mapContainer_3D.percentHeight=100;
	this.toolbox.imsmap=mapContainer_3D;
	this.navigation.imsmap=mapContainer_3D;
	this.magnifier.imsmap=mapContainer_3D;
	this.markEdit.imsmap=mapContainer_3D;
	toolbox.x=this.width-toolbox.width-20;//设置工具条始终居中
	
	banner.left=305;//设置Banner居中
	banner.y=49;
	toolbox.y=banner.y+5;
	banner.height=1;
	banner.right=-5;
	layerBtn.x=(this.width-layerBtn.width)/2-100;
	layerBtn.y=27;
	
	
	//浏览器导航实例
	browserManager=BrowserManager.getInstance();
	browserManager.setTitle("城市生活服务系统");
	flag=false;
}

/**
 *点击返回浏览按钮，返回浏览视图
 */
protected function back_clickHandler(event:MouseEvent):void
{
	PopUpManager.removePopUp(printset);//移除打印工具箱
	this.currentState="default";		
	//				//地图位置还原
	this.hbox.y=0;
	this.hbox.x=0;
	this.hbox.percentHeight=100;
	this.hbox.percentWidth=100;			
	this.mapContainer_2D.contextMenu=menu_2D;
}

/**
 *地图浏览视图下，点击打印按钮，切换到打印视图
 */
protected function printIcon_clickHandler():void
{	
	
	this.setCurrentState("print_view",true);
	//	PopUpManager.addPopUp(printset,this.printview,false);  //打印预览中不包括打印框
	//	printset.x=200;
	//	printset.y=200;
	//	Alert.show("此视图为打印设置视图，若要调整打印框大小，请在打印设置里调整。为了方便打印内容的缩放，同时提供了打印内容的手动缩放，单击地图会出现可编辑框，可以手动拖放地图显示范围的大小。","说明");
	menu_2D=this.mapContainer_2D.contextMenu;
	this.mapContainer_2D.contextMenu=null;//添加点线区时的右键菜单设置
	
	//打印工具箱的属性设置
	//				printset.boder=printview;
	//				printset.imsmap=mapContainer_2D;
	//				printset.vmapdoc=mapDoc;
	
	printBar.vmapdoc=mapDoc;
	
	
	if(!mapEditView)
	{
		mapEditView=new EditMapView();
		mapEditView.addEventListener(FlexEvent.CREATION_COMPLETE,function(e:FlexEvent):void{
			mapEditView.x=100;
			mapEditView.y=50;
			mapEditView.width=printview.width-200;
			mapEditView.height=printview.height-100;
			mapEditView.update();
			
			hbox.horizontalScrollPolicy="off";
			hbox.verticalScrollPolicy="off";
			mapEditView.addEditElement(hbox);
			hbox.percentHeight=100;
			hbox.percentWidth=100;
		});
	}
	else
	{
		mapEditView.x=100;
		mapEditView.y=50;
		mapEditView.width=printview.width-200;
		mapEditView.height=printview.height-100;
		mapEditView.update();
		hbox.horizontalScrollPolicy="off";
		hbox.verticalScrollPolicy="off";
		
		mapEditView.addEditElement(hbox);
		hbox.percentHeight=100;
		hbox.percentWidth=100;
	}
	if(flag)
	{
		mapEditView.imsMap=mapContainer_2D;
		mapEditView.vectorMapDoc=this.mapContainer_2D.activeMapDoc;
		mapEditView.graphicsLayer=graphicsLayer1;
		mapEditView.mapDocName=mapContainer_2D.activeMapDoc.mapDocName;
	}
	//				printset.editmapview=this.mapEditView;
	printBar.editmapview=this.mapEditView;
	this.printview.addElement(mapEditView);		
	//	printview.addElement(printset); //在打印预览中包括打印设置框
	
}

/**
 *打印视图中点击打印按钮，弹出打印设置工具箱
 */
private function printBtn_click():void
{
	if(printset!=null)
		PopUpManager.removePopUp(printset);
	//				if(printset==null)
	//				{   //如果当前视图中不包括打印工具箱，新建
	printset=new myPrintToolBox();
	
	//				}
	
	PopUpManager.addPopUp(printset,this.printview,false);
	printset.visible=true;
	//				printset.init();
	//				printset.width=400;
	//				printset.height=380;
	//				ResizeManager.enableResize(printset,100);
	printset.x=200;
	printset.y=200;
	//打印工具箱的属性设置
	printset.boder=printview;
	printset.imsmap=mapContainer_2D;
	printset.vmapdoc=mapDoc;
	printset.editmapview=this.mapEditView;
	
	//打印工具箱的属性设置
	printset.boder=printview;
	printset.imsmap=mapContainer_2D;
	printset.vmapdoc=mapDoc;
	printset.editmapview=this.mapEditView;
	printset.visible=true;//设置打印工具箱为可见
	
}

/**
 *点击此页说明按钮，弹出打印页面说明
 */
protected function introductionBtn_clickHandler(event:MouseEvent):void
{
	Alert.show("此视图为打印设置视图，若要调整打印框大小，请在打印设置里调整。为了方便打印内容的缩放，同时提供了打印内容的手动缩放，单击地图会出现可编辑框，可以手动拖放地图显示范围的大小。","说明");
}

protected function googleMap_initializeHandler(event:FlexEvent):void
{
	//				googleMap.serverAddress="http://mt3.google.cn/vt/lyrs=t@128,r@170000000&hl=zh-CN&gl=cn";
	googleMap.serverAddress="http://mt0.google.cn/vt/lyrs=s@106&gl=cn";
}
