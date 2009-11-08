/*
 * FlashCanvas
 *
 * Copyright (c) 2009 Tim Cameron Ryan
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
 * @author Tim Cameron Ryan (developed haXe version)
 * @author Shinya Muramatsu
 */

package
{
    import com.googlecode.flashcanvas.CanvasRenderingContext2D;

    public class Command
    {
        static private var properties:Array =
        [
            // Canvas element
            "toDataURL",

            // CanvasRenderingContext2D
            "save",
            "restore",
            "scale",
            "rotate",
            "translate",
            "transform",
            "setTransform",
            "globalAlpha",
            "globalCompositeOperation",
            "strokeStyle",
            "fillStyle",
            "createLinearGradient",
            "createRadialGradient",
            "createPattern",
            "lineWidth",
            "lineCap",
            "lineJoin",
            "miterLimit",
            "shadowOffsetX",
            "shadowOffsetY",
            "shadowBlur",
            "shadowColor",
            "clearRect",
            "fillRect",
            "strokeRect",
            "beginPath",
            "closePath",
            "moveTo",
            "lineTo",
            "quadraticCurveTo",
            "bezierCurveTo",
            "arcTo",
            "rect",
            "arc",
            "fill",
            "stroke",
            "clip",
            "isPointInPath",
            "font",
            "textAlign",
            "textBaseline",
            "fillText",
            "strokeText",
            "measureText",
            "drawImage",
            "createImageData",
            "getImageData",
            "putImageData",

            // CanvasGradient
            "addColorStop"
        ];

        private var ctx:CanvasRenderingContext2D;
        private var input:CommandArray;
        private var styles:Array = [];

        public function Command(ctx:CanvasRenderingContext2D)
        {
            this.ctx = ctx;
        }

        public function parse(data:String):*
        {
            input = new CommandArray(data);
            var ret:* = "";

            while (input.position < input.length) {
                var prop:String = properties[input.readInt()];
                ret = this[prop]();
            }
            return ret;
        }

        private function toDataURL():*
        {
            // TODO: Implement
        }

        private function save():void
        {
            ctx.save();
        }

        private function restore():void
        {
            ctx.restore();
        }

        private function scale():void
        {
            var x:Number = input.readFloat();
            var y:Number = input.readFloat();
            ctx.scale(x, y);
        }

        private function rotate():void
        {
            var angle:Number = input.readFloat();
            ctx.rotate(angle);
        }
 
        private function translate():void
        {
            var x:Number = input.readFloat();
            var y:Number = input.readFloat();
            ctx.translate(x, y);
        }

        private function transform():void
        {
            var m11:Number = input.readFloat();
            var m12:Number = input.readFloat();
            var m21:Number = input.readFloat();
            var m22:Number = input.readFloat();
            var  dx:Number = input.readFloat();
            var  dy:Number = input.readFloat();
            ctx.transform(m11, m12, m21, m22, dx, dy);
        }

        private function setTransform():void
        {
            var m11:Number = input.readFloat();
            var m12:Number = input.readFloat();
            var m21:Number = input.readFloat();
            var m22:Number = input.readFloat();
            var  dx:Number = input.readFloat();
            var  dy:Number = input.readFloat();
            ctx.setTransform(m11, m12, m21, m22, dx, dy);
        }

        private function globalAlpha():void
        {
            ctx.globalAlpha = input.readFloat();
        }

        private function globalCompositeOperation():void
        {
            ctx.globalCompositeOperation = input.readUTF();
        }

        private function strokeStyle():void
        {
            var strokeStyle:String = input.readUTF();
            var id:* = parseInt(strokeStyle);
            if (isNaN(id))
                ctx.strokeStyle = strokeStyle;
            else
                ctx.strokeStyle = styles[id];
        }

        private function fillStyle():void
        {
            var fillStyle:String = input.readUTF();
            var id:* = parseInt(fillStyle);
            if (isNaN(id))
                ctx.fillStyle = fillStyle;
            else
                ctx.fillStyle = styles[id];
        }

        private function createLinearGradient():void
        {
            var x0:Number = input.readFloat();
            var y0:Number = input.readFloat();
            var x1:Number = input.readFloat();
            var y1:Number = input.readFloat();
            styles.push(ctx.createLinearGradient(x0, y0, x1, y1));
        }

        private function createRadialGradient():void
        {
            var x0:Number = input.readFloat();
            var y0:Number = input.readFloat();
            var r0:Number = input.readFloat();
            var x1:Number = input.readFloat();
            var y1:Number = input.readFloat();
            var r1:Number = input.readFloat();
            styles.push(ctx.createRadialGradient(x0, y0, r0, x1, y1, r1));
        }

        private function createPattern():void
        {
            var image:Object      = { src: input.readUTF() };
            var repetition:String = input.readUTF();
            styles.push(ctx.createPattern(image, repetition));
        }

        private function lineWidth():void
        {
            ctx.lineWidth = input.readFloat();
        }

        private function lineCap():void
        {
            ctx.lineCap = input.readUTF();
        }

        private function lineJoin():void
        {
            ctx.lineJoin = input.readUTF();
        }

        private function miterLimit():void
        {
            ctx.miterLimit = input.readFloat();
        }

        private function shadowOffsetX():void
        {
            ctx.shadowOffsetX = input.readFloat();
        }

        private function shadowOffsetY():void
        {
            ctx.shadowOffsetY = input.readFloat();
        }

        private function shadowBlur():void
        {
            ctx.shadowBlur = input.readFloat();
        }

        private function shadowColor():void
        {
            ctx.shadowColor = input.readUTF();
        }

        private function clearRect():void
        {
            var x:Number = input.readFloat();
            var y:Number = input.readFloat();
            var w:Number = input.readFloat();
            var h:Number = input.readFloat();
            ctx.clearRect(x, y, w, h);
        }

        private function fillRect():void
        {
            var x:Number = input.readFloat();
            var y:Number = input.readFloat();
            var w:Number = input.readFloat();
            var h:Number = input.readFloat();
            ctx.fillRect(x, y, w, h);
        }

        private function strokeRect():void
        {
            var x:Number = input.readFloat();
            var y:Number = input.readFloat();
            var w:Number = input.readFloat();
            var h:Number = input.readFloat();
            ctx.strokeRect(x, y, w, h);
        }

        private function beginPath():void
        {
            ctx.beginPath();
        }

        private function closePath():void
        {
            ctx.closePath();
        }

        private function moveTo():void
        {
            var x:Number = input.readFloat();
            var y:Number = input.readFloat();
            ctx.moveTo(x, y);
        }

        private function lineTo():void
        {
            var x:Number = input.readFloat();
            var y:Number = input.readFloat();
            ctx.lineTo(x, y);
        }

        private function quadraticCurveTo():void
        {
            var cpx:Number = input.readFloat();
            var cpy:Number = input.readFloat();
            var   x:Number = input.readFloat();
            var   y:Number = input.readFloat();
            ctx.quadraticCurveTo(cpx, cpy, x, y);
        }

        private function bezierCurveTo():void
        {
            var cp1x:Number = input.readFloat();
            var cp1y:Number = input.readFloat();
            var cp2x:Number = input.readFloat();
            var cp2y:Number = input.readFloat();
            var    x:Number = input.readFloat();
            var    y:Number = input.readFloat();
            ctx.bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y);
        }

        private function arcTo():void
        {
            var     x1:Number = input.readFloat();
            var     y1:Number = input.readFloat();
            var     x2:Number = input.readFloat();
            var     y2:Number = input.readFloat();
            var radius:Number = input.readFloat();
            ctx.arcTo(x1, y1, x2, y2, radius);
        }

        private function rect():void
        {
            var x:Number = input.readFloat();
            var y:Number = input.readFloat();
            var w:Number = input.readFloat();
            var h:Number = input.readFloat();
            ctx.rect(x, y, w, h);
        }

        private function arc():void
        {
            var             x:Number  = input.readFloat();
            var             y:Number  = input.readFloat();
            var        radius:Number  = input.readFloat();
            var    startAngle:Number  = input.readFloat();
            var      endAngle:Number  = input.readFloat();
            var anticlockwise:Boolean = input.readBoolean();
            ctx.arc(x, y, radius, startAngle, endAngle, anticlockwise);
        }

        private function fill():void
        {
            ctx.fill();
        }

        private function stroke():void
        {
            ctx.stroke();
        }

        private function clip():void
        {
            ctx.clip();
        }

        private function isPointInPath():*
        {
            // TODO: Implement
        }

        private function font():void
        {
            // TODO: Implement
        }

        private function textAlign():void
        {
            // TODO: Implement
        }

        private function textBaseline():void
        {
            // TODO: Implement
        }

        private function fillText():void
        {
            // TODO: Implement
        }

        private function strokeText():void
        {
            // TODO: Implement
        }

        private function measureText():*
        {
            // TODO: Implement
        }

        private function drawImage():void
        {
            var argc:int     = input.readInt();
            var image:Object = { src: input.readUTF() };

            var sx:Number;
            var sy:Number;
            var sw:Number;
            var sh:Number;
            var dx:Number;
            var dy:Number;
            var dw:Number;
            var dh:Number;

            if (argc == 3)
            {
                dx = input.readFloat();
                dy = input.readFloat();
                ctx.drawImage(image, dx, dy);
            }
            else if (argc == 5)
            {
                dx = input.readFloat();
                dy = input.readFloat();
                dw = input.readFloat();
                dh = input.readFloat();
                ctx.drawImage(image, dx, dy, dw, dh);
            }
            else if (argc == 9)
            {
                sx = input.readFloat();
                sy = input.readFloat();
                sw = input.readFloat();
                sh = input.readFloat();
                dx = input.readFloat();
                dy = input.readFloat();
                dw = input.readFloat();
                dh = input.readFloat();
                ctx.drawImage(image, sx, sy, sw, sh, dx, dy, dw, dh);
            }
        }

        private function createImageData():*
        {
            // TODO: Implement
        }

        private function getImageData():*
        {
            // TODO: Implement
        }

        private function putImageData():void
        {
            // TODO: Implement
        }

        private function addColorStop():void
        {
            var id:int        = input.readInt();
            var offset:Number = input.readFloat();
            var color:String  = input.readUTF();
            styles[id].addColorStop(offset, color);
        }
    }
}
