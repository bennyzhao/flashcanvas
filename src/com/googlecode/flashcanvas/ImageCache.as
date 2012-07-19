package com.googlecode.flashcanvas
{
  import com.googlecode.flashcanvas.Image;

  public class ImageCache {
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

  }
}

