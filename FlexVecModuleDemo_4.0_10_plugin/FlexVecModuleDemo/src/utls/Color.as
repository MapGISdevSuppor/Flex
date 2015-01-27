package utls
{
	public class Color
	{
		private var _b:Number;
		
		private var _r:Number;
		
		private var _g:Number;
		
		public function Color(arg1:Number)
		{
			super();
			this._r = arg1 >> 16;
			this._g = (arg1 & 65280) >> 8;
			this._b = arg1 & 255;
			return;
		}
		
		public function get b():Number
		{
			return Math.round(this._b);
		}
		
		public static function fromObject(arg1:Object):Color
		{
			return arg1 == null ? null : new Color(arg1.rgb);
		}
		
		public function set r(arg1:Number):void
		{
			this._r = arg1 > 255 ? 255 : arg1 < 0 ? 0 : arg1;
			return;
		}
		
		public function get g():Number
		{
			return Math.round(this._g);
		}
		
		private static function bound(arg1:Number, arg2:Number=NaN, arg3:Number=NaN):Number
		{
			if (!isNaN(arg2)) 
			{
				arg1 = Math.max(arg1, arg2);
			}
			if (!isNaN(arg3)) 
			{
				arg1 = Math.min(arg1, arg3);
			}
			return arg1;
		}
		
		public static function toHtml(arg1:Number):String
		{
			if (!("number" == "number") || isNaN(arg1)) 
			{
				arg1 = 0;
			}
			var loc1:*="#000000";
			var loc2:*=Math.floor(bound(arg1, 0, 16777215));
			var loc3:*=loc2.toString(16);
			return loc1.substr(0, 7 - loc3.length) + loc3;
		}
		
		public function set b(arg1:Number):void
		{
			this._b = arg1 > 255 ? 255 : arg1 < 0 ? 0 : arg1;
			return;
		}
		
		public function toString():String
		{
			return "R:" + this.r + "/G:" + this.g + "/B:" + this.b;
		}
		
		public function set g(arg1:Number):void
		{
			this._g = arg1 > 255 ? 255 : arg1 < 0 ? 0 : arg1;
			return;
		}
		
		public function incRGB(arg1:Number, arg2:Number, arg3:Number):void
		{
			this.r = this._r + arg1;
			this.g = this._g + arg2;
			this.b = this._b + arg3;
			return;
		}
		
		public function get r():Number
		{
			return Math.round(this._r);
		}
		
		public function get rgb():Number
		{
			return (this.r << 16) + (this.g << 8) + this.b;
		}
		
		public function setRGB(arg1:Number, arg2:Number, arg3:Number):void
		{
			this.r = arg1;
			this.g = arg2;
			this.b = arg3;
			return;
		}
		
		public static const GRAY14:Number=14737632;
		
		public static const GRAY10:Number=10526880;
		
		public static const GRAY7:Number=7368816;
		
		public static const GRAY13:Number=13684944;
		
		public static const GRAY15:Number=15790320;
		
		public static const MAGENTA:Number=16711935;
		
		public static const GRAY11:Number=11579568;
		
		public static const GRAY12:Number=12632256;
		
		public static const WHITE:Number=16777215;
		
		public static const BLUE:Number=255;
		
		public static const DEFAULTLINK:Number=7829452;
		
		public static const BLACK:Number=0;
		
		public static const GREEN:Number=65280;
		
		public static const CYAN:Number=65535;
		
		public static const GRAY1:Number=1052688;
		
		public static const GRAY2:Number=2105376;
		
		public static const GRAY3:Number=3158064;
		
		public static const RED:Number=16711680;
		
		public static const GRAY5:Number=5263440;
		
		public static const GRAY6:Number=6316128;
		
		public static const YELLOW:Number=16776960;
		
		public static const GRAY8:Number=8421504;
		
		public static const GRAY9:Number=9474192;
		
		public static const GRAY4:Number=4210752;	
		
	}
}