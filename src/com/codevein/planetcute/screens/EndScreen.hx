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


class EndScreen extends BaseScreen {

	public inline static var TOTAL_STARS:Int = 50;
	
	private var engine:TileEngine;
	private var ship:Entity;
	private var blinkStar:Entity;

	private var lastTimeTick:Float;
	private var now :Float ;

	private var stars:Array<Sprite>;
	private var canClick:Bool = false;
	private var animatingStar:Bool = false;
	
	private var speed:Int = 1;



	public function new () {
		
		super();

		this.construct();
		
	}


	private function construct ():Void {
		
		blinkStar = new Entity(Assets.getBitmapData ("assets/imgs/Star.png"));
	}



	public override function onStart() {

		blinkStar.x = (Math.random () * GameController.SCREEN_WIDTH) + 50 ;
		blinkStar.y = (Math.random () * GameController.SCREEN_HEIGHT) - 50 ;
		
		addChild(blinkStar);

		ship = GameController.getInstance().getShip();
		addChild(ship);
		ship.x = -400;
		ship.y = 256;
		
		
		canClick = false;
		speed = 5;
		animatingStar = false;

		Actuate.tween(ship, 4, {x: 400} ).delay(2).ease(Quad.easeInOut).onComplete(function(){
			canClick=true;
			});

		Actuate.tween(GameController.getInstance().background, 2, {  alpha: 0 }, false).onComplete(function (){
				stars = new Array<Sprite>();
				for (i in 0...TOTAL_STARS) {
					stars[i] = createStar();
				}

				this.addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame );
   

			});
		
	}

	private function onEnterFrame(e:flash.events.Event) {
		now = Date.now().getTime();
		for (i in 0...TOTAL_STARS) {

			if (stars[i].x < -20) {

				stars[i].x = GameController.SCREEN_WIDTH + 20;
				stars[i].y = Math.random () * GameController.SCREEN_HEIGHT;
		
			}
			stars[i].x -= speed;
		}
		
		checkBlinkStar();
	}

	private function removeAnimationComplete() {

		Actuate.reset();
		this.removeEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame );
   		GameController.getInstance().dispatchEvent(new flash.events.Event(GameController.SHOW_INTRO_SCREEN));

	}

	public override function onRemove() {
		

	}

	private function checkBlinkStar() {
		
		if (!animatingStar && (now - lastTimeTick) > 6000) {
			animatingStar = true;
			Actuate.tween(blinkStar , 0.5, {alpha:0}, false ).onComplete(function(){
				blinkStar.x = (Math.random () * GameController.SCREEN_WIDTH) - 100 ;
				blinkStar.y = (Math.random () * GameController.SCREEN_HEIGHT) - 100 ;
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
			Actuate.tween(blinkStar , 4, {x:x,y:y, rotation: 180}, false ).onComplete(function(){
					animatingStar = false;
					lastTimeTick = 0;
					blinkStar.rotation = 0;
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
