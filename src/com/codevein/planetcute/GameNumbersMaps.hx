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
			assetList[10] = "assets/imgs/Wall_Block.png";
			assetList[11] = "assets/imgs/Door_Tall_Closed.png";
			assetList[12] = "assets/imgs/Plain_Block.png";
			assetList[13] = "assets/imgs/Chest_Open.png";
			assetList[14] = "assets/imgs/Tree_Short.png";
			assetList[15] = "assets/imgs/Stone_Block_Tall.png";//repetido para não usar o mesmo id
			assetList[16] = "assets/imgs/Ramp_West.png";
			 
									

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
			[  7, -1,  7,  -1,  7],
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

		// FASE 4

		tileMap = [
			[ 3, 10, 12, 10, 3],
			[ 0,  0, 12,  0, 0],
			[ 8,  1, 12,  1, 8],
			[ 1,  8, 12,  8, 1],
			[ 8,  1, 13,  8, 8],
				
		];


		objMap = [
			[ -1, -1, 11, -1, -1],
			[ -1, -1, -1, -1, -1],
			[  9, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1],
			[ -1, -1,  5, -1,  -1],
		
		];

		maps[3] = new GameMap(tileMap, objMap, ["1","2","3","4","5"], [1,3,13], new Point(0,0), new Point(2,4), 1);

		// FASE 5

		tileMap = [
			[ 4, 1, 4, 4, 4, 1],
			[ 4, 0, 0, 0, 4, 4],
			[ 3, 0, 1, 0, 4, 4],
			[ 4, 0, 0, 0, 4, 1],
			[ 1, 4, 1, 4, 3, 4],
				
		];


		objMap = [
			[ -1, -1, -1, 24, -1, -1],
			[ -1, -1, -1, -1, -1, 14],
			[ -1, -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, 14, -1],
			[ -1, 14, -1, 14,  5, -1],
		
		];

		maps[4] = new GameMap(tileMap, objMap, ["1","2","3","4","5","6"], [1,3,13], new Point(0,2), new Point(4,4), 1);

		// FASE 6

		tileMap = [
			[ 8, 8, 8, 1, 3, 8],
			[ 1, 8, 8, 8, 1, 8],
			[ 8, 8, 1, 8, 8, 8],
			[ 8, 8, 8, 1, 8, 1],
			[ 1, 8, 8, 8, 3, 8],
				
		];


		objMap = [
			[ -1, -1, -1, 24, -1, -1],
			[ -1, -1, -1, -1, -1, 14],
			[ -1, -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, 14, -1],
			[ -1, 14, -1, 14,  5,  -1],
		
		];

		maps[5] = new GameMap(tileMap, objMap, ["1","2","3","4","5","6","7"], [1,3,13], new Point(4,0), new Point(4,4), 1);


		// FASE 7

		tileMap = [
			[ 0, 0, 1, 0, 0, 1],
			[ 1, 0, 0, 3, 0, 4],
			[ 0, 1, 0, 0, 0, 4],
			[ 0, 4, 1, 4, 4, 1],
			[ 3, 1, 4, 4, 1, 4],
				
		];


		objMap = [
			[ -1, -1, -1, 24, -1, -1],
			[ -1, -1, -1,  5, -1, 14],
			[ -1, -1, -1, -1, -1, -1],
			[ -1, -1, -1, -1, 14, -1],
			[ -1, -1, -1, -1, -1,  -1],
		
		];

		maps[6] = new GameMap(tileMap, objMap, ["1","2","3","4","5","6","7","8"], [1,3,13], new Point(0,4), new Point(3,1), 1);


		// FASE 8

		tileMap = [
			[ 4, 4, 3, 4, 4, 1, 4],
			[ 1, 4, 4, 1, 4, 4, 4],
			[ 4, 1, 4, 4, 4, 4, 3],
			[ 4, 4, 1, 4, 4, 1, 4],
			[ 4, 1, 4, 1, 4, 4, 1],
				
		];


		objMap = [
			[ -1,  9, -1, 14, -1, -1, -1],
			[ -1, -1, -1, -1,  9, -1, -1],
			[ -1, -1, -1, -1, -1, -1,  5],
			[ -1, -1, -1, -1,  7, -1, -1],
			[ 14, -1, -1, -1, -1, 14, -1],
		
		];

		maps[7] = new GameMap(tileMap, objMap, ["1","2","3","4","5","6","7","8","9"], [1,3,13], new Point(2,0), new Point(6,2), 1);

		// FASE 9

		tileMap = [
			[ 3, 8, 1,  4, 0, 15,  1, 15],
			[ 1, 8, 4,  4, 0, 15, 13, 15],
			[ 8, 1, 4,  4, 0,  1,  6,  1],
			[ 8, 4, 1,  4, 0,  0, 15,  0],
			[ 1, 4, 4,  2, 1, 15,  1,  0],
				
		];


		objMap = [
			[ -1,  9, -1, 14, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1, -1,  5, -1],
			[ -1, -1, -1,  7, -1, -1, -1, -1],
			[ -1, -1, -1, -1, -1, -1, -1, -1],
			[ -1, -1, -1, 16, -1, -1, -1, -1],
		
		];

		maps[8] = new GameMap(tileMap, objMap, ["1","2","3","4","5","6","7","8","9","10"], [1,3,13], new Point(0,0), new Point(6,1), 1);

	}
}	
