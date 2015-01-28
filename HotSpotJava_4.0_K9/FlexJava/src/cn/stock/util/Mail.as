package cn.stock.util
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import mx.formatters.DateFormatter;
	
	
	public class Mail
	{
		private var socket:Socket;
		private var isLogin:Boolean=false;
		private var smtp:String;
		
		public function Mail(smtp:String){
			initSocket(smtp);
		}
		
		public function initSocket(smtp:String){
			this.smtp=smtp;
			if(socket==null ||!socket.connected){
				socket = new Socket();				 
				socket.connect(smtp,25);
				socket.addEventListener(Event.CONNECT,connectionFun);
				socket.addEventListener(Event.CLOSE,closeFun);
				socket.addEventListener(ProgressEvent.SOCKET_DATA,receiveMsg);
				socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);
			}
		}	
		private function handleError(event:SecurityErrorEvent):void{
			trace("security handle");
		}
		public function connectionFun(event:Event):void{
			trace("已经成功连接到服务器");
		}
		public  function closeFun(event:Event):void{
			isLogin=false;
			trace("已经断开服务器");
		}
		function receiveMsg(event:Event):void{
			var msg:String='';
			while (socket.bytesAvailable){
				msg+=socket.readMultiByte(socket.bytesAvailable,"utf8");
			}
			trace(msg);
		}
		public function send(user:String,pwd:String,mailForm:String,mailTo:String,subject:String,content:String):void{
			if(socket==null ||!socket.connected){
				initSocket(this.smtp);
			}
			sendMessage("HELO mail");
			if(!isLogin){
				sendMessage("AUTH LOGIN");
	//			sendMessage(Base64.encode(user));
	//			sendMessage(Base64.encode(pwd));
				isLogin=true;
			}
			sendMessage("MAIL FROM: <"+mailForm+">");
			sendMessage("RCPT TO: <"+mailTo+">");
			sendMessage("DATA");
			var dateFormatter:DateFormatter =new DateFormatter();
			dateFormatter.formatString="yyyy-mm-dd";
			sendMessage("Date: "+dateFormatter.format(new Date()));
			sendMessage("From: "+mailForm);
			sendMessage("To: "+mailTo);
			sendMessage("Content-Type: text/html");
			sendMessage("Subject: "+subject); 
			sendMessage("");sendMessage("");
			sendMessage(content);
			sendMessage(".");
		}
		internal function sendMessage(msg:String):void{
			var message:ByteArray=new ByteArray();
			message.writeUTFBytes(msg+"\r\n");
			socket.writeBytes(message);
			socket.flush();
		}
	}
}