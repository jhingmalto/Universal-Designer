package com.mpt.display {
	/**
	 * @author mykhel trinitaria 
	 * website http://mtrinitaria.com/mykhel
	 * 
	 * ColorSpectrumChart is light weight Bitmap object of color spectrum chart, which will only have 1kb of file size.
	 * It is a pure calculation of pixel within an array so the SPEED is really fast.
	 * 
	 * This can be useful in a custom color picker, instead of embeding an image of color spectrum chart, this can be alternate to use.
	 * 
	 */
	
	import com.mpt.display.ColorUtils;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class ColorSpectrumChart extends Bitmap {
		private var _cu:ColorUtils;
		public function ColorSpectrumChart():void { }
		
		/**
		 * Create linear ColorSpectrumChart
		 * @param 	$w			Number value of width of bitmap
		 * @param 	$h			Number value of height of bitmap
		 * @param 	$smoothing	Boolean value of bitmap smoothing
		 */
		public function linear($w:Number, $h:Number, $smoothing:Boolean = false):void {
			_cu = new ColorUtils();
			bitmapData = new BitmapData($w, $h, false, 0);
			_cu.createSpectrum($w);
			var i:uint = 0;
			var j:uint = 0;
			for (i = 0; i < $w; i++) {
				for (j = 0; j < $h; j++) {
					bitmapData.setPixel(i % $w, j, _cu.spectrumColors[i % $w]);
				}
			}
			_cu = null;
		}
		
		/**
		 * Create gradient linear ColorSpectrumChart
		 * @param 	$w			Number value of width of bitmap
		 * @param 	$h			Number value of height of bitmap
		 * @param 	$smoothing	Boolean value of bitmap smoothing
		 */
		public function gradientLinear($w:Number, $h:Number, $smoothing:Boolean = false):void {
			_cu = new ColorUtils();
			bitmapData = new BitmapData($w, $h, false, 0);
			_cu.createSpectrum($w);
			var i:uint = 0;
			var j:uint = 0;
			for (i = 0; i < $w; i++) {
				_cu.createGradientLinear($w, $h, [0xffffff, _cu.spectrumColors[i % $w], 0], [0, 50, 100]);
				for (j = 0; j < $h; j++) {
					bitmapData.setPixel(i % $w, j, _cu.gradientLinearColors[j]);
				}
			}
			_cu = null;
		}
		
		/**
		 * Create polar ColorSpectrumChart
		 * @param 	$w			Number value of width of bitmap
		 * @param 	$h			Number value of height of bitmap
		 * @param 	$smoothing	Boolean value of bitmap smoothing
		 */
		public function polar($w:Number, $h:Number, $smoothing:Boolean = false):void {
			var center:Point = new Point($w / 2, $h / 2);
			var pd:Point;
			var p:Number = ($w + $h) * 2;
			var px:Number;
			var py:Number;
			var a:Number;
			var r:Number;
			var n:uint = 0;
			var i:Number = 0;
			var j:uint = 0;
			_cu = new ColorUtils();
			bitmapData = new BitmapData($w, $h, false, 0);
			_cu.createSpectrum(p + 1);
			for (i = 0; i <= p; i+=.6) {
				if (i >= 0 && i < $w) { px = i; py = 0; } 
				else if (i >= $w && i < $h + $w) { px = $w; py = i - $w; } 
				else if (i >= $h + $w && i < $w + $w + $h) { px = ($w + $h + $w) - i; py = $h; }
				else if (i >= $w + $w + $h && i < $w + $w + $h + $h) { px = 0; py = ($w + $h + $w + $h) - i; }
				
				a = Math.atan2(py - center.y, px - center.x);
				pd = new Point(px, py);
				r = Math.floor(Point.distance(center, pd));
				_cu.createSpectrum(p);
				for (j = 0; j <= r; j++) {
					bitmapData.setPixel(Math.cos(a) * j + center.x, Math.sin(a) * j + center.y, _cu.spectrumColors[n]);
				}
				n = Math.round(i);
				pd = null;
			}
			_cu = null;
			center = null;
		}
		
		/**
		 * Create gradient polar ColorSpectrumChart
		 * @param 	$w			Number value of width of bitmap
		 * @param 	$h			Number value of height of bitmap
		 * @param 	$smoothing	Boolean value of bitmap smoothing
		 */
		public function gradientPolar($w:Number, $h:Number, $smoothing:Boolean = false):void {
			var center:Point = new Point($w / 2, $h / 2);
			var pd:Point;
			var p:Number = ($w + $h) * 2;
			var px:Number;
			var py:Number;
			var a:Number;
			var r:Number;
			var n:uint = 0;
			var i:Number = 0;
			var j:uint = 0;
			_cu = new ColorUtils();
			bitmapData = new BitmapData($w, $h, false, 0);
			_cu.createSpectrum(p + 1);
			for (i = 0; i <= p; i+=.6) {
				if (i >= 0 && i < $w) { px = i; py = 0; }
				else if (i >= $w && i < $h + $w) { px = $w; py = i - $w; }
				else if (i >= $h + $w && i < $w + $w + $h) { px = ($w + $h + $w) - i; py = $h; }
				else if (i >= $w + $w + $h && i < $w + $w + $h + $h) { px = 0; py = ($w + $h + $w + $h) - i; }
				
				a = Math.atan2(py - center.y, px - center.x);
				pd = new Point(px, py);
				r = Math.floor(Point.distance(center, pd));
				_cu.createGradientLinear($w, $h, [0xffffff, _cu.spectrumColors[n], 0], [0, 25, 50]);
				for (j = 0; j <= r; j++) {
					bitmapData.setPixel(Math.cos(a) * j + center.x, Math.sin(a) * j + center.y, _cu.gradientLinearColors[j]);
				}
				n = Math.round(i);
				pd  = null;
			}
			_cu = null;
			center = null;
		}
		
	}
	
}
