package com.codevein.planetcute.screens;


import openfl.Assets;

import flash.text.TextField;

import flash.display.Sprite;

import motion.Actuate;
import motion.MotionPath;
import motion.easing.Quad;
import motion.easing.Bounce;

import com.codevein.planetcute.engine.Tile;
import com.codevein.planetcute.engine.TileEngine;
import com.codevein.planetcute.engine.Entity;


import com.codevein.planetcute.util.TextUtil;

import com.codevein.planetcute.GameController;
import com.codevein.planetcute.engine.GameMap;
import com.codevein.planetcute.GameNumbersMaps;

import flash.filters.GlowFilter;

import flash.events.MouseEvent;
import flash.events.Event;



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
	private var canJump:Bool = true;
	private var btdMap:Array<String> ;
	private var numCount:Int = 0;
	private var menuButton:Sprite;
	

	public function new () {
		
		super (); 
		
		construct();
	}

	private function construct ():Void {


		actor = GameController.getInstance().getMainCharacter();

		engine = new TileEngine();

		maps = new GameNumbersMaps();

		menuButton = new Sprite();
		menuButton.mouseEnabled = true;
		menuButton.addEventListener(MouseEvent.CLICK, onMenu);
		menuButton.addChild(TextUtil.getInstance().createTextField(GameController.DEFAULT_FONT, " Menu\n", 48, 0xfbc90e, true));
		

		
	}

	private function onCreateTile(tile:Tile) {
		
		
		if (tile.id != GameNumbersMaps.NUMBER_CONTAINER) {
			tile.alpha = 0;
			var posY:Float = tile.y;
			tile.y -= 40;
			Actuate.tween(tile, 0.5 * Math.random(), { alpha:1, y: posY } ).ease(Quad.easeInOut);
		} else if (tile.numChildren == 1) {
			var value:String = maps.getData(phase).answers[nextItem++];
			var numText:TextField = TextUtil.getInstance().createTextField(GameController.ITEM_GAME_FONT, value, 64, 0x000033);
			numText.x = (tile.width - numText.width) * 0.5;
			numText.y = (tile.height - numText.height) * 0.2;
			tile.answerData = value;
			tile.addChild(numText);
			
		}
	}

	private function onCreateObject(tile:Tile) {

		var target:flash.geom.Point = maps.getData(phase).targetTilePosition;

		if (  tile.gridX == target.x && tile.gridY == target.y ) {
			tile.alpha = 0;
			Actuate.tween(tile, 1, { alpha:1} ).delay(1).ease(Quad.easeInOut);
			Actuate.tween(tile, 2, { y:tile.originY-20} ).ease(Quad.easeInOut).repeat().reflect();

		}
		
		
	}
	
	public override function onStart() {

		
		nextItem = 0;//reseta o contador

		tileGrid = engine.createGrid( maps.getAssetsList(), maps.getData(phase).tileMap , maps.getData(phase).objectMap , onCreateTile, onCreateObject );
		
		tileGrid.alpha = 1;

		tileGrid.x = ((GameController.SCREEN_WIDTH - tileGrid.width) * 0.5);
		tileGrid.y = ((GameController.SCREEN_HEIGHT - tileGrid.height) * 0.3) ;

		addChild(tileGrid);


		
 		tileGrid.addChild(actor);
		
 		lastTile = engine.putObjectOverTile(actor, maps.getData(phase).startTilePosition.x, maps.getData(phase).startTilePosition.y);

 		var actorY:Float = actor.y;
 		actor.y -= 500;
 		Actuate.tween(actor, 1, {  y: actorY }, false).delay(1).ease(Bounce.easeOut);
		Actuate.timer (1.5).onComplete (GameController.getInstance().playJumpSound);

		nextItem = 0;//reseta o contador

		menuButton.y = 0;
		menuButton.x = 10;
		addChild(menuButton);


		
	}


	private function onMenu(evt:Event) {
		GameController.getInstance().playClickSound();
		GameController.getInstance().gotToScreen(GameController.SHOW_INTRO_SCREEN);
	
	}

	private function goNextPhase() {

		var target:flash.geom.Point = maps.getData(phase).targetTilePosition;
		var star:Tile = engine.findObjectByGridPosition(target.x, target.y);
		if (star != null) {
			star.visible = false;	
		
		}
		
		if (phase + 1 < maps.totalPhases()) {
			
			phase++;
			Actuate.tween(actor, 1.5, {  y: -500 }, false);
			Actuate.tween(tileGrid, 0.5, {  alpha: 0 }, false).delay(1).onComplete(onStart);

		} else {
			
			GameController.getInstance().playClapSound();
		
		
			Actuate.tween(actor, 1.5, {  y: -500 }, false);
			Actuate.tween(tileGrid, 0.5, {  alpha: 0 }, false).delay(1).onComplete(removeAnimationComplete);

		}

		GameController.getInstance().playJumpSound2();
		
	
	}

	private function removeAnimationComplete() {

		GameController.getInstance().gotToScreen(GameController.SHOW_END_SCREEN);

		phase = 0;
		canJump = true;
		
	}

	public override function onRemove() {

	}	

	private function checkRule(tile:Tile) {

		var fail:Bool = false;
		if ( tile != null  && maps.canJumpInTile(phase, tile.id) && canJump ) {


			var diffY:Int = ((tile.type == Tile.TYPE_GROUND_TALL)?-80:-40);
			
			var path:MotionPath = new MotionPath();
						
			var midX:Float = ( (actor.x + tile.x) * 0.5 );
			var midY:Float = ( (actor.y + tile.y) * 0.5 ) - 320;
			var xPath:MotionPath = path.bezier (tile.x, tile.y + diffY , midX, midY);//.bezier (boy.x, boy.y , midX, midY);
			
			var animTime:Float = 0.4;
			var target:flash.geom.Point = maps.getData(phase).targetTilePosition;
			var phase_over:Bool = false;

			if (tile != null  && (tile.id == GameNumbersMaps.NUMBER_CONTAINER || (tile.gridX == target.x && tile.gridY == target.y ) )  && nextItem <  maps.getData(phase).answers.length  )  {

				if (tile.answerData != maps.getData(phase).answers[nextItem] ) {

					xPath.bezier (lastTile.x, lastTile.y + diffY , midX, midY);
					
					animTime = 1;
					Actuate.stop(tile);
					tile.y = tile.originY;
					Actuate.tween(tile, 0.5, { y: (tile.originY + 80) }, true).delay(0.5).reverse().ease(Quad.easeOut);
					Actuate.timer (0.5).onComplete (GameController.getInstance().playFailSound);
					fail= true;
					
				} else {
					nextItem++;
					lastTile = tile;
					Actuate.timer (0.5).onComplete (function (obj:Dynamic) {
						var glow:GlowFilter = new GlowFilter(0xFF9933, 1, 10, 10, 10);
						if (obj.filters) {
							obj.filters = [glow];
						}	    			
		    		},[tile.getChildAt(1)]);
					Actuate.timer (0.5).onComplete (GameController.getInstance().playNumberSound, [tile.answerData]);
					var star:Tile = engine.findObjectByGridPosition(target.x, target.y);
		
					if (star != null && nextItem ==  maps.getData(phase).answers.length) {
						var py = star.y;
						var px = star.x;
						var path2:MotionPath = new MotionPath();
						path2.line(px,py+40).line(px, py);
						Actuate.motionPath (star, 0.5, { y: path2.y } ).repeat(50).reflect().ease(Quad.easeInOut);
			
						//Actuate.tween(star, 0.2, {y:py + 20}).repeat(50).reflect();
					}
					
				}
			}  else if (  (tile.gridX == target.x && tile.gridY == target.y )   && nextItem >=  maps.getData(phase).answers.length  ) {

				tileGrid.addChild(actor);
				Actuate.stop(actor);
				Actuate.motionPath (actor, animTime, { x: xPath.x, y: xPath.y } ).ease(Quad.easeInOut).onComplete(goNextPhase);
				phase_over = true;


			} else {

					xPath.bezier (lastTile.x, lastTile.y + diffY , midX, midY);
					
					animTime = 1;
					Actuate.stop(tile);
					tile.y = tile.originY;
					Actuate.tween(tile, 0.5, { y: (tile.originY + 80) }, true).delay(0.5).reverse().ease(Quad.easeOut);
					Actuate.timer (0.5).onComplete (GameController.getInstance().playFailSound);
					fail= true;
					
			} 


			if (!phase_over) {
				canJump = false;
				tileGrid.addChild(actor);
				Actuate.motionPath (actor, animTime, { x: xPath.x, y: xPath.y } ).ease(Quad.easeInOut).onComplete(function(){canJump=true;});
			
			}	
			
			GameController.getInstance().playJumpSound();
	    	
		}

	
	}

	public override function updateMousePosition( aSX:Float, aSY:Float ) {

		var now :Float = Date.now().getTime();

		super.updateMousePosition( aSX, aSY );
		
		var tile:Tile = engine.findTileByMousePosition(aSX , aSY);
		
		checkRule(tile);
		lastClickTime =  now;
				

	}	
}