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
import com.codevein.planetcute.engine.GameMap;
import com.codevein.planetcute.GameNumbersMaps;




class GameNumbersScreen extends BaseScreen {


	private var maps:GameNumbersMaps;
	private var engine:TileEngine;
	private var tileGrid:Sprite;
	private var lastTile:Tile;
	private var lastClickTime:Float = 0;
	private var gameTitle:TextField;
	private var actor:Entity;
	private var phase:Int = 0;
	private var nextItem:Int = 0;

	private var btdMap:Array<String> ;

	public function new () {
		
		super (); 
		
		construct();
	}

	private function construct ():Void {


		actor = GameController.getInstance().getMainCharacter();

		engine = new TileEngine();

		maps = new GameNumbersMaps();

	}

	private function onCreateTile(tile:Tile) {
		
		
		if (tile.id != GameNumbersMaps.NUMBER_CONTAINER) {
			tile.alpha = 0;
			var posY:Float = tile.y;
			tile.y -= 40;
			Actuate.tween(tile, 0.5 * Math.random(), { alpha:1, y: posY } ).ease(Quad.easeInOut);
		} else if (tile.numChildren == 1) {
			var value:String = maps.getData(phase).answers[nextItem++];
			var numText:TextField = TextUtil.getInstance().createTextField(GameController.ITEM_GAME_FONT, value, 64, 0x000000);
			numText.x = (tile.width - numText.width) * 0.5;
			numText.y = (tile.height - numText.height) * 0.1;
			tile.answerData = value;
			tile.addChild(numText);

		}
	}

	private function onCreateObject(tile:Tile) {

		var target:flash.geom.Point = maps.getData(phase).targetTilePosition;

		if (  tile.gridX == target.x && tile.gridY == target.y ) {
			tile.alpha = 0;
			Actuate.tween(tile, 1, { alpha:1} ).delay(1).ease(Quad.easeInOut);
		}
		
		
	}
	
	public override function onStart() {

		nextItem = 0;//reseta o contador

		tileGrid = engine.createGrid( maps.getAssetsList(), maps.getData(phase).tileMap , maps.getData(phase).objectMap , onCreateTile, onCreateObject );
		
		tileGrid.alpha = 1;

		tileGrid.x = ((GameController.SCREEN_WIDTH - tileGrid.width) * 0.5);
		tileGrid.y = ((GameController.SCREEN_HEIGHT - tileGrid.height) * 0.5);

		addChild(tileGrid);

		
 		tileGrid.addChild(actor);
		
 		lastTile = engine.putObjectOverTile(actor, maps.getData(phase).startTilePosition.x, maps.getData(phase).startTilePosition.y);

 		var actorY:Float = actor.y;
 		actor.y -= 500;
 		Actuate.tween(actor, 1, {  y: actorY }, false).delay(1).ease(Bounce.easeOut);
		

		nextItem = 0;//reseta o contador

		
	}

	private function goNextPhase() {
		if (phase + 1 < maps.totalPhases()) {
			phase++;
			Actuate.tween(actor, 1.5, {  y: -500 }, false);
			Actuate.tween(tileGrid, 0.5, {  alpha: 0 }, false).delay(1).onComplete(onStart);
		} else {

			Actuate.tween(actor, 1.5, {  y: -500 }, false);
			Actuate.tween(tileGrid, 0.5, {  alpha: 0 }, false).delay(1).onComplete(removeAnimationComplete);

		}
		
	
	}

	private function removeAnimationComplete() {

		GameController.getInstance().dispatchEvent(new flash.events.Event(GameController.SHOW_INTRO_SCREEN));
		phase = 0;
		

	}

	public override function onRemove() {

	}	

	private function checkRule(tile:Tile) {


		if (tile != null   && maps.canJumpInTile(phase, tile.id) ) {


			var diffY:Int = ((tile.type == Tile.TYPE_GROUND_TALL)?-80:-40);
			
			var path:MotionPath = new MotionPath();
			var midX:Float = actor.x + ( ( actor.x - tile.x  ) * -1);
			var midY:Float = actor.y - 300;
			var xPath:MotionPath = path.bezier (tile.x, tile.y + diffY , midX, midY);//.bezier (boy.x, boy.y , midX, midY);
			
			var animTime:Float = 0.5;
			var target:flash.geom.Point = maps.getData(phase).targetTilePosition;
			var phase_over:Bool = false;

			if (tile != null  && (tile.id == GameNumbersMaps.NUMBER_CONTAINER || (tile.gridX == target.x && tile.gridY == target.y ) )  && nextItem <  maps.getData(phase).answers.length  )  {

				if (tile.answerData != maps.getData(phase).answers[nextItem]) {

					xPath.bezier (lastTile.x, lastTile.y + diffY , midX, midY);
					
					animTime = 1;
					Actuate.tween(tile, 0.5, { y: (tile.originY + 80) }, false).delay(0.5).reverse().ease(Quad.easeOut);
			
				} else {
					nextItem++;
					lastTile = tile;
				}
			}  else if (  (tile.gridX == target.x && tile.gridY == target.y )   && nextItem >=  maps.getData(phase).answers.length  ) {
				tileGrid.addChild(actor);
				Actuate.motionPath (actor, animTime, { x: xPath.x, y: xPath.y } ).ease(Quad.easeInOut).onComplete(goNextPhase);
				phase_over = true;


			} 


			if (!phase_over) {
				tileGrid.addChild(actor);
				Actuate.motionPath (actor, animTime, { x: xPath.x, y: xPath.y } ).ease(Quad.easeInOut);

			}	
			
			
	    	
		}

	
	}

	public override function updateMousePosition( aSX:Float, aSY:Float ) {

		super.updateMousePosition( aSX, aSY );
		var now :Float = Date.now().getTime();

		var tile:Tile = engine.findTileByMousePosition(aSX , aSY);

		checkRule(tile);

		lastClickTime =  Date.now().getTime();
		

	}	
}