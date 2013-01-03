package com.codevein.planetcute.util;

import nme.Assets;

import flash.text.TextField;
import flash.text.Font;
import flash.text.TextFormat;
/**
 * @author Wesley Marques
 */
class TextUtil  {

	private static var _instance:TextUtil = null;


	private function new() {

	}

	public static function getInstance() {

		if (_instance == null) {
			_instance = new TextUtil();
		}

		return _instance;
	}


	public function createTextField(fontPath:String, text:String = "EMPTY", fontSize:Int = 64, fontColor:Int = 0xFFFFFF ):TextField {

		var font:Font = Assets.getFont(fontPath);
		var format:TextFormat = new TextFormat (font.fontName, fontSize, fontColor);
		var textField:TextField = new TextField ();
		textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
		textField.multiline = true;
		textField.defaultTextFormat = format;
		textField.selectable = false;
		textField.embedFonts = true;
		textField.text = text;
		textField.cacheAsBitmap = true;

		return textField;
	}
}