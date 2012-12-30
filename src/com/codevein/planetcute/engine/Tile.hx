package com.codevein.planetcute.engine;

import flash.display.BitmapData;
import nme.Assets;

class Tile  extends Entity {

	public  var type:Int;
	public  var id:Int;


	public function new (aBtDataId:String, id:Int, aType:Int = 1) {
		
		super ( Assets.getBitmapData (aBtDataId) );

		this.type = aType;

		
	}
}