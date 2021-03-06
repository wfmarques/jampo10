package com.codevein.planetcute.screens;


import openfl.Assets;

import flash.text.TextField;

import flash.display.Sprite;


import motion.Actuate;
import motion.MotionPath;
import motion.easing.Quad;
import motion.easing.Bounce;

import com.codevein.planetcute.util.TextUtil;

import com.codevein.planetcute.GameController;


import flash.display.Bitmap;

import flash.events.MouseEvent;
import flash.events.Event;



class LangScreen extends BaseScreen {


	private var enButton:Sprite;
	private var ptButton:Sprite;
		

	
	public function new () {
		
		super();

		this.construct();
		
	}


	private function construct ():Void {

		enButton = new Sprite();
		enButton.mouseEnabled = true;
		enButton.addEventListener(MouseEvent.CLICK, onEnglish);

		enButton.addChild(new Bitmap(Assets.getBitmapData ("assets/imgs/button_en.png")));
		ptButton = new Sprite();
		ptButton.mouseEnabled = true;
		ptButton.addEventListener(MouseEvent.CLICK, onPortuguese);

		ptButton.addChild(new Bitmap(Assets.getBitmapData ("assets/imgs/button_pt.png")));

		//enButton.alpha = 0.7;
		//ptButton.alpha = 0.7;
		
	}	

	private function onEnglish(evt:Event) {
		GameController.getInstance().currentLanguage = "en";
		GameController.getInstance().playClickSound();
		Actuate.tween(ptButton, 1.5, { y:1024.0  } ).onComplete(removeAnimationComplete);
	}

	private function onPortuguese(evt:Event) {
		GameController.getInstance().currentLanguage = "pt";
		GameController.getInstance().playClickSound();
		Actuate.tween(enButton, 1.5, { y:-200.0  } ).onComplete(removeAnimationComplete);
		
	}




	public override function onStart() {

		var enFinalX:Float = ((GameController.SCREEN_WIDTH - enButton.width) * 0.5);
		var enFinalY:Float = ((GameController.SCREEN_HEIGHT - enButton.height) * 0.5)- 150;
		

		enButton.scaleX = 0.1;
		enButton.scaleY = 0.1;

		enButton.x = ((GameController.SCREEN_WIDTH - enButton.width) * 0.5);
		enButton.y = ((GameController.SCREEN_HEIGHT - enButton.height) * 0.5) - 150;
		
			
		addChild(enButton);

		var ptFinalX:Float = ((GameController.SCREEN_WIDTH - ptButton.width) * 0.5);
		var ptFinalY:Float = ((GameController.SCREEN_HEIGHT - ptButton.height) * 0.5);
		
		ptButton.scaleX = 0.1;
		ptButton.scaleY = 0.1;

		ptButton.x = ((GameController.SCREEN_WIDTH - ptButton.width) * 0.5);
		ptButton.y = ((GameController.SCREEN_HEIGHT - ptButton.height) * 0.5) ;

		
		addChild(ptButton);


		Actuate.tween(enButton, 1, { scaleX:1, scaleY:1, x:enFinalX ,y:enFinalY } ).delay(0.2).ease(Bounce.easeOut);
		Actuate.tween(ptButton, 1, { scaleX:1, scaleY:1, x:ptFinalX ,y:ptFinalY } ).delay(0.5).ease(Bounce.easeOut);


	}

	private function removeAnimationComplete() {

		//Actuate.reset();
		GameController.getInstance().gotToScreen(GameController.SHOW_INTRO_SCREEN);
	
	}

	public override function onRemove() {
		

	}

	public override function updateMousePosition( aSX:Float, aSY:Float ) {

		super.updateMousePosition( aSX, aSY );


	}	
	

}
