package com.codevein.planetcute;

import nme.Assets;

import flash.events.EventDispatcher;
import flash.events.Event;

import flash.display.Sprite;

import com.codevein.planetcute.screens.BaseScreen;
import com.codevein.planetcute.screens.IntroScreen;
import com.codevein.planetcute.screens.GameNumbersScreen;


import com.codevein.planetcute.engine.Tile;
import com.codevein.planetcute.engine.TileEngine;
import com.codevein.planetcute.engine.Entity;



class GameController extends EventDispatcher {	

	public inline static var DEFAULT_FONT:String = "assets/fonts/AgentOrange.ttf";
	public inline static var ITEM_GAME_FONT:String = "assets/fonts/#44v2.ttf";


	public inline static var SHOW_INTRO_SCREEN:String = "SHOW_INTRO_SCREEN";
	public inline static var SHOW_GAME_NUMBERS_SCREEN:String = "SHOW_GAME_NUMBERS_SCREEN";

	public  static var SCREEN_WIDTH:Float = 1024;
	public  static var SCREEN_HEIGHT:Float = 768;
		

	private static var _instance:GameController = null;

	private var rootContainer:Sprite = null;
	private var screens:Hash<BaseScreen> = null;
	public var currentScreen:BaseScreen = null;
	public var actor:Entity = null;
	

	public function new () {
		
		super();

		this.construct();
		
	}


	private function construct ():Void {

	}

	public function initialize():Void {

		screens = new Hash<BaseScreen>();

		screens.set(SHOW_INTRO_SCREEN, new IntroScreen());
		screens.set(SHOW_GAME_NUMBERS_SCREEN, new GameNumbersScreen());
		

		currentScreen = screens.get(SHOW_INTRO_SCREEN);
		rootContainer.addChild(currentScreen);
		currentScreen.onStart();

		addEventListener(SHOW_GAME_NUMBERS_SCREEN, goToGameNumberScreen);
		addEventListener(SHOW_INTRO_SCREEN, goToIntroScreen);


	}

	private function gotToScreen(screenId:String) {
		currentScreen.onRemove();
		rootContainer.removeChild(currentScreen);
		currentScreen = screens.get(screenId);
		currentScreen.onStart();
		rootContainer.addChild(currentScreen);

	}
	public function goToGameNumberScreen(evt:Event) {
		gotToScreen(SHOW_GAME_NUMBERS_SCREEN);
	}

	public function goToIntroScreen(evt:Event) {
		gotToScreen(SHOW_INTRO_SCREEN);
	}



	public function updateMousePosition(aSX:Float, aSY:Float) {
		
		currentScreen.updateMousePosition(aSX, aSY);
	
	}	

	public static function getInstance():GameController {

		if (_instance == null) {
			_instance = new GameController();
		}

		return _instance;
	}


	public function setRootContainer(aRoot:Sprite) {
		this.rootContainer = aRoot;
	}

	public function getMainCharacter():Entity {

		if (actor == null) {

			actor = new Entity (Assets.getBitmapData ("assets/imgs/Character_Boy.png"));

		}
		
		return actor;
	}




}