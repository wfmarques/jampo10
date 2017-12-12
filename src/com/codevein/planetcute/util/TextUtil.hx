package com.codevein.planetcute.util;

import openfl.Assets;

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


	public function createTextField(fontPath:String, text:String = "EMPTY", fontSize:Int = 64, fontColor:Int = 0xFFFFFF, dropShadow:Bool = false ):TextField {

		var font:Font = Assets.getFont(fontPath);
		var format:TextFormat = new TextFormat (font.fontName, fontSize, fontColor);
		var textField:TextField = new TextField ();
		textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
		textField.embedFonts = true;
		textField.multiline = true;
		textField.defaultTextFormat = format;
		textField.selectable = false;
		textField.text = text;
		textField.cacheAsBitmap = false;
		textField.height += 5;
		if (dropShadow)
			textField.filters = [new flash.filters.DropShadowFilter()];
		return textField;
	}
}