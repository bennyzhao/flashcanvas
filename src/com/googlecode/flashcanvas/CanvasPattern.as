/*
 * FlashCanvas
 *
 * Copyright (c) 2009 Shinya Muramatsu
 * Licensed under the MIT License.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package com.googlecode.flashcanvas
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;

    public class CanvasPattern
    {
        public var bitmapData:BitmapData;
        public var repetition:String;

        public function CanvasPattern(image:*, repetition:String)
        {
            var url:String         = image.src;
            var loader:Loader      = new Loader();
            var request:URLRequest = new URLRequest(url);

            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loader.load(request);

            this.repetition = repetition;
        }

        private function completeHandler(event:Event):void
        {
            // Remove the event listener
            var loaderInfo:LoaderInfo = event.target as LoaderInfo;
            loaderInfo.removeEventListener(Event.COMPLETE, arguments.callee);

            // Get BitmapData of the image
            var loader:Loader = loaderInfo.loader;
            bitmapData = Bitmap(loader.content).bitmapData;

            // Remove the prefix "external" from objectID
            var canvasId:String = ExternalInterface.objectID.slice(8);

            // Send JavaScript a message that the image has been loaded
            ExternalInterface.call("FlashCanvas.unlock", canvasId);

            // Release the memory
            loader.unload();
        }
    }
}
