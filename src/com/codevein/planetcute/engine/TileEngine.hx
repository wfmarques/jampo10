package com.codevein.planetcute.engine;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;


class TileEngine  {

	inline private static var tileYOffset = 80;
	inline private static var marginYOffset = 50;

	
	inline private static var VIRTUAL_TILE_WIDTH  = 100;
	inline private static var VIRTUAL_TILE_HEIGHT = 80;

		

	public var grid:Sprite = null;
	private var tileContainer:Sprite = null;
	private var objContainer:Sprite = null;
	

	private var imageList:Array<String> = null;
	private var tileMap:Array<Array<Int>> = null;
	private var objectMap:Array<Array<Int>> = null;
	
	

	public function new () {
		
		
	}


	public function finish() {
		var tile:Tile;

		while (grid.numChildren > 0) {
				tile = cast(grid.getChildAt(0), Tile);
				tile.finish();
			    grid.removeChildAt(0);

		}
		imageList = null;
		tileMap = null;
		objectMap = null;
	}

	public function createGrid(aImageList:Array<String>, aTileMap:Array<Array<Int>>, aObjMap:Array<Array<Int>> = null, tileCreateCall:Tile->Void= null, objectCreateCall:Tile->Void= null) :Sprite {

		var cols:Array<Int> ;
		var tileId:Int;
		var delay:Float = 0.5;
		var tile:Tile;
		var tileType:Int = 0;
		var tileImageName:String = null;


		if (grid == null) {

			grid = new Sprite();

		} else {
			
			finish();

		}

		//this.grid.cacheAsBitmap = true;
		this.imageList = aImageList;
		this.tileMap = aTileMap;
		this.objectMap = aObjMap;
		
		
		
		
		for (i in 0...tileMap.length) {

			for (j in 0...tileMap[i].length) {

				tileId = tileMap[i][j];

				if (tileId > -1) {

					tileImageName = imageList[tileId];

					if (tileImageName.toLowerCase().indexOf("tall") > -1) {

						tileType = Tile.TYPE_GROUND_TALL;
					
					} else {
				
						tileType = Tile.TYPE_GROUND;
					
					}

					tile = new Tile(imageList[tileId], tileId, tileType, j, i);
					tile.x = tile.width * j;
					tile.y = (TileEngine.tileYOffset * i) - marginYOffset;
					tile.name = "tile_"+i+"_"+j;

					grid.addChild(tile);

					if (tileCreateCall != null) {
						tileCreateCall(tile);
					}
					


					

				}

			}

		}


		//objects
		if (objectMap != null) {

			for (i in 0...objectMap.length) {

				for (j in 0...objectMap[i].length) {


					tile = cast(grid.getChildByName( "tile_"+i+"_"+j ), Tile);
					tileType = tile.type;
					tileId = objectMap[i][j];

					if (tileId > -1) {

						tile = new Tile(imageList[tileId], tileId, Tile.TYPE_OBJECT, j, i);
						tile.x = tile.width * j;
						tile.y = (TileEngine.tileYOffset * i) - ((tileType  == Tile.TYPE_GROUND_TALL)?80:40) - marginYOffset ;
						tile.name = "obj_"+i+"_"+j;

						grid.addChild(tile);

						//verifica se 1 abaixo é Tall muda o z index

						var posY = i+1;
						
						if (posY < objectMap.length) {
							var next = cast(grid.getChildByName( "tile_"+posY+"_"+j ), Tile);
							if (next != null && next.type ==  Tile.TYPE_GROUND_TALL) {
								//grid.swapChildren(next, tile);
								var idx:Int = grid.getChildIndex(next);
								grid.setChildIndex(tile, idx - 1);
							}
							
						}

						if (objectCreateCall != null) {
							objectCreateCall(tile);
						}

					}
				}
			}		

		}		
		

		return grid;

	}

	public function putObjectOverTile(ent:Entity, posX:Int, posY:Int) {

		var tile:Tile = cast(grid.getChildByName( "tile_"+posY+"_"+posX ), Tile);

		if (tile != null ) {

			var diffY:Int = ((tile.type == Tile.TYPE_GROUND_TALL)?-80:-40);
			
			ent.x = tile.x;
			ent.y = tile.y + diffY;

			posY++;


						
			if (posY < tileMap.length) {
				var next = cast(grid.getChildByName( "tile_"+posY+"_"+posX ), Tile);
				if (next != null && next.type ==  Tile.TYPE_GROUND_TALL) {
					var idx:Int = grid.getChildIndex(next);
					grid.setChildIndex(ent, idx - 1);
				}
				
			}
		
		}

	}

	public function findTileByGridPosition(aGridX:Float, aGridY:Float):Tile {
		var dp:flash.display.DisplayObject = grid.getChildByName( "tile_"+aGridY+"_"+aGridX );
 		var tile:Tile = null;
		
 		if (dp != null) {

 			tile = cast(dp, Tile);

 		}
		return tile; 
	}	

	public function findObjectByGridPosition(aGridX:Float, aGridY:Float):Tile {
		var dp:flash.display.DisplayObject = grid.getChildByName( "obj_"+aGridY+"_"+aGridX );
 		var tile:Tile = null;
		
 		if (dp != null) {

 			tile = cast(dp, Tile);

 		}
		return tile; 
	}	

	public function findGridPositionByMouse(aX:Float, aY:Float):Point {
		var i:Int = Std.int( ( aY - this.grid.y ) / VIRTUAL_TILE_HEIGHT );
		var j:Int = Std.int( ( aX  - this.grid.x) / VIRTUAL_TILE_WIDTH );
		var p:Point = new Point();
		p.x = j;
		p.y = i;

		return p;
	}	

	public function findTileByMousePosition(aX:Float, aY:Float):Tile {

		var i:Int = Std.int( ( aY - this.grid.y ) / VIRTUAL_TILE_HEIGHT );
		var j:Int = Std.int( ( aX  - this.grid.x) / VIRTUAL_TILE_WIDTH );
		
		var tile:Tile = null;
		var dp:flash.display.DisplayObject = grid.getChildByName( "tile_"+i+"_"+j );

		if (dp != null && dp.y <= ( i * VIRTUAL_TILE_HEIGHT) ) {

			var posY = i+1;
			var next:flash.display.DisplayObject = grid.getChildByName( "tile_"+posY+"_"+j );
			
			//verifica se é o pedaço de um Tall
			if (next != null && cast( next, Tile ).type == Tile.TYPE_GROUND_TALL && Math.round( aY - this.grid.y  ) >= ( ( i * VIRTUAL_TILE_HEIGHT) )  + 40)    {
				tile = cast( next, Tile );
			} else {
				tile = cast( dp, Tile );
			}

			//tile.alpha = 0.5;

		}

		return tile;
	}
}

