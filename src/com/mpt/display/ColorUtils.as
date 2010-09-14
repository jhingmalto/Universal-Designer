package com.mpt.display {
	/**
	 * @author mykhel trinitaria 
	 * website http://mtrinitaria.com/mykhel
	 * 
	 * ColorUtils is set of functions which will help developers a lot in reagards with color manipulation.
	 * 
	 * spectrumColors - read only, will return array of colors after calling createSpectrum method.
	 * createSpectrum - set and calculate the colors equally distributed accordingly to the colors spectrum.
	 * gradientLinearColors - read only, will return array of colors with gradients after calling createGradientLinear method.
	 * createGradientLinear - set and calculate the colors with gradients equally distributed accordingly to the colors spectrum with gradients.
	 * Hex2RGB - convert hex to RGB object.
	 * Hex2ARGB - convert hex to ARGB object. Alpa will take effect if the transparent of Bitmap object is true;
	 * RGB2Hex - convert RGB object to hex.
	 * ARGB2Hex - convert ARGB object to hex. Alpa will take effect if the transparent of Bitmap object is true;
	 */
	
	
	public class ColorUtils  {
		public function ColorUtils():void { super(); }
		
		private var _sc:Array;
		
		/**
		 * Get Array of linear colros. Return Array.
		 * @return	Array
		 */
		public function get spectrumColors():Array {
			return _sc;
		}
		
		/**
		 * Set the spectrumColors. colors and ratios should have equal of length.
		 * @param	$n			uint value of length of arrays to be returned
		 */
		public function createSpectrum($n:uint = 100):void {
			_sc = new Array();
			var r:uint = 0;
			var g:uint = 0;
			var b:uint = 0;
			var j:uint = 0;
			for (var i:int = 0; i < $n; i++) {
				j = Math.floor(i % $n);
				if (j <= ($n * 1 / 6)) { r = 255; g = I(i, $n); b = 0; } 
				if (j >= ($n * 1 / 6) && j <= ($n * 2 / 6)) { r = 255 - I(i, $n); g = 255; b = 0; }
				if (j >= ($n * 2 / 6) && j <= ($n * 3 / 6)) { r = 0; g = 255; b = I(i, $n); } 
				if (j >= ($n * 3 / 6) && j <= ($n * 4 / 6)) { r = 0; g = 255 - I(i, $n); b = 255; }
				if (j >= ($n * 4 / 6) && j <= ($n * 5 / 6)) { r = I(i, $n); g = 0; b = 255; }
				if (j >= ($n * 5 / 6)) { r = 255; g = 0; b = 255 - I(i, $n); }
				_sc.push(r << 16 | g << 8 | b);
			}
		}
		
		private function I(i:uint, $n:uint):uint {
			return ((i % $n) / ($n * 1 / 6) * 255) % 255;
		}
		
		/**
		 * Convert uint value to RGB object. Return Object {r, g, b}
		 * @param 	$hex		Uint value to convert to RGB object
		 * @return	Object		{r, g, b}
		 */
		public function Hex2RGB ($hex:uint):Object {
			var rgb:Object = new Object
				rgb.r = ($hex & 0xff0000) >> 16;
				rgb.g = ($hex & 0x00ff00) >> 8;
				rgb.b = ($hex & 0x0000ff);
			return rgb;
		}
		
		/**
		 * Convert RGB object to uint value. Return uint
		 * @param 	rgb			Object of {r, g b}
		 * @return	uint
		 */
		public function RGB2Hex (rgb:Object):uint {
			return rgb.r << 16 | rgb.g << 8 | rgb.b;
		}
		
		/**
		 * Convert uint value to ARGB object. Return Object {a, r, g, b}
		 * @param 	$hex		Uint value to convert to RGB object
		 * @param	alpha		alpha value of rgb
		 * @return	Object		{a, r, g, b}
		 */
		public function Hex2ARGB ($hex:uint, alpha:Number):Object {
			var rgb:Object = new Object
				rgb.a = (alpha * 0xff) >> 24;
				rgb.r = ($hex & 0xff0000) >> 16;
				rgb.g = ($hex & 0x00ff00) >> 8;
				rgb.b = ($hex & 0x0000ff);
			return rgb;
		}
		
		/**
		 * Convert ARGB object to uint. Return uint
		 * @param 	rgb			Object of {r, g b}
		 * @param	alpha		alpha value of rgb
		 * @return	uint
		 */
		public function ARGB2Hex (alpha:Number, rgb:Object):uint {
			return (rgb.a * 0xff) << 24 | rgb.r << 16 | rgb.g << 8 | rgb.b;
		}
		
		private var _glc:Array;
		
		/**
		 * Get Array of gradient linear colros. Return Array.
		 * @return	Array
		 */
		public function get gradientLinearColors():Array { return _glc; }
		
		/**
		 * Set the gradientLinearColors. colors and ratios should have equal of length.
		 * @param	$n			uint value of length of arrays to be returned
		 * @param	colors		Array of colors to be returned
		 * @param	ratios		Array of ratios of colors to be returned
		 */
		public function createGradientLinear($n:uint, $l:uint, colors:Array, ratios:Array):void {
			if (colors.length != ratios.length) {
				trace("*** length of colors and ratios are not equal.");
				return;
			}
			_glc = new Array();
			var r:uint
			var g:uint
			var b:uint
			var ii:uint
			var div:uint
			var aColors:Array = new Array();
			for (var i:int = 0; i < colors.length; i++) {
				aColors.push(Hex2RGB(colors[i]));
			}
			
			for (var j:int = 0; j < colors.length - 1; j++) {
				for (i = Math.round(ratios[j] / 100 * $l); i < Math.round(ratios[j + 1] / 100 * $l); i++) {
					ii = Math.round(i - ratios[j] / 100 * $l);
					//div = 100;
					div = Math.round((ratios[j + 1] - ratios[j]) / 100 * $l);
					r = Math.floor(aColors[j].r - ((aColors[j].r - aColors[j + 1].r) / div) * ii);
					g = Math.floor(aColors[j].g - ((aColors[j].g - aColors[j + 1].g) / div) * ii);
					b = Math.floor(aColors[j].b - ((aColors[j].b - aColors[j + 1].b) / div) * ii);
					_glc.push((r < 0 ? 0 : r) << 16 | (g < 0 ? 0 : g) << 8 | (b < 0 ? 0 : b));
				}
			}
			aColors = null;
		}
		
	}
}