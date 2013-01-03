package com.codevein.planetcute.engine;

import flash.display.BitmapData;
import nme.Assets;

class Tile  extends Entity {

	public var type:Int;
	public var id:Int;
	public var gridX:Int;
	public var gridY:Int;
	
	public var answerData:Dynamic = null;

	inline public static var TYPE_GROUND = 1;
	inline public static var TYPE_GROUND_TALL = 2;
	inline public static var TYPE_OBJECT = 3;
			

	public function new (aBtDataId:String, aId:Int, aType:Int, aGridX:Int = -1, aGridY:Int = -1) {
		
		super ( Assets.getBitmapData (aBtDataId) );

		this.type = aType;
		this.id = aId;
		this.gridX = aGridX;
		this.gridY = aGridY;

		//graphics.lineStyle(3,0x00ff00);
		//graphics.drawRect(0,0,this.bitmap.width,this.bitmap.height);

		
	}
}