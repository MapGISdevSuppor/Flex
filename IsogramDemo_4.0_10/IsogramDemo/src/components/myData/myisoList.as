import mx.collections.ArrayCollection;

/**
 *数据文件
 */
//基于矢量图的等值线（面）
[Bindable]
public var isoLineList:ArrayCollection=new ArrayCollection([
	{mapname:"RltLine2006-05-01 20时",time:"2006-05-01L  20:00:00"},
	{mapname:"RltLine2006-04-27 20时",time:"2006-04-27L  20:00:00"},
	{mapname:"RltLine2006-04-25 22时",time:"2006-04-25L  22:00:00"},
	{mapname:"RltLine2006-04-23 08时",time:"2006-04-23L  08:00:00"},
	{mapname:"RltLine2006-04-18 08时",time:"2006-04-18L  08:00:00"},
	{mapname:"RltLine2006-04-11 20时",time:"2006-04-11L  20:00:00"},
	{mapname:"RltLine2006-04-10 20时",time:"2006-04-10L  20:00:00"},
	{mapname:"RltLine2006-04-09 08时",time:"2006-04-09L  08:00:00"},
	{mapname:"RltLine2006-04-07 08时",time:"2006-04-07L  08:00:00"},
	{mapname:"RltLine2006-04-04 20时",time:"2006-04-04L  20:00:00"},
	{mapname:"RltLine2006-04-03 14时",time:"2006-04-03L  14:00:00"}
]);

[Bindable]
private var isoGramList:ArrayCollection=new ArrayCollection([
	{mapname:"RltReg2006-05-07 20时",time:"2006-05-07g  20:00:00"},
	{mapname:"RltReg2006-05-01 20时",time:"2006-05-01g  20:00:00"},
	{mapname:"RltReg2006-04-28 20时",time:"2006-04-28g  20:00:00"},
	{mapname:"RltReg2006-04-27 20时",time:"2006-04-27g  20:00:00"},
	{mapname:"RltReg2006-04-25 22时",time:"2006-04-25g  22:00:00"},
	{mapname:"RltReg2006-04-25 20时",time:"2006-04-25g  20:00:00"},
	{mapname:"RltReg2006-04-24 20时",time:"2006-04-24g  20:00:00"},
	{mapname:"RltReg2006-04-23 08时",time:"2006-04-23g  08:00:00"},
	{mapname:"RltReg2006-04-18 08时",time:"2006-04-18g  08:00:00"},
	{mapname:"RltReg2006-04-11 20时",time:"2006-04-11g  20:00:00"},
	{mapname:"RltReg2006-04-10 20时",time:"2006-04-10g  20:00:00"},
	{mapname:"RltReg2006-04-09 08时",time:"2006-04-09g  08:00:00"},
	{mapname:"RltReg2006-04-07 08时",time:"2006-04-07g  08:00:00"},
	{mapname:"RltReg2006-04-05 20时",time:"2006-04-05g  20:00:00"},
	{mapname:"RltReg2006-04-04 20时",time:"2006-04-04g  20:00:00"},
	{mapname:"RltReg2006-04-03 14时",time:"2006-04-03g  14:00:00"}
]);

//基于预生成的等值线（面）
[Bindable]
public var isoLineListimg:ArrayCollection=new ArrayCollection([
	{imgname:"RltLine2006-5-8 8.gif",time:"2006-05-08  08:00:00"},
	{imgname:"RltLine2006-5-1 20.gif",time:"2006-05-01  20:00:00"},
	{imgname:"RltLine2006-4-27 20.gif",time:"2006-04-27  20:00:00"},
	{imgname:"RltLine2006-4-25 22.gif",time:"2006-04-25  22:00:00"},
	{imgname:"RltLine2006-4-23 8.gif",time:"2006-04-23  08:00:00"},
	{imgname:"RltLine2006-4-18 8.gif",time:"2006-04-18  08:00:00"},
	{imgname:"RltLine2006-4-11 20.gif",time:"2006-04-11  20:00:00"},
	{imgname:"RltLine2006-4-10 20.gif",time:"2006-04-10  20:00:00"},
	{imgname:"RltLine2006-4-9 8.gif",time:"2006-04-09  08:00:00"},
	{imgname:"RltLine2006-4-7 8.png",time:"2006-04-07  08:00:00"},
	{imgname:"RltLine2006-4-4 20.gif",time:"2006-04-04  20:00:00"},
	{imgname:"RltLine2006-4-3 14.gif",time:"2006-04-03  14:00:00"}
]);

[Bindable]
private var isoGramListimg:ArrayCollection=new ArrayCollection([
	{imgname:"RltReg2006-5-7 20.gif",time:"2006-05-07g  20:00:00"},
	{imgname:"RltReg2006-5-1 20.gif",time:"2006-05-01g  20:00:00"},
	{imgname:"RltReg2006-4-28 20.gif",time:"2006-04-28  20:00:00"},
	{imgname:"RltReg2006-4-25 22.gif",time:"2006-05-01  22:00:00"},
	{imgname:"RltReg2006-4-27 20.gif",time:"2006-04-27  20:00:00"},
	{imgname:"RltReg2006-4-25 20.gif",time:"2006-04-25  20:00:00"},
	{imgname:"RltReg2006-4-24 20.gif",time:"2006-04-24  20:00:00"},
	{imgname:"RltReg2006-4-23 8.gif",time:"2006-04-23  08:00:00"},
	{imgname:"RltReg2006-4-19 8.gif",time:"2006-04-19  08:00:00"},
	{imgname:"RltReg2006-4-18 8.gif",time:"2006-04-18  08:00:00"},
	{imgname:"RltReg2006-4-11 20.gif",time:"2006-04-11  20:00:00"},
	{imgname:"RltReg2006-4-10 20.gif",time:"2006-04-10  20:00:00"},
	{imgname:"RltReg2006-4-9 8.gif",time:"2006-04-09  08:00:00"},
	{imgname:"RltReg2006-4-7 8.gif",time:"2006-04-07  08:00:00"},
	{imgname:"RltReg2006-4-5 20.gif",time:"2006-04-05  20:00:00"},
	{imgname:"RltReg2006-4-4 20.gif",time:"2006-04-04  20:00:00"},
	{imgname:"RltReg2006-4-3 14.gif",time:"2006-04-03  14:00:00"}
]);