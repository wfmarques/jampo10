package com.codevein.planetcute.engine;

import flash.display.BitmapData;
import flash.display.Sprite;


class TileEngine  {

	inline private static var tileYOffset = 81;
	

	public var grid:Sprite = null;
	private var imageList:Array<String>;
	private var tileMap:Array<Array<Int>>;
	

	public function new () {
		
		
	}

	public function createGrid(aImageList:Array<String>, aTileMap:Array<Array<Int>>):Sprite {

		var cols:Array<Int> ;
		var tileId:Int;
		var delay:Float = 0.5;
		var tile:Tile;


		if (grid == null) {

			grid = new Sprite();

		} else {
			
			while (grid.numChildren > 0) {
				tile = cast(grid.getChildAt(0), Tile);
				tile.finish();
			    grid.removeChildAt(0);

			}

		}

		this.imageList = aImageList;
		this.tileMap = aTileMap;

		
		for (i in 0...tileMap.length) {

			cols = 	tileMap[i];

			for (j in 0...cols.length) {

				tileId = cols[j];

				if (tileId > -1) {

					tile = new Tile(imageList[tileId], tileId);
					tile.x = tile.width * j;
					tile.y = (TileEngine.tileYOffset * i) - 40 ;
					
					grid.addChild(tile);

				}

			}

		}

		
		return grid;

	}
}

