package com.codevein.planetcute;

import com.codevein.planetcute.engine.GameMap;
import flash.geom.Point;

class GameNumbersMaps  {


	public inline static var NUMBER_CONTAINER:Int = 1;
	

	private var maps:Array<GameMap>;
	private var assetList:Array<String> = null;


	public function new() {

		maps = new Array<GameMap>();

		construct();
	}

	public function totalPhases():Int {
		return maps.length;
	}
	public function getData(idx:Int) {
		return maps[idx];
	}

	public function canJumpInTile(idx:Int, aTileId:Int) {
		var can:Bool = false;

		if (maps[idx].jumpTileType != null) {
			for (tileId in maps[idx].jumpTileType) {
				if (tileId == aTileId ) {
					return true;
				}
			}
		}

		return can;

	}

	public function getAssetsList():Array<String> {

		if (assetList == null) {

			assetList = new Array<String>();

			assetList[0] = "assets/imgs/Water_Block.png";
			assetList[1] = "assets/imgs/Stone_Block_Tall.png";
			assetList[2] = "assets/imgs/Stone_Block.png";
			assetList[3] = "assets/imgs/Wall_Block_Tall.png";
			assetList[4] = "assets/imgs/Grass_Block.png";
			assetList[5] = "assets/imgs/Star.png";
			assetList[6] = "assets/imgs/Empty.png"; //utilizado como container dos numeros
			assetList[7] = "assets/imgs/Tree_Tall.png"; 
			assetList[8] = "assets/imgs/Dirt_Block.png";
			assetList[9] = "assets/imgs/Rock.png"; 
			 
									

		}

		return assetList;
		
	}

	

	public function construct() {
		//FASE 1

		var tileMap:Array<Array<Int>> = [
			[ 4, 4, 4, 4, 4],
			[ 4, 4, 3, 4, 4],
			[ 4, 1, 0, 1, 4],
			[ 4, 4, 3, 4, 4],
			[ 4, 4, 4, 4, 4],
			
		];


		var objMap:Array<Array<Int>> = [
			[  7,  7,  7,  7,  7],
			[ -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1],
			[ -1, -1,  5, -1, -1],
			[ -1, -1, -1, -1, -1],
		];

		maps[0] = new GameMap(tileMap, objMap, ["1","2"], [1,3], new Point(2,1), new Point(2,3), 1);

		// FASE 2

		tileMap = [
			[ 0, 3, 0, 0, 0],
			[ 0, 0, 0, 1, 0],
			[ 0, 1, 0, 0, 0],
			[ 0, 0, 0, 1, 0],
			[ 0, 3, 0, 0, 0],
			
		];


		objMap = [
			[ -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1],
			[ -1,  5, -1, -1, -1],
		];

		maps[1] = new GameMap(tileMap, objMap, ["1","2","3"], [1,3], new Point(1,0), new Point(1,4), 1);

		// FASE 3

		tileMap = [
			[ 3, 8, 8, 8, 1],
			[ 8, 4, 4, 1, 8],
			[ 8, 1, 4, 4, 8],
			[ 8, 4, 4, 1, 8],
			[ 8, 3, 8, 8, 8],
			
		];


		objMap = [
			[ -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1],
			[  9, -1,  7, -1, -1],
			[ -1, -1, -1, -1, -1],
			[ -1,  5, -1, -1,  9],
		];

		maps[2] = new GameMap(tileMap, objMap, ["1","2","3","4"], [1,3], new Point(0,0), new Point(1,4), 1);
	}
}	
