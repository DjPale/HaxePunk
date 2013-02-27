package com.haxepunk.graphics.atlas;

import nme.display.BitmapData;

class TileAtlas extends Atlas
{

	public function new(source:Dynamic, tileWidth:Int, tileHeight:Int)
	{
		var bd:BitmapData;
		if (Std.is(source, BitmapData)) bd = source;
		else bd = HXP.getBitmap(source);

		_regions = new Map<Int,AtlasRegion>();
		super(bd);

		prepareTiles(bd.width, bd.height, tileWidth, tileHeight);
	}

	public function getRegion(index:Int):AtlasRegion
	{
		return _regions.get(index);
	}

	private function prepareTiles(width:Int, height:Int, tileWidth:Int, tileHeight:Int)
	{
		var cols:Int = Math.floor(width / tileWidth);
		var rows:Int = Math.floor(height / tileHeight);

		HXP.rect.width = tileWidth;
		HXP.rect.height = tileHeight;

		HXP.point.x = HXP.point.y = 0;

		for (y in 0...rows)
		{
			HXP.rect.y = y * tileHeight;

			for (x in 0...cols)
			{
				HXP.rect.x = x * tileWidth;

				var region = createRegion(HXP.rect, HXP.point);
				_regions.set(region.tileIndex, region);
			}
		}
	}

	private var _regions:Map<Int,AtlasRegion>;
}