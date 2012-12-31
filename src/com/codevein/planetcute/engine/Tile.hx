package com.codevein.planetcute.engine;

import flash.display.BitmapData;
import nme.Assets;

class Tile  extends Entity {

	public  var type:Int;
	public  var id:Int;

	inline public static var TYPE_GROUND = 1;
	inline public static var TYPE_GROUND_TALL = 2;
	inline public static var TYPE_OBJECT = 3;
			

	public function new (aBtDataId:String, id:Int, aType:Int = 1) {
		
		super ( Assets.getBitmapData (aBtDataId) );

		this.type = aType;

		//graphics.lineStyle(3,0x00ff00);
		//graphics.drawRect(0,0,this.bitmap.width,this.bitmap.height);

		
	}
}