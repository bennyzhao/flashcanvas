/*
 * FlashCanvas
 *
 * Copyright (c) 2009      Tim Cameron Ryan
 * Copyright (c) 2009-2011 FlashCanvas Project
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
 *
 * @author Tim Cameron Ryan
 * @author Shinya Muramatsu
 */

package
{
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.ContextMenuEvent;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.external.ExternalInterface;
  import flash.net.navigateToURL;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;
  import flash.system.Security;
  import flash.ui.ContextMenu;
  import flash.ui.ContextMenuItem;
  import flash.utils.Timer;


  import com.adobe.images.PNGEncoder;
  import com.googlecode.flashcanvas.Canvas;
  import com.googlecode.flashcanvas.Config;

  [SWF(backgroundColor="#FFFFFF")]
  public class FlashCanvas extends Sprite
  {

    private var canvases:Array

    private var flashCanvasId:String;
    private var timer:Timer;

    public function FlashCanvas()
    {

      // stage settings
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.align     = StageAlign.TOP_LEFT;
      stage.frameRate = 25;

      Security.allowDomain("*");

      ExternalInterface.marshallExceptions = true;
      ExternalInterface.addCallback("executeCommand", executeCommand);
      ExternalInterface.addCallback("newAuxiliaryCanvas", newAuxiliaryCanvas);
      ExternalInterface.addCallback("resize", resize);
      ExternalInterface.addCallback("saveImage", saveImage);

      // Flash Player earlier than version 10.1 has a bug that
      // ExternalInterface.objectID returns null under some conditions.
      // In such cases, get objectID via FlashVars instead.
      //
      // @see http://bugs.adobe.com/jira/browse/FP-383

      var objectId:String = ExternalInterface.objectID;
      if (objectId == null)
      {
        objectId = loaderInfo.parameters.id;
        resize(stage.stageWidth, stage.stageHeight);
      }

      // Remove the prefix "external" from objectID
      flashCanvasId = objectId.slice(8);


      // create canvas
      var canvas:Canvas = new Canvas(this, 0);
      canvases = [canvas];
      addChild(canvas);



      // Create a command parser object

      // Set the URL of the proxy script
      Config.domain = loaderInfo.url.match(/^[^\/]+\/\/[^\/]+\//)[0];
      Config.proxy  = loaderInfo.url.replace(/[^\/]+$/, "proxy.php");

      // mouse event listeners
      stage.doubleClickEnabled = true;
      stage.addEventListener(MouseEvent.CLICK,        mouseEventHandler);
      stage.addEventListener(MouseEvent.DOUBLE_CLICK, mouseEventHandler);


      // custom context menu
      try {
        var contextMenu:ContextMenu   = new ContextMenu();
        var saveItem:ContextMenuItem  = new ContextMenuItem("Save Image As...");
        var aboutItem:ContextMenuItem = new ContextMenuItem("About FlashCanvas");

        saveItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, saveImage);
        aboutItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, aboutItemSelectHandler);

        contextMenu.hideBuiltInItems();
        contextMenu.customItems.push(saveItem, aboutItem);

        this.contextMenu = contextMenu;
      } catch (e:*) {
        trace('error making menus');
      }

      try
      {
        trace("unlock 1");
        ExternalInterface.call("FlashCanvas.unlock", flashCanvasId);
      }
      catch (error:Error)
      {
        trace("unlocking error");
        timer = new Timer(0, 1);
        timer.addEventListener(TimerEvent.TIMER, timerHandler);
        timer.start();
      }
      trace("yay2");
    }


    private function timerHandler(event:TimerEvent):void
    {
      trace("timer");

      timer.removeEventListener(TimerEvent.TIMER, timerHandler);

      // Send JavaScript a message that the swf is ready
      trace("unlock 2");
      ExternalInterface.call("FlashCanvas.unlock", flashCanvasId);
    }



    /*
     * JS API
     */
    public function newAuxiliaryCanvas():Number
    {
      var internalCanvasId:uint = canvases.length;
      var canvas:Canvas = new Canvas(this, internalCanvasId);
      canvases.push(canvas);
      trace(this, "creating newAuxiliaryCanvas "+internalCanvasId);
      return internalCanvasId;
    }


    public function executeCommand(internalCanvasId:Number, data:String):*
    {
      trace("execute command from flash "+data);
      if(!internalCanvasId) {internalCanvasId = 0}
      var canvas:Canvas = canvases[internalCanvasId];

      if(!canvas) {
        throw new ArgumentError("auxiliary canvas id "+internalCanvasId+" not found");
      }

      var command:Command = canvas.getCommand(flashCanvasId);

      if(!command) {
        throw new ArgumentError("unable to get command parser for auxiliary canvas id "+internalCanvasId);
      }

      try {
        if (data.length > 0)
          return command.parse(data);
        return null;

      } catch(e:*) {
        trace("error executing command "+command.getCurrentCommand());
        throw(e);
        return null;
      }
    }


    public function resize(width:int, height:int):void
    {
      trace("resizing main canvas", width, height);
      canvases[0].resize(width, height);
    }


    public function saveImage(event:Event = null):void
    {
      var url:String = loaderInfo.url.replace(/[^\/]+$/, "save.php");
      var request:URLRequest = new URLRequest(url);

      request.contentType = "application/octet-stream";
      request.method      = URLRequestMethod.POST;
      request.data        = PNGEncoder.encode(canvases[0].bitmapData);

      navigateToURL(request, "_self");
    }


    /*
     * Aux Canvas
     */

    public function getAuxiliaryCanvas(canvasId:uint):Canvas
    {
      return canvases[canvasId];
    }

    private function mouseEventHandler(event:MouseEvent):void
    {
      var type:String = event.type;
      if (type == MouseEvent.DOUBLE_CLICK)
        type = "dblclick";

      ExternalInterface.call("FlashCanvas.trigger", flashCanvasId, type);
    }


    private function aboutItemSelectHandler(event:Event):void
    {
      var url:String         = "http://code.google.com/p/flashcanvas/";
      var request:URLRequest = new URLRequest(url);
      navigateToURL(request, "_blank");
    }
  }
}
