package com.codevein.planetcute;

class GameCreditsTexts  {	

	private var count:Int;
	private var credits:Array<Dynamic> ;
	private static var _instance:GameCreditsTexts ;


	public function new () {
		
		reset("en");
		
	}

	public static function getInstance():GameCreditsTexts {

		if (_instance == null) {
			_instance = new GameCreditsTexts();
		}

		return _instance;
	}

	public function reset(lang:String) {
	
		count = 0;

		credits = new Array<Dynamic>();

		credits[0] = {title:"WM Games presents", name:"JUNGO - 10"};
		credits[1] = {title:"Created by", name:"Wesley Marques"};
		credits[2] = {title:"Programmer", name:"Wesley Marques"};
		credits[3] = {title:"2D Art (Planet Cute)", name:" design by Daniel Cook\n(Lostgarden.com)"};
		credits[4] = {title:"Voice", name:"Aline Marques"};
		credits[5] = {title:"Music", name:"OpenGameArt.org"};
		credits[6] = {title:"Sound Effects", name:"YoFrankie! (c) 2008, Blender Foundation\nwww.blender.org"};
		credits[7] = {title:"Sound Effects",name:"Boing Raw Copyright 2005 cfork\nBoing Jump Copyright 2012 Iwan Gabovitch"};
		credits[8] = {title:"Sound Effects", name:"freesFX (http://www.freesfx.co.uk/)"};
		credits[9] = {title:"", name:"Thank You for Playing!"};
		
		
	}

	public function getNextCredit():Dynamic {
		var next = null;
		if (count <  credits.length) {
			next = credits[count];
		}
		count++;

		return next;
	}
}