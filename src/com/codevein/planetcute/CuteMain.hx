package com.codevein.planetcute;


import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.MotionPath;
import com.eclecticdesignstudio.motion.easing.Quad;
import com.eclecticdesignstudio.motion.easing.Bounce;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

import com.codevein.planetcute.engine.Tile;
import com.codevein.planetcute.engine.TileEngine;
import com.codevein.planetcute.engine.Entity;


import flash.Lib;
import nme.Assets;

/**
 * @author Joshua Granick
 */
class CuteMain extends Sprite {
	
	private var engine:TileEngine;
	private var tileGrid:Sprite;
	private var boy:Entity;


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
		
		/*var creationDelay:Float;
		
		for (i in 0...10) {
			
			creationDelay = Math.random () * 10;
			Actuate.timer (creationDelay).onComplete (createCircle);
			
		}*/


		var btdMap:Array<String> = new Array<String>();
		btdMap[0] = "assets/Stone_Block_Tall.png";
		btdMap[1] = "assets/Dirt_Block.png";
		btdMap[2] = "assets/Water_Block.png";
		btdMap[3] = "assets/Wood_Block.png";
		btdMap[4] = "assets/Star.png";
		btdMap[5] = "assets/Key.png";
		btdMap[6] = "assets/Tree_Tall.png";
		btdMap[7] = "assets/Character_Princess_Girl.png";




		var tileMap:Array<Array<Int>> = [
			[ 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
			[ 0, 1, 0, 0, 2, 2, 0, 2, 2 ],
			[ 0, 1, 1, 1, 2, 2, 2, 2, 3 ],
			[ 0, 0, 0, 1, 2, 0, 3, 3, 1 ],
			[ 1, 1, 1, 1, 2, 0, 3, 3, 1 ]
		];

		var objMap:Array<Array<Int>> = [
			[-1,-1,-1,-1,-1,-1, 7,-1,-1 ],
			[-1,-1,-1,-1,-1,-1,-1,-1,-1 ],
			[-1,-1,-1,-1,-1,-1,-1,-1,-1 ],
			[-1,-1,-1,-1, 7, 5,-1,-1,-1 ],
			[-1, 5,-1,-1, 6,-1,-1,-1,-1 ]
		];
		
		engine = new TileEngine();

		tileGrid = engine.createGrid( btdMap, tileMap, objMap );
		
		tileGrid.x = ((Lib.current.stage.stageWidth - tileGrid.width) * 0.5);
		tileGrid.y = ((Lib.current.stage.stageHeight - tileGrid.height) * 0.5);

		addChild(tileGrid);


		boy = new Entity (Assets.getBitmapData ("assets/Character_Boy.png"));
 		tileGrid.addChild(boy);
			
		
	}
	
	
	/*private function createCircle ():Void {
		
		var size:Float = 5 + Math.random () * 35 + 20;
		var blur:Float = 3 + Math.random () * 12;
		
		var circle:Sprite = new Sprite ();
		circle.graphics.beginFill (Std.int (Math.random () * 0xFFFFFF));
		circle.graphics.drawCircle (0, 0, size);
		circle.alpha = 0.2 + Math.random () * 0.6;
		circle.x = Math.random () * stage.stageWidth;
		circle.y = Math.random () * stage.stageHeight;
		addChildAt (circle, 0);
		
		animateCircle (circle);
		
	}*/
	
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.addEventListener (Event.ACTIVATE, stage_onActivate);
		Lib.current.stage.addEventListener (Event.DEACTIVATE, stage_onDeactivate);
		Lib.current.stage.addEventListener (MouseEvent.MOUSE_DOWN, stage_onClick);
	
	}
	
	
	
	
	// Event Handlers
	
	
	private function stage_onClick (event:MouseEvent):Void {
		

		var tile:Tile = engine.findTileByMousePosition(event.stageX , event.stageY);

		if (tile != null) {
			var diffY:Int = ((tile.type == Tile.TYPE_GROUND_TALL)?-80:-40);
			Actuate.tween(boy, 0.5, { x: ( tile.x ), y: (tile.y + diffY ) }, false).ease(Quad.easeOut);
		}
		
		/*boy.y = tile.y - 40;
		boy.x = tile.x;


		
		var path:MotionPath = new MotionPath();
		
		var xPath:MotionPath = path.bezier (tile2.x, tile2.y - 100, tile2.x - boy.x, boy.y - 200).line(tile2.x, tile2.y - 80);
	    
		Actuate.motionPath (boy, 2, { x: xPath.x, y: xPath.y } ).ease(Bounce.easeOut);*/
		
		
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
