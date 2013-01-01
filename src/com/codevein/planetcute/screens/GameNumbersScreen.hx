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


class GameNumbersScreen extends BaseScreen {


	private var engine:TileEngine;
	private var tileGrid:Sprite;
	private var gameTitle:TextField;
	private var actor:Entity;

	private var btdMap:Array<String> ;

	public function new () {
		
		super (); 
		
		construct();
	}

	private function construct ():Void {


		actor = GameController.getInstance().getMainCharacter();

		
		btdMap = new Array<String>();
		btdMap[0] = "assets/imgs/Water_Block.png";
		btdMap[1] = "assets/imgs/Stone_Block_Tall.png";
		btdMap[2] = "assets/imgs/Stone_Block.png";
		btdMap[3] = "assets/imgs/Wall_Block_Tall.png";
		btdMap[4] = "assets/imgs/Grass_Block.png";
		btdMap[5] = "assets/imgs/Star.png";
		
		
		engine = new TileEngine();
		

		
	}

	private function onCreateTile(tile:Tile) {
		tile.alpha = 0;
		var posY:Float = tile.y;

		tile.y -= 40;
		Actuate.tween(tile, 0.5 * Math.random(), { alpha:1, y: posY } ).ease(Quad.easeInOut);

	}

	private function onCreateObject(tile:Tile) {
		tile.alpha = 0;
		Actuate.tween(tile, 1, { alpha:1} ).delay(3).ease(Quad.easeInOut);

	}
	
	public override function onStart() {

		var tileMap:Array<Array<Int>> = [
			[ 0, 0, 0, 0, 0],
			[ 0, 0, 1, 0, 0],
			[ 0, 1, 0, 1, 0],
			[ 0, 0, 3, 0, 0],
			[ 0, 0, 0, 0, 0],
			
		];

		var objMap:Array<Array<Int>> = [
			[ -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1],
			[ -1, -1,  5, -1, -1],
			[ -1, -1, -1, -1, -1],
		];
		
		
		tileGrid = engine.createGrid( btdMap, tileMap, objMap, onCreateTile, onCreateObject );
		

		tileGrid.x = ((GameController.SCREEN_WIDTH - tileGrid.width) * 0.5);
		tileGrid.y = ((GameController.SCREEN_HEIGHT - tileGrid.height) * 0.5);

		addChild(tileGrid);

		
 		tileGrid.addChild(actor);
		
 		engine.putObjectOverTile(actor, 2, 1);

 		var actorY:Float = actor.y;
 		actor.y -= 500;
 		Actuate.tween(actor, 1, {  y: actorY }, false).delay(1).ease(Bounce.easeOut);
		
	
	}

	public override function onRemove() {

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
	    	
	    	Actuate.motionPath (actor, 0.5, { x: xPath.x, y: xPath.y } ).ease(Quad.easeInOut);

			//Actuate.tween(tile, 0.5, { y: (tile.y + 80) }, false).delay(0.5).ease(Quad.easeOut);
			//tile.disabled = true;
		
		}

	}	
}