package com.manila.views.panel.colorpickers
{
	import com.manila.controllers.TabViewController;
	import com.manila.models.ThemeManagerModel;
	import com.mpt.display.ColorSpectrumChart;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author mykhel
	 */
	public class SpectrumPanel extends MovieClip
	{
				
		[Embed(source="../../../../../images/colorpicker-grayscale.png")]
		public static var GRAY_SCALE:Class;

		private var _tabViewController:TabViewController = TabViewController.getInstance();
		
		private var _spectrum:ColorSpectrumChart;
		
		private var _spectrumHolder:Sprite
		private var _grayscaleHolder:Sprite
		
		private var _grayscale:Bitmap;
		private var _previewColor:Sprite;
		
		private var _label:TextField;
		
		private var _selectedColor:uint;
		
		public function SpectrumPanel() 
		{
			this.hide();
			
			
			var tf:TextFormat = new TextFormat("Arial", 16, 0x676767, true);
			
			_label = new TextField();
			_label.text = "Select your custom color";
			_label.autoSize = "left";
			_label.selectable = false;
			_label.defaultTextFormat = tf;
			_label.setTextFormat(tf);
			_label.x = 10;
			_label.y = 5;
			addChild(_label);
			
			_spectrumHolder = new Sprite();
			addChild(_spectrumHolder);
			
			_spectrum = new ColorSpectrumChart();
			_spectrum.gradientLinear(224, 160, true);
			_spectrum.rotation = -90;
			_spectrum.x = 15;
			_spectrum.y = 254;
			_spectrumHolder.addChild(_spectrum);
			_spectrumHolder.addEventListener(MouseEvent.MOUSE_MOVE, onSpectrumMouseMove);
			
			
			
			_grayscaleHolder = new Sprite();
			addChild(_grayscaleHolder);
			
			_grayscale = new SpectrumPanel.GRAY_SCALE();
			_grayscale.x = 185;
			_grayscale.y = 30;
			_grayscaleHolder.addChild(_grayscale);
			_grayscaleHolder.addEventListener(MouseEvent.MOUSE_MOVE, onGrayMouseMove);
			
			
			_previewColor = new Sprite();
			_previewColor.graphics.beginFill(0);
			_previewColor.graphics.lineStyle(2, 0xC5C4B4);
			_previewColor.graphics.drawRect(0, 0, 190, 30);
			_previewColor.x = 13;
			_previewColor.y = 264;
			addChild(_previewColor);
			
			
			graphics.beginFill(0xE4E3D1);
			graphics.lineStyle(2, 0xC5C4B4);
			graphics.drawRoundRect(0, 0, 222, 300, 10, 10);
			
			graphics.endFill();
			graphics.lineStyle(2, 0xC5C4B4);
			graphics.drawRect(13, 28, 164, 228);
			
			graphics.endFill();
			graphics.lineStyle(2, 0xC5C4B4);
			graphics.drawRect(183, 28, 20, 228);
			
		}
		
		private function onGrayMouseMove(e:MouseEvent):void 
		{
			var color:uint = _grayscale.bitmapData.getPixel(_grayscale.mouseX, _spectrum.mouseY);
			_previewColor.graphics.clear();
			_previewColor.graphics.beginFill(color);
			_previewColor.graphics.lineStyle(2, 0xC5C4B4);
			_previewColor.graphics.drawRect(0, 0, 190, 30);
			
			_selectedColor = color;
			
		}
		
		private function onSpectrumMouseMove(e:MouseEvent):void 
		{
			var color:uint = _spectrum.bitmapData.getPixel(_spectrum.mouseX, _spectrum.mouseY);
			_previewColor.graphics.clear();
			_previewColor.graphics.beginFill(color);
			_previewColor.graphics.lineStyle(2, 0xC5C4B4);
			_previewColor.graphics.drawRect(0, 0, 190, 30);
			
			_selectedColor = color;
		}
		
		public function hide():void 
		{
			this.visible = false;
			this.x = 0;
			
			if(this.parent) this.parent.dispatchEvent(new Event("onColorPanelHide"));
		}
		
		public function show():void 
		{
			this.visible = true;
			this.x = 0;
			TweenLite.to(this, .3, {x:-this.width + 10 } );
			
			_spectrumHolder.addEventListener(MouseEvent.CLICK, onColorSelect);
			_grayscaleHolder.addEventListener(MouseEvent.CLICK, onColorSelect);
			
			this.parent.dispatchEvent(new Event("onColorPanelShow"));
		}
		
		private function onColorSelect(e:MouseEvent):void 
		{
			this.hide();
			_spectrumHolder.removeEventListener(MouseEvent.CLICK, onColorSelect);
			_grayscaleHolder.removeEventListener(MouseEvent.CLICK, onColorSelect);
			
			_tabViewController.currentColorPicker.addCustomColor(_selectedColor);
			
			this.parent.dispatchEvent(new Event("onColorSelect"));
		}
		
		
	}

}