package com.codevein.planetcute.engine;


import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;



class Entity extends Sprite {

	private var bitmap:Bitmap;
	
	public function new (aBtData:BitmapData) {
		
		super ();

		this.bitmap = new Bitmap(aBtData);
		
		addChild(this.bitmap);
		
	}

	public function finish() {
		this.bitmap.bitmapData = null;
		this.bitmap = null;
	}
}