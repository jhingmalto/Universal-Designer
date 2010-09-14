package com.manila.controllers
{
	import com.manila.models.FlashVarsModel;
	import com.manila.models.TabViewModel;
	import com.manila.views.designer.Design;
	import com.manila.views.MainCanvas;
	import flash.events.DataEvent;
	import org.svgweb.core.SVGViewer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * ...
	 * @author mykhel
	 */
	public class  AppController extends EventDispatcher
	{
		protected var _tabController:TabViewController = TabViewController.getInstance();
		
		public var glyphSearchURL:String = "http://174.129.214.250/channels/cp-make/tags";
		
		private var _isBackLoaded:Boolean = false;
		private var _isFrontLoaded:Boolean = false;
		
		private var _callBackFunction:Function;
		
		
		private static var __instance:AppController;
		public function AppController(singletonEnforcer:SingletonEnforcer):void 
		public static function getInstance():AppController
		{
			if(__instance == null) __instance = new AppController(new SingletonEnforcer());
			return __instance;
		}
		
		
		public function createProductsMerchId(id:uint, callback:Function):void 
		{
			var url:URLRequest = new URLRequest("http://api.make.dev/product.create.cp?merchandiseId=" + FlashVarsModel.getInstance().data.merchId);
			//var url:URLRequest = new URLRequest("product.xml");
			var loader:URLLoader = new URLLoader();
			loader.load(url);
			loader.addEventListener(Event.COMPLETE, createProductsMerchIdComplete);
			_callBackFunction = callback;
			
			url = null;
		}
		
		private function createProductsMerchIdComplete(e:Event):void 
		{
			MainCanvasViewController.getInstance().merchandiseXML = new XML(e.currentTarget.data);
			_callBackFunction();
		}
		
		
		
		/**
		 * Save the current project.
		 * Has auto-detect if the current product has front only or front and back.
		 */
		public function saveProject():void
		{
			merchandiseDef = new XML();
			// assign merchandise xml.
			merchandiseDef = MainCanvasViewController.getInstance().merchandiseXML;
			var lastDesign:Boolean = false;
			
			var _frontDesign:Design = MainCanvasViewController.getInstance().getCanvasDesignerByName("front").design;
			var _backDesign:Design = MainCanvasViewController.getInstance().getCanvasDesignerByName("back").design;
			var _hasBack:Boolean = MainCanvasViewController.getInstance().hasBack;
			if (_hasBack) {
				// save front and back design
				saveDesignFrontBack('Images', _frontDesign.svgViewer, _backDesign.svgViewer);
			}else {
				// save front only design
				saveDesignFrontOnly('Images', _frontDesign.svgXML);
			}
		}
		/**
		 * Save image to ctrine. Product type has FRONT ONLY.
		 * @param	$folderName
		 * @param	$svg
		 */
		private function saveDesignFrontOnly($folderName:String, $svg:String):void
		{
			var paramsObject:URLVariables = new URLVariables();
			paramsObject.appKey = FlashVarsModel.getInstance().data.appKey;
			paramsObject.userToken = FlashVarsModel.getInstance().data.userToken;
			paramsObject.folderName = $folderName;
			paramsObject.value = '<?xml version="1.0"?><design id="0" creator="groups.cafepress.com" name="design" parent-id="0" aspect-ratio="0" width="3000" height="3000" caption="design"/>';
			paramsObject.svg = $svg;
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = FlashVarsModel.getInstance().data.apiUrl + "/design.save.cp?v=3";
			urlRequest.contentType = 'application/x-www-form-urlencoded';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = paramsObject;
			
			var urlLoader : URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onSaveCompleteFrontOnly, false, 0, true);  
			urlLoader.load(urlRequest);
			
			paramsObject = null;
			urlRequest = null;
		}
		/**
		 * Get the FRONT ONLY designId of MerchandiseDef xml
		 * @param	e
		 */
		private function onSaveCompleteFrontOnly(e:Event):void 
		{
			var designXML:XML = new XML(e.currentTarget.data);
			designXML.ignoreWhitespaces = true;
			merchandiseDef.mediaConfiguration[0].@designId = designXML.@id;
			
			
			var paramsObject:URLVariables = new URLVariables();
			paramsObject.appKey = FlashVarsModel.getInstance().data.appKey;
			paramsObject.userToken = FlashVarsModel.getInstance().data.userToken;
			paramsObject.value = merchandiseDef;
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = FlashVarsModel.getInstance().data.apiUrl + "/product.save.cp";
			urlRequest.contentType = 'application/x-www-form-urlencoded';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = paramsObject;
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onProductSaveComplete, false, 0, true); 
			urlLoader.load(urlRequest);
			
			designXML = null;
			paramsObject = null;
			urlRequest = null;
		}
		/**
		 * Save image to ctrine. Product type has FRONT and BACK design.
		 * @param	$folderName
		 * @param	$frontSvg
		 * @param	$backSvg
		 */
		private function saveDesignFrontBack($folderName:String, $frontSvg:SVGViewer, $backSvg:SVGViewer):void
		{
			// **********************
			// save the FRONT design
			// **********************
			// if front design has no content, will create dummy node <g />
			if (!MainCanvasViewController.getInstance().getCanvasDesignerByName("front").design.hasContent) {
				$frontSvg.svgRoot.xml.g = <g />;
			}
			var paramsObject:URLVariables = new URLVariables();
			paramsObject.appKey = FlashVarsModel.getInstance().data.appKey;
			paramsObject.userToken = FlashVarsModel.getInstance().data.userToken;
			paramsObject.folderName = $folderName;
			paramsObject.value = '<?xml version="1.0"?><design id="0" creator="groups.cafepress.com" name="design" parent-id="0" aspect-ratio="0" width="3000" height="3000" caption="design"/>';
			paramsObject.svg = $frontSvg.svgRoot.xml;
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = FlashVarsModel.getInstance().data.apiUrl + "/design.save.cp?v=3";
			urlRequest.contentType = 'application/x-www-form-urlencoded';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = paramsObject;
			
			var urlLoader : URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onSaveCompleteFront, false, 0, true);  
			urlLoader.load(urlRequest);
			
			paramsObject = null;
			urlRequest = null;
			
			
			
			
			// **********************
			// save the BACK design
			// **********************
			// if back design has no content, will create dummy node <g />
			if (!MainCanvasViewController.getInstance().getCanvasDesignerByName("back").design.hasContent) {
				$backSvg.svgRoot.xml.g = <g />;
			}
			paramsObject = new URLVariables();
			paramsObject.appKey = FlashVarsModel.getInstance().data.appKey;
			paramsObject.userToken = FlashVarsModel.getInstance().data.userToken;
			paramsObject.folderName = $folderName;
			paramsObject.value = '<?xml version="1.0"?><design id="0" creator="groups.cafepress.com" name="design" parent-id="0" aspect-ratio="0" width="3000" height="3000" caption="design"/>';
			paramsObject.svg = $backSvg.svgRoot.xml;
			
			urlRequest = new URLRequest();
			urlRequest.url = FlashVarsModel.getInstance().data.apiUrl + "/design.save.cp?v=3";
			urlRequest.contentType = 'application/x-www-form-urlencoded';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = paramsObject;
			
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onSaveCompleteBack, false, 0, true);  
			urlLoader.load(urlRequest);
			
			paramsObject = null;
			urlRequest = null;
		}
		/**
		 * Get the back designId of MerchandiseDef xml
		 * @param	e
		 */
		private function onSaveCompleteBack(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, onSaveCompleteBack);  
			
			var designXML:XML = new XML(e.currentTarget.data);
			merchandiseDef.mediaConfiguration[0].@designId = designXML.@id;
			_isBackLoaded = true;
			onSaveCompleteFrontBack();
			
			designXML = null;
		}
		
		/**
		 * Get the front designId of MerchandiseDef xml
		 * designXML.@id
		 * @param	e
		 */
		private function onSaveCompleteFront(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, onSaveCompleteFront);  
			
			var designXML:XML = new XML(e.currentTarget.data);
			merchandiseDef.mediaConfiguration[1].@designId = designXML.@id;
			_isFrontLoaded = true;
			onSaveCompleteFrontBack();
			
			designXML = null;
		}
		/**
		 * Saving product to /product.save.cp API.
		 */
		private function onSaveCompleteFrontBack():void 
		{
			if (!_isBackLoaded) return;
			if (!_isFrontLoaded) return;
			
			var paramsObject:URLVariables = new URLVariables();
			paramsObject.appKey = FlashVarsModel.getInstance().data.appKey;
			paramsObject.userToken = FlashVarsModel.getInstance().data.userToken;
			paramsObject.value = merchandiseDef;
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = FlashVarsModel.getInstance().data.apiUrl + "/product.save.cp?v=3";
			urlRequest.contentType = 'application/x-www-form-urlencoded';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = paramsObject;
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onProductSaveComplete, false, 0, true); 
			urlLoader.load(urlRequest);
			
			_isBackLoaded = false;
			_isFrontLoaded = false;
			
			paramsObject = null;
			urlRequest = null;
		}
		/**
		 * Will echo the result xml of the products.
		 * @param	e
		 */
		private function onProductSaveComplete(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, onProductSaveComplete); 
			
			var resultXML:XML = XML(e.target.data);
			Debug.log("resultXML: "+resultXML);
		}
		
		
		
		
		
		
		
		
		/**
		 * Upload image to ctrine.
		 */
		public function browseBox():void 
		{
			var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
			var fileRef:FileReference = new FileReference();
			
			fileRef.addEventListener(Event.SELECT, syncVariables);
			fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			// listener if the image is uploaded.
			fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadPhotoCompleteHandler);
			// open file select dialog.
			fileRef.browse();
		}
		/**
		 * when selected an image, will start to upload the image.
		 * @param	e
		 */
		private function syncVariables(e:Event):void 
		{
			// show the upload progress bar
			_tabController.uploadsProgress.visible = true;
			
			var paramsObject:URLVariables = new URLVariables();
			paramsObject.appKey = FlashVarsModel.getInstance().data.appKey;
			paramsObject.userToken = FlashVarsModel.getInstance().data.userToken;
			paramsObject.folderName = 'CP-CustomProductUploads';
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = FlashVarsModel.getInstance().data.uploadUrl + "/image.upload.cp";
			urlRequest.contentType = 'multipart/form-data';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = paramsObject;
			
			var fileRef:FileReference = e.currentTarget as FileReference;
			// start the image upload.
			fileRef.upload(urlRequest);
			
			//fileRef = null;
			paramsObject = null;
			urlRequest = null;
		}
		private var uploadedID:String;
		private var merchandiseDef:XML;
		private function uploadPhotoCompleteHandler(e:DataEvent):void {
			var xml:XML = XML(e.data.toString()); 
			// set the uploaded image id
			uploadedID = "" + xml.value[0];
			
			// download the uploaded image (50x50) to the image/photo library
			var imgUrl:URLRequest = new URLRequest(FlashVarsModel.getInstance().data.imagingUrl + "/image/" + uploadedID + "_50x50.png");
			var imgLoader:Loader = new Loader();
			imgLoader.load(imgUrl);
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoadComplete, false, 0, true);
			// listener in downloading
			imgLoader.addEventListener(Event.ENTER_FRAME, imgProgressEnterFrame);
			
			imgUrl = null;
		}
		private function imgProgressEnterFrame(e:Event):void 
		{
			var loaded:Number = e.currentTarget.contentLoaderInfo.bytesLoaded;
			var total:Number = e.currentTarget.contentLoaderInfo.bytesTotal;
			_tabController.uploadsProgress.progress = loaded / total;
			if (loaded == total && total != 0) 
			{
				e.currentTarget.removeEventListener(Event.ENTER_FRAME, imgProgressEnterFrame);
			}
		}
		private function imgLoadComplete(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, imgLoadComplete);
			// image is downloaded. will pass the image to the library
			_tabController.tabMenu.graphcisPanel.uploadsPanel.addUploadedImage(e.currentTarget.content, FlashVarsModel.getInstance().data.imagingUrl + "/image/" + uploadedID + ".png");
		}
		// Function that fires off when the upload progress begins
		private function progressHandler(e:ProgressEvent):void {
		}
		
		
		
		/**
		 * Search glyphs from server outside cafepress.com
		 * @param	searchString
		 * @param	callBackFunction	Calls after search completed
		 */
		public function searchGlyphs(searchString:String, callBackFunction:Function):void
		{
			var results:Array;
			var paramsObject:URLVariables = new URLVariables();
			paramsObject.per_page = 100;
			paramsObject.page = 1;
			paramsObject.__lzbc__ = getTimestamp(); //timestamp
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = glyphSearchURL + "/" + searchString + ".xml";
			urlRequest.contentType = 'application/x-www-form-urlencoded';
			urlRequest.method = URLRequestMethod.GET;
			urlRequest.data = paramsObject;
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onSearchComplete, false, 0, true);  
			urlLoader.load(urlRequest);
			
			urlRequest = null;
			
			_callBackFunction = callBackFunction;
			
		}
		private function onSearchComplete($event : Event) : void 
		{
			var xml:XML = XML($event.target.data);
			var xmlList:XMLList = XMLList(xml).children();
			var svgSearchResults:Array = new Array();
			
			for (var i:int = 0; i < xmlList.length(); i++) 
			{
				svgSearchResults.push(xmlList.@svg[i]);
			}
			
			TabViewModel.getInstance().svgSearchResults = svgSearchResults;
			
			_callBackFunction();
			
			xml = null
			xmlList = null;
			svgSearchResults = null;
		}
		public function getTimestamp():String {
			var myDate:Date = new Date();
			var unixTime:Number = Math.round(myDate.getTime()/1000);
			return unixTime.toString();
		}
		
		
		
	}

}

class SingletonEnforcer { }