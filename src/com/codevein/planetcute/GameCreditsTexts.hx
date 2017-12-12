package com.codevein.planetcute;

class GameCreditsTexts  {	

	private  var count:Int;
	private  var credits:Array<Dynamic> ;
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

		if (lang == "pt") {
			credits[0] = {title:"", name:"WM Games apresentou :"};
			credits[1] = {title:"", name:"JAMPO - 10"};
			credits[2] = {title:"Programador", name:"Wesley Marques"};
			credits[3] = {title:"Arte 2D (Planet Cute)", name:" Arte por Daniel Cook\n(Lostgarden.com)"};
			credits[4] = {title:"Voz", name:"Fernanda Pinho \n (soloproducoes.com)"};
			credits[5] = {title:"Música", name:"OpenGameArt.org"};
			credits[6] = {title:"Efeitos Sonoros", name:"YoFrankie! (c) 2008, Blender Foundation\n(Blender.org)"};
			credits[7] = {title:"Efeitos Sonoros",name:"Boing Raw Copyright 2005 cfork\nBoing Jump Copyright 2012 Iwan Gabovitch"};
			credits[8] = {title:"Efeitos Sonoros", name:"FreesFX (Freesfx.co.uk)"};
			credits[9] = {title:"", name:"Obrigado por jogar!"};
			
		} else {
			credits[0] = {title:"", name:"WM Games presents :"};
			credits[1] = {title:"", name:"JAMPO - 10"};
			credits[2] = {title:"Programmer", name:"Wesley Marques"};
			credits[3] = {title:"2D Art (Planet Cute)", name:" Art by Daniel Cook\n(Lostgarden.com)"};
			credits[4] = {title:"Voice", name:"Fernanda Pinho \n (soloproducoes.com)"};
			credits[5] = {title:"Music", name:"OpenGameArt.org"};
			credits[6] = {title:"Sound Effects", name:"YoFrankie! (c) 2008, Blender Foundation\n(Blender.org)"};
			credits[7] = {title:"Sound Effects",name:"Boing Raw Copyright 2005 cfork\nBoing Jump Copyright 2012 Iwan Gabovitch"};
			credits[8] = {title:"Sound Effects", name:"FreesFX (Freesfx.co.uk)"};
			credits[9] = {title:"", name:"Thank You for Playing!"};
			
		}
		
		
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