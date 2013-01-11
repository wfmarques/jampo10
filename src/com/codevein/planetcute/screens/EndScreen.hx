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
import com.codevein.planetcute.GameCreditsTexts;


class EndScreen extends BaseScreen {

	public inline static var TOTAL_STARS:Int = 50;
	
	private var engine:TileEngine;
	private var ship:Entity;
	private var blinkStar:Entity;
	private var numText:TextField;
	private var title:TextField;
	private var person:TextField;
	private var credit:Sprite;

	private var lastTimeTick:Float;
	private var now :Float ;
	private var numCount:Int;

	private var stars:Array<Sprite>;
	private var canClick:Bool = false;
	private var animatingStar:Bool = false;
	
	private var speed:Int = 1;



	public function new () {
		
		super();

		this.construct();
		
	}


	private function construct ():Void {
		numCount = 1;
		blinkStar = new Entity(Assets.getBitmapData ("assets/imgs/Star.png"));
		numText = TextUtil.getInstance().createTextField(GameController.ITEM_GAME_FONT, numCount+"", 56, 0x000033);
		numText.x = (blinkStar.width  - numText.width) * 0.5;
		numText.y = 65;
		blinkStar.addChild(numText);

		credit = new Sprite();
		title = TextUtil.getInstance().createTextField(GameController.ITEM_GAME_FONT, "Title", 25, 0xFFFFFF);
		title.backgroundColor = 0x000000;
		person = TextUtil.getInstance().createTextField(GameController.ITEM_GAME_FONT, "Person Name", 32, 0xFFFFFF);
		person.backgroundColor = 0x000000;		
		credit.addChild(title);
		credit.addChild(person);
		person.y = title.height;	
		credit.x = 	GameController.SCREEN_WIDTH * 0.5;
		credit.y = 	GameController.SCREEN_HEIGHT * 0.5;

	}


	private function loadNextCredit() {
		var nextCredit:Dynamic = GameCreditsTexts.getInstance().getNextCredit();

		if (nextCredit != null) {
			Actuate.tween(credit, 0.5, {alpha:0} ).onComplete(function(){ 

				title.text = nextCredit.title;
				person.text = nextCredit.name;
				credit.x = ((GameController.SCREEN_WIDTH - credit.width) * 0.5) - 50  ;
				credit.y = ((GameController.SCREEN_HEIGHT - credit.height) * 0.5)  ;
				
				Actuate.tween(credit, 1, {alpha:1} );
				Actuate.timer(6.5).onComplete(loadNextCredit);

			});
		
			
		} else {

			removeChild(blinkStar);
			Actuate.tween(credit, 0.5, {  alpha: 0 }, false).onComplete(function(){speed=0;});
			Actuate.tween(ship, 2, {x: GameController.SCREEN_WIDTH + 100} );
			Actuate.tween(GameController.getInstance().background, 3, {  alpha: 1 }, false).onComplete(removeAnimationComplete);
				

		}
	}



	public override function onStart() {

		

		GameCreditsTexts.getInstance().reset("en");
		
		numCount = 1;

		numText.text = numCount+"";

		blinkStar.x = (Math.random () * GameController.SCREEN_WIDTH) + 50 ;
		blinkStar.y = (Math.random () * GameController.SCREEN_HEIGHT) - 50 ;
		addChild(blinkStar);
		blinkStar.visible = false;
		
		ship = GameController.getInstance().getShip();
		addChild(ship);
		ship.x = -400;
		ship.y = 256;
		
		
		canClick = false;
		speed = 5;
		animatingStar = false;

		Actuate.tween(ship, 2, {x: 400, y:50} ).delay(2).ease(Quad.easeInOut).onComplete(function(){
				canClick = true;
				blinkStar.visible = true;
			});

		Actuate.tween(GameController.getInstance().background, 4, {  alpha: 0 }, false).onComplete(function (){
				stars = new Array<Sprite>();
				for (i in 0...TOTAL_STARS) {
					stars[i] = createStar();
				}

				this.addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame );
   

			});

		addChild(credit);
		
		credit.alpha = 0;
		loadNextCredit();
		
	}

	private function onEnterFrame(e:flash.events.Event) {
		now = Date.now().getTime();
		for (i in 0...TOTAL_STARS) {

			if (stars[i].x < -20) {

				stars[i].x = GameController.SCREEN_WIDTH + 20;
				stars[i].y = Math.random () * GameController.SCREEN_HEIGHT;
		
			}
			if (speed == 0) {

				stars[i].visible = false;

			} else {
				
				stars[i].x -= speed;

			}
		}
		
		checkBlinkStar();
	}

	private function removeAnimationComplete() {

		Actuate.reset();
		this.removeEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame );
   		GameController.getInstance().dispatchEvent(new flash.events.Event(GameController.SHOW_INTRO_SCREEN));

	}

	public override function onRemove() {
		
		while (this.numChildren > 0) {
			this.removeChildAt(0);
		}

	}

	private function checkBlinkStar() {
		
		if (!animatingStar && (now - lastTimeTick) > 6000) {
			animatingStar = true;
			Actuate.tween(blinkStar , 0.5, {alpha:0}, false ).onComplete(function(){
				blinkStar.x = (Math.random () * GameController.SCREEN_WIDTH * 0.7) + 100  ;
				blinkStar.y = (Math.random () * GameController.SCREEN_HEIGHT * 0.7) + 100 ;
				Actuate.tween(blinkStar, 2, {alpha:1}, false ).onComplete(function(){animatingStar = false;});
			});
			lastTimeTick = now;
		} 
	}

	private function catchBlinkStar() {
		
		if (ship.hitTestObject(blinkStar) ) {
			animatingStar = true;
			var x = (Math.random () * GameController.SCREEN_WIDTH) ;
			var y =  - 300 ;
			GameController.getInstance().playNumberSound(numCount+"");
			if (numCount == 10) {
				GameController.getInstance().playClapSound();
				numCount = 0;
			}
			numText.text = "";
			Actuate.tween(blinkStar , 2, {x:x,y:y, rotation: 180}, false ).onComplete(function(){
					animatingStar = false;
					lastTimeTick = 0;
					blinkStar.rotation = 0;
					numCount++;
					numText.text = numCount+"";
					numText.x = (blinkStar.width  - numText.width) * 0.5;

					
	
			});
			
		} 
	}

	private function createStar():Sprite {
		
		var size:Float = 2 + Math.random () * 2;
		var blur:Float = 3 + Math.random () * 2;
		
		var star:Sprite = new Sprite ();
		star.graphics.beginFill (Std.int (0xFFFFFF));
		star.graphics.drawCircle (0, 0, size);
		star.x = Math.random () * GameController.SCREEN_WIDTH + 20;
		star.y = Math.random () * GameController.SCREEN_HEIGHT;
		addChildAt (star, 0);
		star.alpha = ( 0.2 + Math.random () * 0.6 );
		
		return star;
		
	}

	

	public override function updateMousePosition( aSX:Float, aSY:Float ) {

		if (canClick) {
			super.updateMousePosition( aSX, aSY );
			Actuate.tween( ship, 1, {x: (aSX - (ship.width * 0.5)) , y: (aSY - ( ship.height * 0.5 )) } ).ease(Quad.easeOut).onComplete(function () {catchBlinkStar();});
		}

	}	
	

}
