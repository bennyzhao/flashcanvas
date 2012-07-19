package com.googlecode.flashcanvas
{
  import flash.events.Event;
  import flash.events.ErrorEvent;
  import flash.events.EventDispatcher;

  import com.googlecode.flashcanvas.Image;
  import com.demonsters.debugger.MonsterDebugger;

  public class ImageCache extends EventDispatcher {
    public var images:Object = {}

    public function hasImage(src:String):Boolean {
      return !! images[src];
    }

    public function addImage(src:String, image:Image):void {
      images[src] = image;
    }

    public function getImage(src:String):Image {
      return images[src];
    }

    public function removeImage(src:String):Image {
      var img:Image = getImage(src);
      delete images[src];
      return img;
    }


    // Preloading
    private var preloadedImages:Object;

    public function preloadImages(images:Array):void {
      trace("preloading images", images);

      preloadedImages = {};

      var image:Image;
      var src:String;

      for(var i:int=0, l:int=images.length; i<l; i++) {
        src = images[i];
        image = new Image();
        image.addEventListener(ErrorEvent.ERROR, errorHandler);
        image.addEventListener("load", loadHandler);
        image.src = src;

        trace("preloading", src);

        preloadedImages[src] = image;
        addImage(src, image);
      }
    }

    private function errorHandler(event:ErrorEvent):void {
      var image:Image = event.target as Image;
      var src:String = image.src;

      image.removeEventListener(ErrorEvent.ERROR, errorHandler);

      // XXX how should we communicate this?
      trace("preload failed", src, event);

      delete preloadedImages[src]
      checkPreload();
    }

    private function loadHandler(event:Event):void {
      var image:Image = event.target as Image;
      var src:String = image.src;

      image.removeEventListener("load", loadHandler);

      trace("preload finished", src, event);

      delete preloadedImages[src];

      checkPreload();
    }


    private function checkPreload():void {
      var isEmpty:Boolean = true;
      for (var img:* in preloadedImages) { isEmpty = false; break; }

      if(isEmpty) {
        dispatchEvent(new Event("preloaded"));
      }
    }


    private function trace(...args:Array):void
    {
      for(var i:uint=0, l:uint=args.length; i<l; i++) {
        MonsterDebugger.trace(this, args[i]);
      }
    }

    
  }
}

