/**
 *数据文件
 */
import flash.geom.Point;
import flash.utils.Dictionary;

import mx.collections.ArrayCollection;

/**
 *标签数组
 */
[Bindable]
public var labelInfo:Array=new Array([
	"温哥华","华盛顿","巴西利亚",
	"巴马科","莫斯科"
]);
//public var labelInfo:Array=new Array([
//	"温哥华","华盛顿","基多","巴西利亚",
//	"温得和克","开罗","莫斯科","北京",
//	"新加坡","堪培拉"
//]);
//labelInfo.push("温哥华");
//labelInfo.push("华盛顿");
//labelInfo.push("基多");
//labelInfo.push("巴西利亚");

/**
 *坐标数组
 */
[Bindable]
public var positionInfo:Array=new Array([
	{x:-122.995850187958,y:49.31925247766244},{x:-76.96333753185513,y:38.94447278589375},
	{x:-47.93359120189035,y:-15.786919655279648},{x:-8.007674098072965,y:12.672907851195195},
	{x:37.695301337318895,y:55.79601312718498}
     ]);
//public var positionInfo:Array=new Array([
//	{x:-122.995850187958,y:49.31925247766244},{x:-76.96333753185513,y:38.94447278589375},{x:-78.5433105078669,y:-0.190329277792042},
//	{x:-47.93359120189035,y:-15.786919655279648},{x:17.08003965674247,y:-22.539047023478503},{x:31.244497386687982,y:30.105652537233617},
//	{x:37.695301337318895,y:55.79601312718498},{x:116.37569843845353,y:39.956784042667},{x:104.16815009451116,y:1.2598602037616153},
//	{x:149.00326894522223,y:-35.32102839941372}
//]);
//positionInfo.push(new Point(114.184,30.595));
//positionInfo[1]=new Point(114.231,30.585);
//positionInfo[2]=new Point(114.229,30.545);
//positionInfo[3]=new Point(114.260,30.529);

/**
 *统计字段
 */
[Bindable]
public var dataInfo:ArrayCollection=new ArrayCollection([
	{label:'x1',value:'25'},{label:'x2',value:'15'},{label:'x3',value:'30'}
    ]);