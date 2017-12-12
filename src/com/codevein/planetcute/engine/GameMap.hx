package com.codevein.planetcute.engine;

import flash.geom.Point;

class GameMap {

	public var tileMap:Array<Array<Int>>;
	public var objectMap:Array<Array<Int>>;
	public var answers:Array<String>;
	public var jumpTileType:Array<Int>;
	public var targetTilePosition:Point;
	public var startTilePosition:Point;
	public var answerTileId:Int;


	public function new( aTileMap:Array<Array<Int>>, aObjectMap:Array<Array<Int>>, aAnswers:Array<String>, aJumpTileType:Array<Int>, aStartTilePosition:Point, aTargetTilePosition:Point, aAnswerTileId:Int   ) {

		this.tileMap = aTileMap;
		this.objectMap = aObjectMap;
		this.answers = aAnswers;
		this.jumpTileType = aJumpTileType;
		this.targetTilePosition = aTargetTilePosition;
		this.answerTileId = aAnswerTileId;
		this.startTilePosition = aStartTilePosition;
	}
}