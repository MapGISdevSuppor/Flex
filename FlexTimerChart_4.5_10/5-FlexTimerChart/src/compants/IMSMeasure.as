package compants
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.controls.Alert;
	import mx.controls.Text;
	
	import zdims.control.IMSPoint;
	import zdims.event.IMSMapEvent;
	import zdims.event.IMSMapMouseEvent;
	import zdims.map.OverlayObject;
	import zdims.util.IMSOperType;
	
	public class IMSMeasure extends OverlayObject
	{
		private var measurePnts:Array = new Array();
		private var measureType:int;
		private var measureLabel:Text;
		private var newPntArr:Array=null;
		[Inspectable(category="MapGisIMS")]
		public var unitLength:Number = 1;

		
		/**
		 * 构造函数
		 */
		public function IMSMeasure()
		{
			super();
		}
		
		/**
		 * 设置测量类型
		 */ 
		public function setMeasureType(measureTp:String):void
		{
			if(newPntArr==null){
				newPntArr=new Array();
			}
			clearMeasurePnts(null);
			if (this.imsmap == null)
			{
				Alert.show("imsmap为空，请赋值！");
				return;
			}
			
			if (measureTp == "len")
			{
				this.imsmap.setCurOper(IMSOperType.MeasureDistance);
			}
			else if (measureTp == "area")
			{
				this.imsmap.setCurOper(IMSOperType.MeasureArea);
			}
			this.measureType = this.imsmap.operType;
			this.imsmap.addEventListener(IMSMapMouseEvent.MAP_MOUSEUP, addMeasurePoint);
			this.imsmap.addEventListener(IMSMapMouseEvent.MAP_DOUBLECLICK, clearMeasurePnts);
			this.imsmap.addEventListener(IMSMapEvent.MAP_OPERTYPECHANGE,onOperTypeChange);
		}
		
		private function onOperTypeChange(e:Event):void
		{
			newPntArr=null;
			this.imsmap.removeEventListener(IMSMapMouseEvent.MAP_MOUSEUP,addMeasurePoint);
			this.imsmap.removeEventListener(IMSMapMouseEvent.MAP_DOUBLECLICK, clearMeasurePnts);
			this.imsmap.removeEventListener(IMSMapEvent.MAP_OPERTYPECHANGE,onOperTypeChange);
		}
		/**
		 * 添加测量标记点
		 */ 
		public function addMeasurePoint(e:IMSMapMouseEvent):void
		{
			if (this.measureLabel == null)
			{
				this.measureLabel = new Text();
				this.measureLabel.text = "";
				this.measureLabel.name = "measureResultLabel";
				this.measureLabel.setStyle("fontSize", 12);
				this.measureLabel = this.imsmap.addChild(this.measureLabel) as Text;
			}
			var pnt:IMSPoint = new IMSPoint();
			pnt.fillAlpha = 0.2;
			pnt.borderSize = 1;
			pnt.radius = 4;
			pnt.logicX = this.imsmap.mouseDownLogicPnt.x;
			pnt.logicY = this.imsmap.mouseDownLogicPnt.y;
			pnt.visible = true;
			pnt.enableDrag = false;
			
			var radians:Number = (this.imsmap.mouseDownLogicPnt.y)* Math.PI/180
			var newLogicX:Number=(this.imsmap.mouseDownLogicPnt.x)*(111*Math.cos(radians));
			var newLogicY:Number=(this.imsmap.mouseDownLogicPnt.y)*111;
			
			var newLogicpnt:Point=new Point(newLogicX,newLogicY);
			if(newPntArr==null){
				newPntArr=new Array();
			}
			if(newPntArr!=null){
				this.newPntArr.push(newLogicpnt);
			}
			
			pnt.name="measurePoint" + this.measurePnts.length;
			this.measurePnts[this.measurePnts.length] = this.imsmap.addChild(pnt);
			pnt.updatePosition();
			pnt.enableUpdatePosition=false;
			this.measureLabel.text = this.measureType == IMSOperType.MeasureDistance ? getLength() : getArea();
			this.imsmap.setChildIndex(this.imsmap.getChildByName(this.measureLabel.name), this.imsmap.getChildren().length - 1);
			this.measureLabel.x = this.imsmap.contentMouseX;
			this.measureLabel.y = this.imsmap.contentMouseY;
		}
		
		/**
		 * 获取长度
		 */ 
		public function getLength():String
		{
			if (this.newPntArr.length < 2)
			{
				return "长度:0";
			}
			var pnt:Point = this.newPntArr[this.newPntArr.length - 1];
			var lastPnt:Point = this.newPntArr[this.newPntArr.length - 2];
			var length:Number = Math.sqrt(Math.pow(pnt.x - lastPnt.x, 2) + Math.pow(pnt.y - lastPnt.y, 2));
			
			return "长度(千米):" + (parseFloat(this.measureLabel.text.split(":")[1]) + length * this.unitLength).toString();
		}
		
		/**
		 * 获取面积
		 */ 
		public function getArea():String
		{
			if (this.newPntArr.length < 3)
			{
				return "面积:0";
			}
			var points:Array=newPntArr;
			var dotNum:int = points.length - 1;
			var area:Number = 0;
			var j:int;
			var xjyi:Number;
			var xiyj:Number;
			var xydiff:Number;
			j = dotNum;
			
			for (var i:int = 0; i <= dotNum; i++)
			{
				xiyj = points[i].x * points[j].y;
				xjyi = points[j].x * points[i].y;
				xydiff = (xiyj - xjyi);
				area += xydiff;
				j = i;
			}
			area = Math.abs(area / 2) * this.unitLength;
			return "面积(平方千米):" + area.toString();
		}
		/**
		 * 清除测量结果
		 */ 
		public function clearMeasurePnts(e:Event):void
		{
			for (var i:int = 0; i < this.measurePnts.length; i++)
			{
				this.imsmap.removeChild(this.imsmap.getChildByName(IMSPoint(this.measurePnts[i]).name));
			}
			this.measurePnts = new Array();
			this.imsmap.graphicCanvas.clearAll();
			this.imsmap.graphicCanvas.clear();
			this.imsmap.graphicCanvas.clearArray();
			if (this.measureLabel != null)
				this.measureLabel.text = "";
			
			newPntArr=null;
			this.imsmap.isMouseDown=false;
		}
		
	}
}