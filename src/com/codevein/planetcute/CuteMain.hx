package com.codevein.planetcute;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.MouseEvent;


import flash.Lib;
import flash.display.MovieClip;

import motion.Actuate;

import com.codevein.planetcute.GameController;


/**
 * @author Wesley Marques
 */
class CuteMain extends MovieClip {

	//Insert your values here:
private static inline var NOMINAL_WIDTH:Int = 1024;
private static inline var NOMINAL_HEIGHT:Int = 576;
private var stageScale:Float = 0;	
private static var musicPlaying = false;
	
	public function new () { 
		
		super (); 
		
		initialize ();
		construct ();
		
	}
	
	 
	/*private function animateCircle (circle:Sprite):Void {
		
		var duration:Float = 1.5 + Math.random () * 4.5;
		var targetX:Float = Math.random () * stage.stageWidth;
		var targetY:Float = Math.random () * stage.stageHeight;
		
		Actuate.tween (circle, duration, { x: targetX, y: targetY }, false).ease (Quad.easeOut).onComplete (animateCircle, [ circle ]);
		
	}*/
	
	
	private function construct ():Void {
		
		GameController.getInstance().setRootContainer(this);	
		GameController.getInstance().initialize();
	
	}
	
	
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode =  StageScaleMode.NO_BORDER;
		// Lib.current.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		Lib.current.stage.addEventListener (Event.ACTIVATE, stage_onActivate);
		Lib.current.stage.addEventListener (Event.DEACTIVATE, stage_onDeactivate);
		Lib.current.stage.addEventListener (MouseEvent.MOUSE_DOWN, stage_onClick);

		Lib.current.stage.stage.addEventListener(Event.RESIZE, onResize);
        //onResize(null);
		/*#if ios
		Lib.current.stage.setFixedOrientation( -1);
		Lib.current.stage.shouldRotateInterface = function (orientation:Int):Bool {
			return (orientation == Lib.current.stage.OrientationLandscapeLeft || orientation == Lib.current.stage.OrientationLandscapeRight);
		}	
		#end*/
		if (!musicPlaying) {
			musicPlaying = true;
			Actuate.timer (2.0).onComplete (GameController.getInstance().playBackgroudMusic);
		}
		
	
	}
	
	// Event Handlers
	
	private function stage_onClick (event:MouseEvent):Void {
		
		GameController.getInstance().updateMousePosition(event.stageX, event.stageY );		
	}
	
	private function stage_onActivate (event:Event):Void {
		
		Actuate.resumeAll ();
		
		trace("stage_onActivate");
		if (!musicPlaying) {
			musicPlaying = true;
			Actuate.timer (2.0).onComplete (GameController.getInstance().playBackgroudMusic);
		}
	}
	
	
	private function stage_onDeactivate (event:Event):Void {
		
		Actuate.pauseAll ();

		trace("stage_onDeactivate");
		musicPlaying = false;
		GameController.getInstance().stopBackgroudMusic();
		
	}


	private function onResize(e:Event):Void {
	    var stageScaleX:Float = stage.stageWidth / NOMINAL_WIDTH;
	    var stageScaleY:Float = stage.stageHeight / NOMINAL_HEIGHT;
	    
	    stageScale = Math.min(stageScaleX, stageScaleY);
	   
	    Lib.current.x = 0;
	    Lib.current.y = 0;
	    Lib.current.scaleX = stageScale;
	    Lib.current.scaleY = stageScale;
	    trace("stageScale "+ stageScale +"  stageScaleX"+ stageScaleX + " stageScaleY"+stageScaleY);
	    if(stageScaleX > stageScaleY) {
	        Lib.current.x = (stage.stageWidth - NOMINAL_WIDTH * stageScale) / 2;
	    } else {
	        Lib.current.y = (stage.stageHeight - NOMINAL_HEIGHT * stageScale) / 2;
	    }
}
	
	
	
	// Entry point

	public static function main () {
		
		Lib.current.addChild (new CuteMain ());
		
	}
	
	
}
