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

import flash.display.Bitmap;

import flash.events.MouseEvent;
import flash.events.Event;


class IntroScreen extends BaseScreen {


	private var engine:TileEngine;
	private var tileGrid:Sprite;
	private var gameTitle:Bitmap;
	private var enButton:Sprite;
	private var ptButton:Sprite;
	
	private var actor:Entity;
	private var titleWidth:Float;
	private var gridW:Float;
	private var gridH:Float;
	
	
	private var lastTile:Tile;

	public function new () {
		
		super();

		this.construct();
		
	}


	private function construct ():Void {


		actor = GameController.getInstance().getMainCharacter();

		//gameTitle = TextUtil.getInstance().createTextField(GameController.DEFAULT_FONT, "Jampo - 10", 72);
		gameTitle =  new Bitmap(Assets.getBitmapData ("assets/imgs/jampo_sign.png"));

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
			[ 4, 0, 0, 4, 0, 0, 4 ],
			[ 4, 0, 0, 0, 0, 0, 4 ],
			[ 6, 4, 4, 1, 4, 4, 6 ]
		
		];

		var objMap:Array<Array<Int>> = [
			[ -1, -1, -1, -1, -1, -1, -1 ],
			[ -1, -1, -1, -1, -1, -1, -1 ],
			[ -1, -1, -1, -1, -1, -1, -1 ],
			[ -1, -1, -1, 5, -1, -1, -1 ]
		
		];
		
		engine = new TileEngine();

		tileGrid = engine.createGrid( btdMap, tileMap, objMap, onCreateTile, onCreateObject );
		gridW = tileGrid.width;
		gridH = tileGrid.height;


		enButton = new Sprite();
		enButton.mouseEnabled = true;
		enButton.addEventListener(MouseEvent.CLICK, onEnglish);
		enButton.addChild(TextUtil.getInstance().createTextField(GameController.DEFAULT_FONT, "English\n", 48, 0xfbc90e, true));
		
		ptButton = new Sprite();
		ptButton.mouseEnabled = true;
		ptButton.addEventListener(MouseEvent.CLICK, onPortuguese);

		ptButton.addChild(TextUtil.getInstance().createTextField(GameController.DEFAULT_FONT, "Português\n", 48, 0xfbc90e, true));
		

		
		
	}	


	private function onEnglish(evt:Event) {
		GameController.getInstance().playClickSound();
		GameController.getInstance().currentLanguage = "en";
		
		ptButton.alpha = 0.4;
		enButton.alpha = 1.0;
		
	}

	private function onPortuguese(evt:Event) {
		GameController.getInstance().playClickSound();
		GameController.getInstance().currentLanguage = "pt";
		
		enButton.alpha = 0.4;
		ptButton.alpha = 1.0;
		
	}

	private function onCreateTile(tile:Tile) {
		tile.alpha = 0;
		var posY:Float = tile.y;

		tile.y -= 40;
		Actuate.tween(tile, 0.5 * Math.random(), { alpha:1, y: posY } ).delay(0.5).ease(Quad.easeInOut);

	}

	private function onCreateObject(tile:Tile) {
		Actuate.tween(tile, 0.5, { y:tile.originY-20} ).ease(Quad.easeInOut).repeat().reflect();

	}


	public override function onStart() {
		gameTitle.y = 30;
 		gameTitle.x = ((GameController.SCREEN_WIDTH - titleWidth) * 0.5);
 		gameTitle.alpha = 0;

 		Actuate.tween(gameTitle, 1, {  alpha: 1 }, false).delay(1);
			

 		addChild(gameTitle);

		
		tileGrid.x = ((GameController.SCREEN_WIDTH - gridW) * 0.5);
		tileGrid.y = ((GameController.SCREEN_HEIGHT - gridH) * 0.5) ;

		
		addChild(tileGrid);

		tileGrid.visible = true;
		Actuate.tween(tileGrid, 0.5, {  alpha: 1 }, false);
		
		tileGrid.addChild(actor);
		
 		engine.putObjectOverTile(actor, 3, 1);

 		if (lastTile != null) {
 			var star:Tile = engine.findObjectByGridPosition(lastTile.gridX, lastTile.gridY);
			star.visible = true;
			star.alpha = 0;
			Actuate.tween(star, 4, { alpha:1} ).ease(Quad.easeInOut);
			Actuate.tween(star, 0.5, { y:star.originY-20} ).ease(Quad.easeInOut).repeat().reflect();

		}
		

 		var actorY:Float = actor.y;
 		actor.y -= 500;
 		Actuate.tween(actor, 1, {  y: actorY }, false).delay(1).ease(Bounce.easeOut);
		Actuate.timer (1.5).onComplete (GameController.getInstance().playJumpSound);

		enButton.visible = true;
		ptButton.visible = true;
		
		enButton.y = gridH + tileGrid.y - enButton.height + 10;
		enButton.x = tileGrid.x ;
		enButton.alpha = (GameController.getInstance().currentLanguage=="en")?1.0:0.4;
		addChild(enButton);

		ptButton.y = gridH + tileGrid.y - ptButton.height + 10;
		ptButton.x = tileGrid.x + gridW - ptButton.width;
		ptButton.alpha = (GameController.getInstance().currentLanguage=="pt")?1.0:0.4;
		
		addChild(ptButton);

	}

	private function removeAnimationComplete() {

		Actuate.reset();
		GameController.getInstance().gotToScreen(GameController.SHOW_GAME_NUMBERS_SCREEN);

	}

	public override function onRemove() {
		

	}


	public function goNumbersGame() {
		Actuate.tween(actor, 1.5, {  y: -500 }, false);
		Actuate.tween(tileGrid, 0.5, {  alpha: 0 }, false).delay(1);
		Actuate.tween(enButton, 0.5, {  alpha: 0 }, false);
		Actuate.tween(ptButton, 0.5, {  alpha: 0 }, false);
		
		Actuate.tween(gameTitle, 1, {  y: -300 }, false).delay(1).onComplete(removeAnimationComplete);
		GameController.getInstance().playJumpSound2();
		var star:Tile = engine.findObjectByGridPosition(lastTile.gridX, lastTile.gridY);
		star.visible = false;	
		

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
	    	
	    	lastTile = tile;
	    	Actuate.motionPath (actor, 0.5, { x: xPath.x, y: xPath.y } ).ease(Quad.easeInOut).onComplete(goNumbersGame);
	    	GameController.getInstance().playJumpSound();
	    	
	    
			//Actuate.tween(tile, 0.5, { y: (tile.y + 80) }, false).delay(0.5).ease(Quad.easeOut);
			//tile.disabled = true;
		
		}

	}	
	

}
