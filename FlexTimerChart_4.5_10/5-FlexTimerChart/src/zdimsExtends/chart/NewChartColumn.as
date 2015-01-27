package zdimsExtends.chart
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.VerticalAlign;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.TextInput;
	
	import zdims.event.IMSMapEvent;
	import zdims.event.IMSMapMouseEvent;
	import zdims.map.IMSMap;
	import zdims.map.OverlayObject;
	import zdims.util.IMSOperType;
	
	public class NewChartColumn extends Group
	{
		/**
		 *柱形图的逻辑坐标x 
		 */
		public var logicCenterX:Number;
		/**
		 *柱形图的逻辑坐标y 
		 */
		public var logicCenterY:Number;
		/**
		 *柱形图的屏幕坐标x 
		 */
		public var CenterX:Number=200;
		/**
		 *柱形图的屏幕坐标y 
		 */
		public var CenterY:Number=300;
		/**
		 *柱形图的宽度 
		 */
		public var chartWidth:Number=100;
		/**
		 *柱形图的平面高度 
		 */
		public var chartHeight:Number=80;
		/**
		 *柱形图高度 
		 */
		public var rateHeiht:Number=0;
		/**
		 *柱形图每次增加的高度 
		 */
		public var rate:Number=10;
		/**
		 *柱形图填充颜色 
		 */
		public var fillColor:uint=0x82145;
		/**
		 *柱形图填充颜色透明度
		 */
		public var fillAlpha:Number=1;
		/**
		 *柱形图边线颜色 
		 */
		public var borderColor:uint=0xFF0010;
		/**
		 *柱形图边线宽度 
		 */
		public var borderThickness:Number=1;
		/**
		 *柱形图边线透明度 
		 */
		public var borderAlpha:Number=1;
		/**
		 *地图容器
		 */
		public var imsmap:IMSMap;
		/**
		 *文本指示信息框的宽度
		 */
		public var txtInfoWidth:Number=45;
		/**
		 *文本指示信息框的高度
		 */
		public var txtInfoHeight:Number=34;
		/**
		 *文本指示信息框的透明度
		 */
		public var txtBorderAlpha:Number=1;
		/**
		 *文本指示信息框的宽度
		 */
		public var txtBorderThick:Number=1;
		/**
		 *文本指示信息框的颜色
		 */
		public var txtBorderColor:uint=0x000000;
		
		/**
		 *文本填充内容
		 */
		private var _txtContent:String;
		
		/**   
		 * 柱形图对象
		 *    
		 **/
		protected var ui:UIComponent;
		/**   
		 * 标志位（是否以逻辑坐标绘制图形，true表示以逻辑坐标绘图）
		 *    
		 **/
		protected var isLogicFlag:Boolean=true;
		/**   
		 * 鼠标在地图上按下时的屏幕坐标x
		 *    
		 **/
		protected var locx:Number;
		/**   
		 * 鼠标在地图上按下时的屏幕坐标y
		 *    
		 **/
		protected var locy:Number;
		/**   
		 * 柱形图原始的屏幕坐标x
		 *    
		 **/
		protected var uiTempX:Number;
		/**   
		 * 柱形图原始的屏幕坐标y
		 *    
		 **/
		protected var uiTempY:Number;
		/**   
		 * 显示信息的文本框
		 **/
		protected var txtInfo:Label;
		/**   
		 * 显示信息的外边框
		 **/
		protected var UiInfo:UIComponent=null;

		
		public function NewChartColumn()
		{
		}
		/**
		 *文本填充内容
		 */
		public function get txtContent():String
		{
			return _txtContent;
		}
		/**
		 *文本填充内容
		 */
		public function set txtContent(value:String):void
		{
			_txtContent = value;
			if(txtInfo!=null){
				txtInfo.text=_txtContent;
			}
			
		}
		
		/**   
		 * 绘制柱形图
		 *    
		 * */   
		public function initDraw():void{  
			if(this.isLogicFlag==true){
				if(this.imsmap!=null){
					if(isNaN(this.logicCenterX)==false&&isNaN(this.logicCenterY)==false){
						var logScreen:Point=this.imsmap.logicToScreen(this.logicCenterX,this.logicCenterY);	
						this.CenterX=logScreen.x;
						this.CenterY=logScreen.y;
					}
				}
			}
			
			if(ui!=null){
				ui.graphics.clear();
			}
			if(ui==null){
				ui=new UIComponent();
				ui.visible=true;
				this.imsmap.addElement(ui);
				this.imsmap.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				this.ui.addEventListener(MouseEvent.MOUSE_OVER,onUImouseOVer);
				this.imsmap.addEventListener(IMSMapEvent.MAP_ZOOMOVER,onMapZoomHanle);
				this.imsmap.addEventListener(IMSMapEvent.MAP_MOVEOVER,onMapZoomHanle);
			}
			//添加柱形图的详细信息Label
			if(txtInfo!=null){
				this.imsmap.removeElement(this.txtInfo);
				txtInfo=null;
			}
			if(txtInfo==null){
				txtInfo = new Label();
				txtInfo.x = CenterX+chartWidth/3;
				if(txtInfoHeight>=8){
					txtInfo.y = CenterY-chartHeight/2-rateHeiht-txtInfoHeight-4;
				}else{
					txtInfo.y = CenterY-chartHeight/2-rateHeiht-txtInfoHeight;
				}
				txtInfo.text = _txtContent;
				txtInfo.setStyle("textAlign",TextAlign.CENTER);
				txtInfo.setStyle("verticalAlign",VerticalAlign.MIDDLE);
				txtInfo.height =txtInfoHeight; 
				txtInfo.width=txtInfoWidth;
				this.imsmap.addElement(this.txtInfo);
				this.txtInfo.addEventListener(MouseEvent.MOUSE_OVER,onUImouseOVer);
			}
			
			//绘制柱形图
			ui.graphics.beginFill(fillColor,fillAlpha);  
			ui.graphics.lineStyle(borderThickness,borderColor,borderAlpha);   
			ui.graphics.moveTo(CenterX-chartWidth*2/3,CenterY+chartHeight/2-rateHeiht);
			ui.graphics.lineTo(CenterX-chartWidth*2/3,CenterY+chartHeight/2);   
			ui.graphics.lineTo(CenterX+chartWidth/3,CenterY+chartHeight/2);
			ui.graphics.lineTo(CenterX+chartWidth*2/3,CenterY-chartHeight/2);   
			ui.graphics.lineTo(CenterX+2*chartWidth/3,CenterY-chartHeight/2-rateHeiht);
			ui.graphics.lineTo(CenterX-chartWidth/3,CenterY-chartHeight/2-rateHeiht);   
			ui.graphics.lineTo(CenterX-chartWidth*2/3,CenterY+chartHeight/2-rateHeiht);
			ui.graphics.endFill();
			ui.graphics.lineTo(CenterX+chartWidth/3,CenterY+chartHeight/2-rateHeiht);  
			ui.graphics.lineTo(CenterX+chartWidth/3,CenterY+chartHeight/2);
			ui.graphics.lineTo(CenterX+chartWidth/3,CenterY+chartHeight/2-rateHeiht);
			ui.graphics.lineTo(CenterX+2*chartWidth/3,CenterY-chartHeight/2-rateHeiht); 
			
			
			if(UiInfo!=null){
				UiInfo.graphics.clear();
			}
			if(UiInfo==null){
				UiInfo=new UIComponent();
				UiInfo.visible=true;
				this.imsmap.addElement(this.UiInfo);
				this.UiInfo.addEventListener(MouseEvent.MOUSE_OVER,onUImouseOVer);
			}
		
			UiInfo.graphics.lineStyle(txtBorderThick,txtBorderColor,txtBorderAlpha);   
			UiInfo.graphics.moveTo(CenterX,CenterY-chartHeight/2-rateHeiht-1);
			UiInfo.graphics.lineTo(CenterX+chartWidth/3,CenterY-chartHeight/2-rateHeiht-10); 
			
			UiInfo.graphics.lineTo(CenterX+chartWidth/3,CenterY-chartHeight/2-rateHeiht-txtInfoHeight);
			UiInfo.graphics.lineTo(CenterX+chartWidth*2/3+txtInfoWidth,CenterY-chartHeight/2-rateHeiht-txtInfoHeight);
			UiInfo.graphics.lineTo(CenterX+chartWidth*2/3+txtInfoWidth,CenterY-chartHeight/2-rateHeiht-8);
			UiInfo.graphics.lineTo(CenterX+chartWidth*2/3,CenterY-chartHeight/2-rateHeiht-8);
			UiInfo.graphics.lineTo(CenterX,CenterY-chartHeight/2-rateHeiht-1);
		}
		
		/**   
		 * 鼠标在地图上按下事件回调函数
		 *    
		 **/
		protected function onMouseDown(e:MouseEvent):void{
			if(this.imsmap.isMouseDown)
			{
			this.locx=this.imsmap.mouseDownScrPnt.x;
			this.locy=this.imsmap.mouseDownScrPnt.y;
			this.uiTempX=this.CenterX;
			this.uiTempY=this.CenterY;
			this.imsmap.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			this.imsmap.addEventListener(MouseEvent.MOUSE_UP,onMouseUP);
			}
		}
		/**   
		 * 鼠标在地图上按下后移动鼠标事件回调函数
		 *    
		 **/ 
		protected function onMouseMove(e:MouseEvent):void{
			if(this.imsmap.operType==IMSOperType.Drag&&this.imsmap.isMouseDown){
				this.imsmap.useHandCursor=true;
				this.imsmap.buttonMode=true;
				this.imsmap.mouseChildren=false;
				var dx:Number=this.imsmap.contentMouseX-locx;
				var dy:Number=this.imsmap.contentMouseY-locy;
				this.CenterX=uiTempX+dx;
				this.CenterY=uiTempY+dy;
				isLogicFlag=false;
				initDraw();
				var logPnt:Point=this.imsmap.screenToLogic(this.CenterX,this.CenterY);
				this.logicCenterX=logPnt.x;
				this.logicCenterY=logPnt.y;
			}
		}
		/**   
		 * 鼠标在地图上按下后鼠标弹起事件回调函数
		 *    
		 **/ 
		protected function onMouseUP(e:MouseEvent):void{
			if(this.imsmap.operType==IMSOperType.Drag){
				this.imsmap.useHandCursor=false;
				this.imsmap.buttonMode=false;
				this.imsmap.mouseChildren=true;
				this.imsmap.isMouseDown=false;
			}
			
			this.imsmap.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			this.imsmap.removeEventListener(MouseEvent.MOUSE_UP,onMouseUP);
		}
		/**   
		 * 地图放大缩小回调函数
		 *    
		 **/ 
		protected function onMapZoomHanle(e:Event):void{
			this.isLogicFlag=true;
			this.initDraw();
		}
	
		/**   
		 * 鼠标移动到柱形图上事件回调
		 *    
		 **/ 
		protected function onUImouseOVer(e:Event):void{
			if(this.imsmap!=null){
				if(this.ui!=null){
					this.imsmap.removeElement(ui);
					this.imsmap.addElement(ui);
				}
				if(this.UiInfo!=null){
					this.imsmap.removeElement(UiInfo);
					this.imsmap.addElement(UiInfo);
				}
				if(this.txtInfo!=null){
					this.imsmap.removeElement(txtInfo);
					this.imsmap.addElement(txtInfo);
				}
			}
		}
		
		/**   
		 * 图形增长
		 *    
		 **/
		public function increaseChart():void
		{
			rateHeiht=rateHeiht+rate;
			if(rateHeiht>=0){
				this.initDraw();
			}else{
				rateHeiht=0;
			}
		}
		/**   
		 * 图形重绘
		 *    
		 **/
		public function reDrawChart():void{
			initDraw();
		}
		/**   
		 * 清除柱形图
		 *    
		 **/
		public function clearChart():void{
			if(this.imsmap!=null){
				if(this.ui!=null){
					this.imsmap.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
					this.ui.removeEventListener(MouseEvent.MOUSE_OVER,onUImouseOVer);
					this.UiInfo.removeEventListener(MouseEvent.MOUSE_OVER,onUImouseOVer);
					this.txtInfo.removeEventListener(MouseEvent.MOUSE_OVER,onUImouseOVer);
					this.imsmap.removeEventListener(IMSMapEvent.MAP_ZOOMOVER,onMapZoomHanle);
					this.imsmap.removeEventListener(IMSMapEvent.MAP_MOVEOVER,onMapZoomHanle);
					this.imsmap.removeElement(this.ui);
					this.imsmap.removeElement(this.UiInfo);
					this.imsmap.removeElement(this.txtInfo);
					this.ui=null;
					this.UiInfo=null;
					this.txtInfo=null;
				}
			}
			
		}
	}
}