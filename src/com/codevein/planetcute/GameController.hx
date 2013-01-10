package com.codevein.planetcute;

import nme.Assets;

import flash.events.EventDispatcher;
import flash.events.Event;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;


import com.codevein.planetcute.screens.BaseScreen;
import com.codevein.planetcute.screens.IntroScreen;
import com.codevein.planetcute.screens.GameNumbersScreen;
import com.codevein.planetcute.screens.EndScreen;


import com.codevein.planetcute.engine.Tile;
import com.codevein.planetcute.engine.TileEngine;
import com.codevein.planetcute.engine.Entity;

import flash.media.SoundChannel;
import flash.media.Sound;
import flash.media.SoundTransform;

class GameController extends EventDispatcher {	

	
	public inline static var AUDIO_BACKGROUND:Int = 0;
	public inline static var AUDIO_N_1:Int    = 1;
	public inline static var AUDIO_N_2:Int    = 2;
	public inline static var AUDIO_N_3:Int    = 3;
	public inline static var AUDIO_N_4:Int    = 4;
	public inline static var AUDIO_N_5:Int    = 5;
	public inline static var AUDIO_N_6:Int    = 6;
	public inline static var AUDIO_N_7:Int    = 7;
	public inline static var AUDIO_N_8:Int    = 8;
	public inline static var AUDIO_N_9:Int    = 9;
	public inline static var AUDIO_N_10:Int   = 10;

	public inline static var AUDIO_JUMP_1:Int  = 11;
	public inline static var AUDIO_JUMP_2:Int  = 12;
	public inline static var AUDIO_FAIL:Int    = 13;
	public inline static var AUDIO_CLAP:Int    = 14;




	public inline static var DEFAULT_FONT:String = "assets/fonts/AgentOrange.ttf";
	public inline static var ITEM_GAME_FONT:String = "assets/fonts/#44v2.ttf";


	public inline static var SHOW_INTRO_SCREEN:String = "SHOW_INTRO_SCREEN";
	public inline static var SHOW_GAME_NUMBERS_SCREEN:String = "SHOW_GAME_NUMBERS_SCREEN";
	public inline static var SHOW_END_SCREEN:String = "SHOW_END_SCREEN";


	public  static var SCREEN_WIDTH:Float = 1024;
	public  static var SCREEN_HEIGHT:Float = 768;
		

	private static var _instance:GameController = null;

	private var rootContainer:Sprite = null;
	private var screens:Hash<BaseScreen> = null;
	public var currentScreen:BaseScreen = null;
	public var actor:Entity = null;
	public var ship:Entity = null;
	public var background:Bitmap; 
	

	private var soundCache:Array<Sound> ;
	
	

	public function new () {
		
		super();

		this.construct();
		
	}


	private function construct ():Void {

	}

	public function initialize():Void {

		background = new Bitmap(Assets.getBitmapData ("assets/imgs/background.png"));	

		rootContainer.addChild(background);
			
		

		screens = new Hash<BaseScreen>();

		screens.set(SHOW_INTRO_SCREEN, new IntroScreen());
		screens.set(SHOW_GAME_NUMBERS_SCREEN, new GameNumbersScreen());
		screens.set(SHOW_END_SCREEN, new EndScreen());
				

		currentScreen = screens.get(SHOW_END_SCREEN);
		rootContainer.addChild(currentScreen);
		currentScreen.onStart();

		addEventListener(SHOW_GAME_NUMBERS_SCREEN, goToGameNumberScreen);
		addEventListener(SHOW_INTRO_SCREEN, goToIntroScreen);
		addEventListener(SHOW_END_SCREEN, goToEndScreen);

		

		cacheSound();

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

	public function goToEndScreen(evt:Event) {
		gotToScreen(SHOW_END_SCREEN);
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

	public function getShip():Entity {

		if (ship == null) {

			ship = new Entity (Assets.getBitmapData ("assets/imgs/beetleship.png"));

		}
		
		return ship;
	}

	private  function cacheSound() {


		soundCache = new Array<Sound>();

		soundCache[AUDIO_BACKGROUND] = Assets.getSound ("assets/music/mushroom_dance_0.mp3");

		for (i in 0...10) {
			soundCache[i+1] = Assets.getSound ("assets/sounds/_"+ (i+1) +"_pt.wav");
		}
		soundCache[AUDIO_JUMP_1]  = Assets.getSound ("assets/sounds/qubodup-cfork-ccby3-jump.wav");
		soundCache[AUDIO_JUMP_2]  = Assets.getSound ("assets/sounds/apricotjumpbounce-jump.wav");
		soundCache[AUDIO_FAIL]    = Assets.getSound ("assets/sounds/fail.wav");
		soundCache[AUDIO_CLAP]    = Assets.getSound ("assets/sounds/clap.wav");
			
	}

	private function sound_onComplete(evt:Event) {

	}

	public function playBackgroudMusic() {

		var newTransform = new SoundTransform(0.5,0);
		soundCache[AUDIO_BACKGROUND].play(0,10000,newTransform);
	}

	

	public function playJumpSound() {

			
		var newTransform = new SoundTransform(0.1,0);	
		soundCache[AUDIO_JUMP_1].play(0,0,newTransform);
	
	}


	public function playJumpSound2() {
		
		var newTransform = new SoundTransform(0.1,0);	
		soundCache[AUDIO_JUMP_2].play(0,0,newTransform);

	}

	public function playFailSound() {
		
		var newTransform = new SoundTransform(0.8,0);	
		soundCache[AUDIO_FAIL].play(0,0,newTransform);

	}


	public function playNumberSound(number:String) {

		var newTransform = new SoundTransform(0.8,0);	
		var idx:Int = Std.parseInt(number);
		soundCache[idx].play(0,0,newTransform);

	}


	public function playClapSound() {
			
		var newTransform = new SoundTransform(0.8,0);	
		soundCache[AUDIO_CLAP].play(0,0,newTransform);

	}
	

	



}