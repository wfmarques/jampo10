package com.codevein.planetcute.screens;


import flash.display.Sprite;


class BaseScreen extends Sprite {


	private var stageX:Float;
	private var stageY:Float;


	public function updateMousePosition(aSX:Float, aSY:Float) {

		this.stageX = aSX;
		this.stageY = aSY;
	}	

	public function onStart() {
	
	}
	public function onRemove() {

	}

}
