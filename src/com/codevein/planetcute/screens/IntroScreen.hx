package com.codevein.planetcute.screens;


import nme.Assets;

import flash.text.TextField;

import flash.display.Sprite;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.MotionPath;
import com.eclecticdesignstudio.motion.easing.Quad;
import com.eclecticdesignstudio.motion.easing.Bounce;

import com.codevein.planetcute.engine.Tile;
import com.codevein.planetcute.engine.TileEngine;
import com.codevein.planetcute.engine.Entity;


import com.codevein.planetcute.util.TextUtil;

import com.codevein.planetcute.GameController;


class IntroScreen extends BaseScreen {


	private var engine:TileEngine;
	private var tileGrid:Sprite;
	private var gameTitle:TextField;
	private var actor:Entity;
	private var titleWidth:Float;
	

	public function new () {
		
		super();

		this.construct();
		
	}


	private function construct ():Void {


		actor = GameController.getInstance().getMainCharacter();

		gameTitle = TextUtil.getInstance().createTextField(GameController.DEFAULT_FONT, "Jump & Learn", 72);
		titleWidth = gameTitle.width;

		
		var btdMap:Array<String> = new Array<String>();
		btdMap[0] = "assets/imgs/Water_Block.png";
		btdMap[1] = "assets/imgs/Stone_Block_Tall.png";
		btdMap[2] = "assets/imgs/Stone_Block.png";
		btdMap[3] = "assets/imgs/Wall_Block_Tall.png";
		btdMap[4] = "assets/imgs/Grass_Block.png";
		btdMap[5] = "assets/imgs/Star.png";
		btdMap[6] = "assets/imgs/Empty.png";
		
		
				

		var tileMap:Array<Array<Int>> = [
			[ 6, 4, 4, 4, 4, 4, 6 ],
			[ 4, 0, 0, 0, 0, 0, 4 ],
			[ 4, 1, 0, 4, 0, 1, 4 ],
			[ 4, 0, 0, 0, 0, 0, 4 ],
			[ 6, 4, 4, 4, 4, 4, 6 ]
		
		];

		var objMap:Array<Array<Int>> = [
			[ -1, -1, -1, -1, -1, -1, -1 ],
			[ -1, -1, -1, -1, -1, -1, -1 ],
			[ -1,  5, -1, -1, -1,  5, -1 ],
			[ -1, -1, -1, -1, -1, -1, -1 ],
			[ -1, -1, -1, -1, -1, -1, -1 ]
		
		];
		
		engine = new TileEngine();

		tileGrid = engine.createGrid( btdMap, tileMap, objMap, onCreateTile, onCreateObject );
		
	}

	private function onCreateTile(tile:Tile) {
		tile.alpha = 0;
		var posY:Float = tile.y;

		tile.y -= 40;
		Actuate.tween(tile, 0.5 * Math.random(), { alpha:1, y: posY } ).delay(0.5).ease(Quad.easeInOut);

	}

	private function onCreateObject(tile:Tile) {
		tile.alpha = 0;
		Actuate.tween(tile, 4, { alpha:1} ).ease(Quad.easeInOut);

	}


	public override function onStart() {

		gameTitle.y = 20;
 		gameTitle.x = ((GameController.SCREEN_WIDTH - titleWidth) * 0.5);
 		gameTitle.alpha = 0;

 		Actuate.tween(gameTitle, 1, {  alpha: 1 }, false).delay(1);
			

 		addChild(gameTitle);


		
		tileGrid.x = ((GameController.SCREEN_WIDTH - tileGrid.width) * 0.5);
		tileGrid.y = ((GameController.SCREEN_HEIGHT - tileGrid.height) * 0.5);

		addChild(tileGrid);

		tileGrid.visible = true;
		Actuate.tween(tileGrid, 0.5, {  alpha: 1 }, false);
		
		tileGrid.addChild(actor);
		
 		engine.putObjectOverTile(actor, 3, 2);

 		var actorY:Float = actor.y;
 		actor.y -= 500;
 		Actuate.tween(actor, 1, {  y: actorY }, false).delay(1).ease(Bounce.easeOut);
		Actuate.timer (1.5).onComplete (GameController.getInstance().playJumpSound);

	}

	private function removeAnimationComplete() {

		GameController.getInstance().dispatchEvent(new flash.events.Event(GameController.SHOW_GAME_NUMBERS_SCREEN));

	}

	public override function onRemove() {
		

	}


	public function goNumbersGame() {
		Actuate.tween(actor, 1.5, {  y: -500 }, false);
		Actuate.tween(tileGrid, 0.5, {  alpha: 0 }, false).delay(1);
		Actuate.tween(gameTitle, 1, {  y: -300 }, false).delay(1).onComplete(removeAnimationComplete);
		GameController.getInstance().playJumpSound2();

	}

	public override function updateMousePosition( aSX:Float, aSY:Float ) {

		super.updateMousePosition( aSX, aSY );

		var tile:Tile = engine.findTileByMousePosition(aSX , aSY);

		if (tile != null && tile.type == Tile.TYPE_GROUND_TALL ) {

			var diffY:Int = ((tile.type == Tile.TYPE_GROUND_TALL)?-80:-40);
			
			var path:MotionPath = new MotionPath();
			var midX:Float = actor.x + ( ( actor.x - tile.x  ) * -1);
			var midY:Float = actor.y - 300;
			var xPath:MotionPath = path.bezier (tile.x, tile.y + diffY , midX, midY);//.bezier (boy.x, boy.y , midX, midY);
	    	
	    	Actuate.motionPath (actor, 0.5, { x: xPath.x, y: xPath.y } ).ease(Quad.easeInOut).onComplete(goNumbersGame);
	    	GameController.getInstance().playJumpSound();

			//Actuate.tween(tile, 0.5, { y: (tile.y + 80) }, false).delay(0.5).ease(Quad.easeOut);
			//tile.disabled = true;
		
		}

	}	
	

}
