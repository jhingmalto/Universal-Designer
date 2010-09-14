package com.manila.views.panel 
{
	import com.manila.views.panel.colorpickers.SpectrumPanel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author mykhel
	 */
	public class PanelHolder extends MovieClip
	{
		
		private var _spectrumPanel:SpectrumPanel;
		
		private var masker:Sprite;
		
		public function PanelHolder() 
		{
			_spectrumPanel = new SpectrumPanel();
			addChild(_spectrumPanel);
			
			masker = new Sprite();
			addChild(masker);
			
		}
		
		public function setStyle(obj:Object):void 
		{
			x = obj.x;
			y = obj.y;
			
			graphics.clear();
			graphics.beginFill(obj.color);
			graphics.drawRect(0, 0, obj.width, obj.stageHeight - this.y - 60);
			
			masker.graphics.beginFill(0);
			masker.graphics.drawRect(0, 0, obj.width, obj.stageHeight - this.y -60);
			
			
			_spectrumPanel.mask = masker;
			
			
			this.addEventListener("onColorPanelShow", onColorPanelShow);
			
			
			_spectrumPanel.y = this.height - _spectrumPanel.height;
			
		}
		
		private function onColorPanelShow(e:Event):void 
		{
			masker.x = 0;
			masker.x = this.x - this.width;
			
			this.addEventListener("onColorPanelHide", onColorPanelHide);
		}
		
		private function onColorPanelHide(e:Event):void 
		{
			masker.x = 0;
			this.removeEventListener("onColorPanelHide", onColorPanelHide);
		}
		
		public function resize(obj:Object):void 
		{
			graphics.clear();
			graphics.beginFill(obj.color);
			graphics.drawRect(0, 0, obj.width, obj.height - this.y - 60);
		}
		
		public function get spectrumPanel():SpectrumPanel { return _spectrumPanel; }
	}

}