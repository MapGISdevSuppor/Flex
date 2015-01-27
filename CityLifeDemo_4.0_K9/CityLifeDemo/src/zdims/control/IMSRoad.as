/**
* 路径类
*/
package zdims.control
{
	import Mapgis7.WebService.BasLib.Dot_2D;
	import Mapgis7.WebService.BasLib.Rect;
	
	import flash.debugger.enterDebugger;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Endian;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.states.AddChild;
	import mx.states.AddItems;
	
	import myControls.Mark;
	
	import org.osmf.events.TimeEvent;
	
	import zdims.drawing.GraphicsLayer;
	import zdims.drawing.IMSPolyline;
	import zdims.event.IMSMapEvent;
	import zdims.event.IMSMapMoveEvent;
	import zdims.map.OverlayObject;
	import zdims.util.IMSOperType;
	
	/**
	 * 路径类
	 * @author shiyanting
	 */
	public class IMSRoad extends OverlayObject
	{
		private var dotArr:Array;
		private var dotNum:Number = 0;
		private var image:Mark;  
		private var busline:IMSPolyline=new IMSPolyline();
		private var graphicslayer:GraphicsLayer=new GraphicsLayer();
		private var xspace:Number = 0;
		private var yspace:Number = 0;
		private var flag:Boolean=true;
		private var xdistance:Number = 0;
		private var ydistance:Number = 0;
		private var wxy:Point;
		private var _timer:Timer;
		private var dis:Number = 0;
		private var nums:Number=2;
		private var last_X:Number;
		private var last_Y:Number;
		
		private var index:int=0;
        private var dots:Array=new Array();
		private var timer:Timer=new Timer(500);
		private var mark:Mark=new Mark();
		private var arr:Array=new Array();
		private var arragle:Array = new Array();
		private var dot:Point=new Point();
		private var lastDot:Point=new Point();
		private var endDot:Point=new Point();
		private var firstDot:Point=new Point();
		
		
		/**
		 * 构造函数
		 * @param container
		 */
		public function IMSRoad()
		{
			this._stopIcon = new Array();
		}
		/**
		 * 路径坐标数组
		 * @default
		 */
		public var _roadCoorArr:String = "";
		/**
		 * 公交站点图片数组
		 * @default
		 */
		public var _stopIcon:Array;
		/**
		 * 颜色值
		 * @default
		 */
		public var borderColor:uint = 0x0000ff;
		/**
		 * 大小
		 * @default
		 */
		public var borderSize:uint = 4;
		/**
		 * 透明度
		 * @default
		 */
		public var fillAlpha:Number = 0.5;
		/**
		 * 是否允许填充颜色，如果该值为TRUE,则将绘制带填充颜色的多边形。
		 */		
		public var enableFill:Boolean=false;
		/**
		 * 填充颜色
		 */		
		public var fillColor:uint=0xff0000;
		/**
		 * 设置点坐标数据
		 * 
		 */		
		public function setDots(dots1:Array):void
		{
			this._roadCoorArr="";
			if(dots1==null||dots1.length==0)
				return;
			for(var i:int=0;i<dots1.length;i++)
			{		
				this._roadCoorArr+=dots1[i].x+","+dots1[i].y+",";
			}
		}
		/**
		 * 根据矩形范围设置点坐标数据
		 * 
		 */		
		public function setDotsFromRect(rect:Rect):void
		{
			this._roadCoorArr="";
			if(rect!=null)
			this._roadCoorArr+=rect.xmin+","+rect.ymax+","+rect.xmax+","+rect.ymax+",";
			this._roadCoorArr+=rect.xmax+","+rect.ymin+","+rect.xmin+","+rect.ymin+",";
			this._roadCoorArr+=rect.xmin+","+rect.ymax+",";
		}
		/**
		 * 添加路径点
		 * @param name
		 * @param logicX
		 * @param logicY
		 * @param seq
		 * @param iconSrc
		 * @param showName
		 */
		public function addNode(name:String, logicX:Number, logicY:Number, seq:Number, iconSrc:String, showName:Boolean=true):void
		{
			var stopNode:Marker = new Marker();
			stopNode.name = name;
			stopNode.toolTip = name;
			stopNode.logicX = logicX;
			stopNode.logicY = logicY;
			stopNode.setIconSrc(iconSrc);
			stopNode.visible = false;
			stopNode.enableShowName = showName;
			stopNode.imsmap=this.imsmap;
			stopNode.updatePosition();
			this._stopIcon[this._stopIcon.length] = this.imsmap.addChildAt(stopNode,this.imsmap.layerLenth+2);
		}

		/**
		 * 清除绘制路径点
		 */
		public function clear():void
		{
			this.graphics.clear();
			this.visible = false;
			arr=new Array();
			arragle=new Array();
			firstDot=new Point();
			if( image!=null&&this.imsmap.contains(image))
			{
				this.imsmap.removeChild(image);
			}
			//set the stop icon visible
			for (var i:int = 0; i < this._stopIcon.length; i++)
			{
				UIComponent(this._stopIcon[i]).visible = false;
			}
		}

		/**
		 * 重置路径点
		 */
		public function dispose():void
		{
			this.graphics.clear();
			this.visible = false;
			for (var i:int = 0; i < this._stopIcon.length; i++)
			{
				this.imsmap.removeChild(this._stopIcon[i]);
			}
		}

		/**
		 * 绘制路径点
		 */
		public function drawRoad():void
		{
			if (this.imsmap == null)
			{
				Alert.show("地图容器属性为空，请赋值！", "提示");
				return;
			}
			this.graphics.clear();
			if (!this.imsmap.contains(this as DisplayObject))
				this.imsmap.addChildAt(this, this.imsmap.layerLenth+2);
			this.graphics.lineStyle(borderSize, borderColor);
			 dotArr = this._roadCoorArr.split(",");
			 dotNum = dotArr.length;
			 
			if(this.enableFill)
				this.graphics.beginFill(this.fillColor,this.fillAlpha);
			
			for (var i:int = 0; i < dotNum - 1; i+=2)
			{
				if (dotArr[i] == "" || dotArr[i] == "undefined")
					continue;
				var wxy:Point = this.imsmap.logicToScreen(dotArr[i], dotArr[i + 1]);
				if (i == 0)
				{
					this.graphics.moveTo(wxy.x, wxy.y);
					
				}
				else
					this.graphics.lineTo(wxy.x, wxy.y);
			}
			if(this.enableFill)
				this.graphics.endFill();
			this.visible = true;
			//set the stop icon visible
			for (i = 0; i < this._stopIcon.length; i++)
			{
				UIComponent(this._stopIcon[i]).visible = true;
			}
		}

		/**
		 *获取两点间坐标数组
		 */
		private function serlizePoint():void
		{
			for(var i:int=0;i<dots.length-1;i++)
			{
				var pStart:Point = dots[i];
				var pEnd:Point = dots[i+1];
				var ss:Number =Math.pow((pStart.x-pEnd.x),2);
				var aa:Number = Math.pow((pStart.y-pEnd.y),2); 
				var distance:Number = Math.sqrt(ss+aa);
				var xDircettionDis:Number =0.0;
				var step:Number=0.0003;
				var offsetX:Number;
				if (pEnd.x < pStart.x) { xDircettionDis = pStart.x - pEnd.x; }
				else if (pEnd.x > pStart.x) { xDircettionDis = pEnd.x - pStart.x; }
				offsetX = step * xDircettionDis / distance;
				// 求出两点之间直线的斜率
				var k:Number = (pEnd.y - pStart.y) / (pEnd.x - pStart.x);
				var agle:Number = angle(pStart, pEnd);
				// 判断结束点在开始点的左边(步长为负)还是右边(步长为正)
				// 结束点在起始点的右方，步长应该为正
				if (pEnd.x > pStart.x)
				{
					// 取得该段线段的起点
					var tempX:Number = pStart.x;
					var xdis:Number=Math.sqrt(image.height*image.height/(1+k*k));
					// 按步长取出每点对应的Y坐标，并构造成点添加到LIST里
					while (tempX <= pEnd.x)
					{
						// 取得点的X坐标 // 根据直线方程取得点的Y坐标
						var xdis:Number=Math.sqrt(image.height*image.height/(1+k*k));
						var pnt:Point = new Point(tempX, k * tempX - k * pStart.x + pStart.y);
						arr.push(pnt);
						arragle.push(agle);
						tempX = tempX + offsetX;
					}
					 pnt = new Point(pEnd.x, k * pEnd.x - k * pStart.x + pStart.y);
					arr.push(pnt);
					arragle.push(agle);
					
				}
					// 结束点在起始点的左方，步长应该为负
				else if (pEnd.x < pStart.x)
				{
					// 取得该段线段的起点
					var tempX:Number = pStart.x;
					var xdis:Number=Math.sqrt(image.height*image.height/(1+k*k));
					// 按步长取出每点对应的Y坐标，并构造成点添加到LIST里
					while (tempX >= pEnd.x)
					{
						var pnt:Point = new Point(tempX, k * tempX - k * pStart.x + pStart.y);
						arr.push(pnt);
						arragle.push(agle);
						tempX = tempX - offsetX;
					}
					 pnt = new Point(pEnd.x, k * pEnd.x - k * pStart.x + pStart.y);
					arr.push(pnt);
					arragle.push(agle);
				}
			}
		}
		
		/**
		 *计算旋转角度
		 */
		private function angle(pStart:Point, pEnd:Point):Number
		{
			var tanVl:Number = 0.0;
			var angle:Number = 0.0;
			var ParaX:Number = pEnd.x - pStart.x;
			var ParaY:Number = pEnd.y - pStart.y;
			if(!flag)//从右向左画线
			{
				if (ParaX >0&&ParaY!=0)//向量线在一、四象限
				{
					tanVl = ParaY / ParaX;
					angle =Math.PI -Math.atan(tanVl);
				}
				//向量线垂直于X轴，方向向上
				if (ParaX == 0 && ParaY > 0)
				{
					angle = Math.PI/2;
				}
				//向量线垂直于X轴，方向向下
				if (ParaX == 0 && ParaY < 0)
				{
					angle =- Math.PI/2;
				}
				//二、三象限
				if (ParaX < 0 && ParaY != 0)
				{
					tanVl = ParaY / ParaX;
					angle = -Math.atan(tanVl);
				}
				//向量线平行于x轴，方向向左
				if (ParaY == 0 && ParaX < 0)
				{
					angle =0;
				}
				//向量线平行于x轴，方向向右
				if (ParaY == 0 && ParaX > 0)
				{
					angle =  -Math.PI;
				}
				if(ParaX==0&&ParaY==0)
				{
					angle=0;
				}
			}
			else
			{//从左向右画线
				if (ParaX >0&&ParaY!=0)//向量线在一、四象限
				{
					tanVl = ParaY / ParaX;
					angle =-Math.atan(tanVl);
				}
				//向量线垂直于X轴，方向向上
				if (ParaX == 0 && ParaY > 0)
				{
					angle = -Math.PI/2;
				}
				//向量线垂直于X轴，方向向下
				if (ParaX == 0 && ParaY < 0)
				{
					angle =  Math.PI/2;
				}
				//二、三象限
				if (ParaX < 0 && ParaY != 0)
				{
					tanVl = ParaY / ParaX;
					angle =Math.PI-Math.atan(tanVl);
				}
				//向量线平行于x轴，方向向左
				if (ParaY == 0 && ParaX < 0)
				{
					angle =Math.PI;
				}
				//向量线平行于x轴，方向向右
				if (ParaY == 0 && ParaX > 0)
				{
					angle =  0;
				}
				if(ParaX==0&&ParaY==0)
				{
					angle=0;
				}
			}
			return angle;
		}
		public function showFlash():void
		{
			//清除公交线路上的图标
//			for (i = 0; i < this._stopIcon.length; i++)
//			{
//				UIComponent(this._stopIcon[i]).visible = false;
//			}
			//公交动画
			if (this.imsmap == null)
			{
				Alert.show("地图容器属性为空，请赋值！", "提示");
				return;
			}
			if( image!=null&&this.imsmap.contains(image))
			{
				this.imsmap.removeChild(image);
			}
			timer.removeEventListener(TimerEvent.TIMER,onFlashTimer);
			arragle=new Array();
			arr=new Array();
			this.graphics.clear();//清除前一次绘制的路线
			if (!this.imsmap.contains(this as DisplayObject))
				this.imsmap.addChildAt(this, this.imsmap.layerLenth+2);
			this.graphics.lineStyle(borderSize, borderColor);

			index=0;
			var dotArr1:Array = this._roadCoorArr.split(",");
			var dotNum1:Number = dotArr1.length;
			//筛选坐标数组，去除有误差的点
			for (var i:int=0;i<dotNum1-1;i+=2)
			{
				if(i<2||i>=dotNum1-3)
				{
					dotArr[i]=dotArr1[i];
					dotArr[i+1]=dotArr1[i+1];
				}
				else 
				{
					if(dotArr1[i-2]==dotArr1[i+2]&&dotArr1[i-2]!=dotArr1[i])
					{
						dotArr[i]=dotArr1[i-2];
						dotArr[i+1]=dotArr1[i-1];
					}
					else
					{
						dotArr[i]=dotArr1[i];
						dotArr[i+1]=dotArr1[i+1];
					}
				}
			}
			dotNum=dotArr.length;
			lastDot=new Point();
			firstDot=new Point();
			var j:int = 1;
			if(this.enableFill)
				this.graphics.beginFill(this.fillColor,this.fillAlpha);
			for (var i:int = 0; i < dotNum - 1; i+=2)
			{
				if (dotArr[i] == "" || dotArr[i] == "undefined")
					continue;
				 wxy = this.imsmap.logicToScreen(dotArr[i], dotArr[i+1]);
				if (i == 0)
				{
					this.graphics.moveTo(wxy.x, wxy.y);
					last_X=wxy.x;
					last_Y=wxy.y;
					firstDot.x=wxy.x;
					firstDot.y=wxy.y;
					dot.x=dotArr[i];
					dot.y=dotArr[i+1];
					dots[0]=dot;
				}
				else
				{
					this.graphics.lineTo(wxy.x, wxy.y);
					dot=new Point();
					dot.x=dotArr[i];
					dot.y=dotArr[i+1];
					dots[j++]=dot;
				}
			}
			endDot=new Point();
			endDot.x=wxy.x;
			endDot.y=wxy.y;
			image=new Mark();
			if(firstDot.x<endDot.x) 
			{//从左向右画线
				flag=true;
				image.setIconSrc("image/bus/car1.png",0);
				
			}
			else
			{//从右向左画线
				flag=false;
				image.setIconSrc("image/bus/car2.png",0);
			}
			image.width=30;
			image.height=15;
			this.imsmap.addChild(image);
			serlizePoint();//获取两点间坐标数组

			if(this.enableFill)
				this.graphics.endFill();
			this.visible = true;
			
			timer = new Timer(150);
			timer.addEventListener(TimerEvent.TIMER,onFlashTimer);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onFlashComplete);
			timer.start();
		}
		private function onFlashComplete(e:TimerEvent):void
		{
			Timer(e.target).stop();
		}
		
		/**
		 *公交动画回调函数
		*/
		private function onFlashTimer(e:TimerEvent):void
		{
			var lastangle:Number=0;					
			var time:int=timer.currentCount;	
			if(index==0)
			{
				//平移图片，使之始终沿线运动
				var coor:Point = this.imsmap.logicToScreen(arr[0].x, arr[0].y);
				image.x=coor.x+image.height*(Math.sin(arragle[index]));
				image.y=coor.y-image.height*(Math.cos(arragle[index]));
                
				//旋转图片
				var m:Matrix = image.transform.matrix;				
				var p:Point = m.transformPoint(new Point(image.width/2, image.height/2));
				m.translate(-p.x, -p.y);
				m.rotate(this.arragle[index]);//(angle(lastDot,thisdot));
				m.translate(p.x, p.y);
				image.transform.matrix = m;

				index++;
			}
			if(index<arr.length)
			{
				//平移图片，使之始终沿线运动
				var coor:Point = this.imsmap.logicToScreen(arr[index].x, arr[index].y);
				image.x=coor.x+image.height*(Math.sin(arragle[index]));
				image.y=coor.y-image.height*(Math.cos(arragle[index]));

				//旋转图片
				var m:Matrix = image.transform.matrix;
				var p:Point = m.transformPoint(new Point(image.width/2, image.height/2));
				m.translate(-p.x, -p.y);
				m.rotate(this.arragle[index]-this.arragle[index-1]);//(angle(lastDot,thisdot));
				m.translate(p.x, p.y);
				image.transform.matrix = m;
				
				//如果绘制的线条跑到屏幕以外，移动地图，使动画始终在视域内
				if (imsmap.winViewBound.xMin > arr[index].x||
					imsmap.winViewBound.yMin > arr[index].y||
					imsmap.winViewBound.xMax < arr[index].x||
					imsmap.winViewBound.yMax < arr[index].y)
				{
					imsmap.panTo(arr[index].x,arr[index].y);
				}
				index++;
			}
			else
			{
				//轨迹回放完毕，移除图片
				if( image!=null&&this.imsmap.contains(image))
				{
					this.imsmap.removeChild(image);	
				}
				timer.removeEventListener(TimerEvent.TIMER,onFlashTimer);
			}
		}
	   
		/**
		 * 更新位置信息
		 */
		public override function updatePosition(e:Event=null):void
		{
			if(!enableUpdatePosition)
				return;
			if(e is IMSMapMoveEvent)
			{
				if(this.imsmap.operType==IMSOperType.Drag)
				{
					var xLen:int=this.imsmap.mouseMoveScrPnt.x - this.imsmap.mouseDownScrPnt.x;
                	var yLen:int=this.imsmap.mouseMoveScrPnt.y - this.imsmap.mouseDownScrPnt.y;
                	this.x =this.oldx+xLen;
                    this.y = this.oldy+yLen;
				}
				return;
			}
			this.oldx=this.x = 0;
			this.oldy=this.y = 0;
			
			if (this.visible)
			{
				this.drawRoad();
				if(e is IMSMapEvent)
				{
				}
			}
		}
	}
}