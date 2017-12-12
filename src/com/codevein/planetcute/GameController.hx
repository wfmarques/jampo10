package com.codevein.planetcute;

import openfl.Assets;

import flash.events.EventDispatcher;
import flash.events.Event;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;


import com.codevein.planetcute.screens.BaseScreen;
import com.codevein.planetcute.screens.IntroScreen;
import com.codevein.planetcute.screens.GameNumbersScreen;
import com.codevein.planetcute.screens.EndScreen;
import com.codevein.planetcute.screens.LangScreen;

import com.codevein.planetcute.engine.Tile;
import com.codevein.planetcute.engine.TileEngine;
import com.codevein.planetcute.engine.Entity;

import flash.media.SoundChannel;
import flash.media.Sound;
import flash.media.SoundTransform;

import com.codevein.planetcute.util.TextUtil;
import flash.text.TextField;
import flash.text.Font;


import flash.events.MouseEvent;
import flash.events.Event;


import flash.net.URLRequest;
import flash.Lib;




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
	public inline static var AUDIO_CLICK:Int   = 15;




	public inline static var DEFAULT_FONT:String = "assets/fonts/#44v2.ttf";
	public inline static var ITEM_GAME_FONT:String = "assets/fonts/AnjaElianeaccent002.ttf";


	public inline static var SHOW_INTRO_SCREEN:String = "SHOW_INTRO_SCREEN";
	public inline static var SHOW_GAME_NUMBERS_SCREEN:String = "SHOW_GAME_NUMBERS_SCREEN";
	public inline static var SHOW_END_SCREEN:String = "SHOW_END_SCREEN";
	public inline static var SHOW_LANG_SCREEN:String = "SHOW_LANG_SCREEN";



	public  static var SCREEN_WIDTH:Float = 1024;
	public  static var SCREEN_HEIGHT:Float = 768;
		

	private static var _instance:GameController = null;

	public var rootContainer:Sprite = null;
	private var screens:Map<String,BaseScreen> = null;
	public var currentScreen:BaseScreen = null;
	public var actor:Entity = null;
	public var ship:Entity = null;
	public var background:Bitmap; 
	public var appStore:Sprite; 
	public var playStore:Sprite; 
	private var channelMusic:SoundChannel;
	
	public var currentLanguage = "en";
	private var ext = ".wav";
	private var extMusic = ".ogg";
	

	private var soundCache:Array<Sound> ;
	
	

	public function new () {
		
		super();

		this.construct();
		
	}


	private function construct ():Void {
		// #if ios 
		// 	ext = ".caf";
		// 	extMusic = ".aifc";
		// #end

		#if flash 
			ext = ".mp3";

		#end
	}

	#if flash 
		public function goToAppStore(evt:Event) {

			Lib.getURL (new URLRequest ("https://itunes.apple.com/app/jampo-10/id597225094?ls=1&mt=8"));

		}

		public function goToPlayStore(evt:Event) {
			
			Lib.getURL (new URLRequest ("http://play.google.com/store/apps/details?id=com.codevein.jampo10"));
		
		}

		public function goToJampoSite(evt:Event) {
			
			Lib.getURL (new URLRequest ("http://jampogame.com"));
		
		}

		
	#end	

	public function initialize():Void {
		
		cacheSound();

		background = new Bitmap(Assets.getBitmapData ("assets/imgs/background.png"));	

		rootContainer.addChild(background);
		background.x = -200;
		background.y = -200;
		
		#if flash 
			
			appStore = new Sprite();

			appStore.addChild(TextUtil.getInstance().createTextField(GameController.ITEM_GAME_FONT, "iPhone/iPad", 16, 0xfbc90e, true));
			var img:Bitmap = new Bitmap(Assets.getBitmapData ("assets/imgs/appstore.png")); 
			img.y = 30;
			appStore.addChild(img);
			rootContainer.addChild(appStore);
			appStore.x = 20;
			appStore.y = 750 - appStore.height;


			playStore = new Sprite();

			playStore.addChild(TextUtil.getInstance().createTextField(GameController.ITEM_GAME_FONT, "Android", 16, 0xfbc90e, true));
			img = new Bitmap(Assets.getBitmapData ("assets/imgs/android.png")); 
			img.y = 30;
			playStore.addChild(img);
			rootContainer.addChild(playStore);
			playStore.x = 20 + appStore.x + appStore.width;
			playStore.y = 750 - appStore.height;


			appStore.mouseEnabled = true;
			appStore.addEventListener(MouseEvent.CLICK, goToAppStore);

			playStore.mouseEnabled = true;
			playStore.addEventListener(MouseEvent.CLICK, goToPlayStore);


			var jamposite:TextField = TextUtil.getInstance().createTextField(GameController.ITEM_GAME_FONT, "Wesley Marques - http://jampogame.com", 16, 0xfbc90e, true);
			jamposite.x = 1024 - 20 - jamposite.width ;
			jamposite.y = 750 - appStore.height;

			jamposite.mouseEnabled = true;
			jamposite.addEventListener(MouseEvent.CLICK, goToJampoSite);


			rootContainer.addChild(jamposite);
		#end
		screens = new Map<String,BaseScreen>();

		screens.set(SHOW_INTRO_SCREEN, new IntroScreen());
		screens.set(SHOW_GAME_NUMBERS_SCREEN, new GameNumbersScreen());
		screens.set(SHOW_END_SCREEN, new EndScreen());
		//screens.set(SHOW_LANG_SCREEN, new LangScreen());
		
				

		currentScreen = screens.get(SHOW_INTRO_SCREEN);
		rootContainer.addChild(currentScreen);
		currentScreen.onStart();

	}

	public function gotToScreen(screenId:String) {
		currentScreen.onRemove();
		rootContainer.removeChild(currentScreen);
		currentScreen = screens.get(screenId);
		rootContainer.addChild(currentScreen);
		currentScreen.onStart();
	
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

	

	private function cacheSound() {


		soundCache = new Array<Sound>();

		soundCache[AUDIO_BACKGROUND] = Assets.getMusic ("assets/music/mushroom_dance_0"+extMusic, true);

		for (i in 0...10) {
			soundCache[i+1] = Assets.getSound ("assets/sounds/_"+ (i+1) +"_pt"+ ext, true);
		
		}
		
		soundCache[AUDIO_JUMP_1]  = Assets.getSound ("assets/sounds/qubodup-cfork-ccby3-jump"+ ext, true);
		soundCache[AUDIO_JUMP_2]  = Assets.getSound ("assets/sounds/apricotjumpbounce-jump"+ ext, true);
		soundCache[AUDIO_FAIL]    = Assets.getSound ("assets/sounds/fail"+ ext, true);
		soundCache[AUDIO_CLAP]    = Assets.getSound ("assets/sounds/clap"+ ext, true);
		soundCache[AUDIO_CLICK]   = Assets.getSound ("assets/sounds/click"+ ext, true);

		for (i in 20...30) {
			soundCache[i+1] = Assets.getSound ("assets/sounds/_"+ (i+1-20) +"_en"+ ext, true);
		}
				
	}

	private function sound_onComplete(evt:Event) {

	}

	public function playBackgroudMusic() {
		if (soundCache[AUDIO_BACKGROUND] != null) {	
			var newTransform = new SoundTransform(0.5,0);
			trace("PLAY MUSIC  assets/music/mushroom_dance_0"+extMusic);
			channelMusic = soundCache[AUDIO_BACKGROUND].play(0,10000,newTransform);
		}
	}

	public function stopBackgroudMusic() {
		if (channelMusic != null) {		
			channelMusic.stop();
		}
	}

	

	public function playJumpSound() {	
		if (soundCache[AUDIO_JUMP_1] != null) {
			var newTransform = new SoundTransform(0.1,0);	
			soundCache[AUDIO_JUMP_1].play(0,0,newTransform);	
		}		

	}


	public function playClickSound() {
		if (soundCache[AUDIO_CLICK] != null) {	
			var newTransform = new SoundTransform(0.8,0);	
			soundCache[AUDIO_CLICK].play(0,0,newTransform);
		}
	}



	public function playJumpSound2() {
		if (soundCache[AUDIO_JUMP_2] != null) {
			var newTransform = new SoundTransform(0.1,0);	
			soundCache[AUDIO_JUMP_2].play(0,0,newTransform);
		}
	}

	public function playFailSound() {
		
		var newTransform = new SoundTransform(0.8,0);
		if (soundCache[AUDIO_FAIL] != null) {
			soundCache[AUDIO_FAIL].play(0,0,newTransform);	
		}	
	

	}


	public function playNumberSound(number:String) {
		if (soundCache != null) {
			var newTransform = new SoundTransform(0.8,0);	
			var idx:Int = Std.parseInt(number);
			if (currentLanguage == "en") {
				idx = idx + 20;
			}
			if (soundCache[idx] != null) {
				soundCache[idx].play(0,0,newTransform);
			}
		}
	}


	public function playClapSound() {
		if (soundCache[AUDIO_CLAP] != null) {	
			var newTransform = new SoundTransform(0.8,0);	
			soundCache[AUDIO_CLAP].play(0,0,newTransform);
		}
	}

}
