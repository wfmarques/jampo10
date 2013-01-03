package com.codevein.planetcute;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

import nme.Assets;

import flash.Lib;

import com.eclecticdesignstudio.motion.Actuate;

import com.codevein.planetcute.GameController;
/**
 * @author Wesley Marques
 */
class CuteMain extends Sprite {
	
	private var background:Bitmap; 
	
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
		
		
		background = new Bitmap(Assets.getBitmapData ("assets/imgs/background.png"));	

		addChild(background);
			
		
		GameController.getInstance().setRootContainer(this);	
		GameController.getInstance().initialize();
	}
	
	
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_BORDER;
		Lib.current.stage.addEventListener (Event.ACTIVATE, stage_onActivate);
		Lib.current.stage.addEventListener (Event.DEACTIVATE, stage_onDeactivate);
		Lib.current.stage.addEventListener (MouseEvent.MOUSE_DOWN, stage_onClick);


		/*#if ios
		Lib.current.stage.setFixedOrientation( -1);
		Lib.current.stage.shouldRotateInterface = function (orientation:Int):Bool {
			return (orientation == Lib.current.stage.OrientationLandscapeLeft || orientation == Lib.current.stage.OrientationLandscapeRight);
		}	
		#end*/
	
	}
	
	
	
	
	// Event Handlers
	
	
	
	private function stage_onClick (event:MouseEvent):Void {
		

		GameController.getInstance().updateMousePosition(event.stageX, event.stageY);
		
		
	}
	
	private function stage_onActivate (event:Event):Void {
		
		Actuate.resumeAll ();
		
	}
	
	
	private function stage_onDeactivate (event:Event):Void {
		
		Actuate.pauseAll ();
		
	}
	
	
	
	
	// Entry point

public static function main () {
		
		Lib.current.addChild (new CuteMain ());
		
	}
	
	
}
