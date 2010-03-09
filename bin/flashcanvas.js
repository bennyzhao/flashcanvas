/*
 * FlashCanvas
 *
 * Copyright (c) 2009      Tim Cameron Ryan
 * Copyright (c) 2009-2010 FlashCanvas Project
 * Released under the MIT/X License
 */
window.ActiveXObject&&!window.CanvasRenderingContext2D&&function(){function u(a){for(var b=0,c=a.length;b<c;b++)this[a[b]]=b}function l(a){var b=a.e;arguments.callee[b]||(arguments.callee[b]=0);return arguments.callee[b]++}function m(){if(document.readyState==="complete"){document.detachEvent("onreadystatechange",m);for(var a=document.getElementsByTagName("canvas"),b=0,c=a.length;b<c;++b){var e=a[b];e.getContext||n.initElement(e)}}}function o(){var a=window.event,b=a.propertyName;if(b==="width"||
b==="height"){a=a.srcElement;var c=a.getContext("2d"),e=parseInt(a[b]);if(isNaN(e)||e<0)e=b==="width"?300:150;a.style[b]=e+"px";c.H(a.clientWidth,a.clientHeight)}}function p(){var a=window.event.srcElement,b=a.parentNode;a.blur();b.focus()}function q(){window.detachEvent("onbeforeunload",q);for(var a=document.getElementsByTagName("canvas"),b=0,c=a.length;b<c;++b){var e=a[b],f=e.firstChild,g;for(g in f)if(typeof f[g]==="function")f[g]=null;for(g in e)if(typeof e[g]==="function")e[g]=null;e.detachEvent("onpropertychange",
o);f.detachEvent("onfocus",p)}window.CanvasRenderingContext2D=null;window.CanvasGradient=null;window.CanvasPattern=null;window.FlashCanvas=null}function v(){var a=document.getElementsByTagName("script");return a[a.length-1].getAttribute("src",2)}var d=new u(["toDataURL","save","restore","scale","rotate","translate","transform","setTransform","globalAlpha","globalCompositeOperation","strokeStyle","fillStyle","createLinearGradient","createRadialGradient","createPattern","lineWidth","lineCap","lineJoin",
"miterLimit","shadowOffsetX","shadowOffsetY","shadowBlur","shadowColor","clearRect","fillRect","strokeRect","beginPath","closePath","moveTo","lineTo","quadraticCurveTo","bezierCurveTo","arcTo","rect","arc","fill","stroke","clip","isPointInPath","font","textAlign","textBaseline","fillText","strokeText","measureText","drawImage","createImageData","getImageData","putImageData","addColorStop"]),i={},h={};function k(a,b){this.canvas=a;this.i=b;this.e=a.uniqueID;this.C();var c=this;window.setInterval(function(){h[c.e]===
0&&c.f()},30)}k.prototype={save:function(){this.v.push({globalAlpha:this.globalAlpha,d:this.d,strokeStyle:this.strokeStyle,fillStyle:this.fillStyle,lineWidth:this.lineWidth,lineCap:this.lineCap,lineJoin:this.lineJoin,miterLimit:this.miterLimit,shadowOffsetX:this.shadowOffsetX,shadowOffsetY:this.shadowOffsetY,shadowBlur:this.shadowBlur,shadowColor:this.shadowColor,font:this.font,textAlign:this.textAlign,textBaseline:this.textBaseline});this.b();this.c();this.h();this.g();this.q();this.p();this.a.push(d.save)},
restore:function(){if(this.v.length>0){var a=this.v.pop();this.globalAlpha=a.globalAlpha;this.d=a.d;this.strokeStyle=a.strokeStyle;this.fillStyle=a.fillStyle;this.lineWidth=a.lineWidth;this.lineCap=a.lineCap;this.lineJoin=a.lineJoin;this.miterLimit=a.miterLimit;this.shadowOffsetX=a.shadowOffsetX;this.shadowOffsetY=a.shadowOffsetY;this.shadowBlur=a.shadowBlur;this.shadowColor=a.shadowColor;this.font=a.font;this.textAlign=a.textAlign;this.textBaseline=a.textBaseline}this.a.push(d.restore)},scale:function(a,
b){this.a.push(d.scale,a,b)},rotate:function(a){this.a.push(d.rotate,a)},translate:function(a,b){this.a.push(d.translate,a,b)},transform:function(a,b,c,e,f,g){this.a.push(d.transform,a,b,c,e,f,g)},setTransform:function(a,b,c,e,f,g){this.a.push(d.setTransform,a,b,c,e,f,g)},b:function(){var a=this.a;if(this.j!==this.globalAlpha){this.j=this.globalAlpha;a.push(d.globalAlpha,this.j)}if(this.k!==this.d){this.k=this.d;a.push(d.d,this.k)}},h:function(){if(this.D!==this.strokeStyle){var a=this.D=this.strokeStyle;
this.a.push(d.strokeStyle,typeof a==="object"?a.id:a)}},g:function(){if(this.A!==this.fillStyle){var a=this.A=this.fillStyle;this.a.push(d.fillStyle,typeof a==="object"?a.id:a)}},createLinearGradient:function(a,b,c,e){this.a.push(d.createLinearGradient,a,b,c,e);return new j(this)},createRadialGradient:function(a,b,c,e,f,g){this.a.push(d.createRadialGradient,a,b,c,e,f,g);return new j(this)},createPattern:function(a,b){if(a.tagName.toUpperCase()==="IMG"){this.a.push(d.createPattern,a.src,b);if(i[this.e]){this.f();
++h[this.e]}return new r(this)}},q:function(){var a=this.a;if(this.n!==this.lineWidth){this.n=this.lineWidth;a.push(d.lineWidth,this.n)}if(this.l!==this.lineCap){this.l=this.lineCap;a.push(d.lineCap,this.l)}if(this.m!==this.lineJoin){this.m=this.lineJoin;a.push(d.lineJoin,this.m)}if(this.o!==this.miterLimit){this.o=this.miterLimit;a.push(d.miterLimit,this.o)}},c:function(){var a=this.a;if(this.t!==this.shadowOffsetX){this.t=this.shadowOffsetX;a.push(d.shadowOffsetX,this.t)}if(this.u!==this.shadowOffsetY){this.u=
this.shadowOffsetY;a.push(d.shadowOffsetY,this.u)}if(this.r!==this.shadowBlur){this.r=this.shadowBlur;a.push(d.shadowBlur,this.r)}if(this.s!==this.shadowColor){this.s=this.shadowColor;a.push(d.shadowColor,this.s)}},clearRect:function(a,b,c,e){this.a.push(d.clearRect,a,b,c,e)},fillRect:function(a,b,c,e){this.b();this.c();this.g();this.a.push(d.fillRect,a,b,c,e)},strokeRect:function(a,b,c,e){this.b();this.c();this.h();this.q();this.a.push(d.strokeRect,a,b,c,e)},beginPath:function(){this.a.push(d.beginPath)},
closePath:function(){this.a.push(d.closePath)},moveTo:function(a,b){this.a.push(d.moveTo,a,b)},lineTo:function(a,b){this.a.push(d.lineTo,a,b)},quadraticCurveTo:function(a,b,c,e){this.a.push(d.quadraticCurveTo,a,b,c,e)},bezierCurveTo:function(a,b,c,e,f,g){this.a.push(d.bezierCurveTo,a,b,c,e,f,g)},arcTo:function(a,b,c,e,f){this.a.push(d.arcTo,a,b,c,e,f)},rect:function(a,b,c,e){this.a.push(d.rect,a,b,c,e)},arc:function(a,b,c,e,f,g){g=g?1:0;this.a.push(d.arc,a,b,c,e,f,g)},fill:function(){this.b();this.c();
this.g();this.a.push(d.fill)},stroke:function(){this.b();this.c();this.h();this.q();this.a.push(d.stroke)},clip:function(){this.a.push(d.clip)},p:function(){var a=this.a;if(this.B!==this.font){this.B=this.font;try{this.i.style.font=this.font}catch(b){}var c=this.i.currentStyle;a.push(d.font,[c.fontStyle,c.fontWeight,c.fontSize,c.fontFamily].join(" "))}if(this.w!==this.textAlign){this.w=this.textAlign;a.push(d.textAlign,this.w)}if(this.z!==this.textBaseline){this.z=this.textBaseline;a.push(d.textBaseline,
this.z)}},fillText:function(a,b,c,e){this.b();this.g();this.c();this.p();this.a.push(d.fillText,a,b,c,e)},strokeText:function(a,b,c,e){this.b();this.h();this.c();this.p();this.a.push(d.strokeText,a,b,c,e)},drawImage:function(){var a=arguments,b=a.length;if(a[0].tagName.toUpperCase()==="IMG"){this.b();this.c();if(b===3)this.a.push(d.drawImage,b,a[0].src,a[1],a[2]);else if(b===5)this.a.push(d.drawImage,b,a[0].src,a[1],a[2],a[3],a[4]);else if(b===9)this.a.push(d.drawImage,b,a[0].src,a[1],a[2],a[3],a[4],
a[5],a[6],a[7],a[8]);else return;if(i[this.e]){this.f();++h[this.e]}}},C:function(){this.globalAlpha=this.j=1;this.d=this.k="source-over";this.fillStyle=this.A=this.strokeStyle=this.D="#000000";this.lineWidth=this.n=1;this.lineCap=this.l="butt";this.lineJoin=this.m="miter";this.miterLimit=this.o=10;this.shadowBlur=this.r=this.shadowOffsetY=this.u=this.shadowOffsetX=this.t=0;this.shadowColor=this.s="rgba(0,0,0,0)";this.font=this.B="10px sans-serif";this.textAlign=this.w="start";this.textBaseline=this.z=
"alphabetic";this.a=[];this.v=[]},G:function(){var a=this.a;this.a=[];return a},f:function(){var a=this.G();if(a.length>0)return eval(this.i.CallFunction('<invoke name="postCommands" returntype="javascript"><arguments><string>'+a.join("&#0;")+"</string></arguments></invoke>"))},H:function(a,b){this.i.resize(a,b);this.C()}};function j(a){this.F=a;this.id=l(a)}j.prototype={addColorStop:function(a,b){this.F.a.push(d.addColorStop,this.id,a,b)}};function r(a){this.id=l(a)}var n={initElement:function(a){var b=
parseInt(a.getAttribute("width")),c=parseInt(a.getAttribute("height"));if(isNaN(b)||b<0)b=300;if(isNaN(c)||c<0)c=150;a.style.width=b+"px";a.style.height=c+"px";b=a.uniqueID;i[b]=false;h[b]=1;a.innerHTML='<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="100%" height="100%" id="external'+b+'"><param name="allowScriptAccess" value="always"><param name="movie" value="'+s+'"><param name="quality" value="high"><param name="wmode" value="transparent"></object>';
b=a.firstChild;var e=new k(a,b);a.getContext=function(f){return f==="2d"?e:null};a.toDataURL=function(){var f=arguments,g=f[0]?f[0].toLowerCase():"image/png";g==="image/jpeg"?e.a.push(d.toDataURL,g,f[1]||0.5):e.a.push(d.toDataURL,g);return e.f()};a.attachEvent("onpropertychange",o);b.attachEvent("onfocus",p)},unlock:function(a,b){h[a]&&--h[a];if(b){b=document.getElementById("external"+a);b.resize(b.clientWidth,b.clientHeight);i[a]=true}},trigger:function(a,b){document.getElementById("external"+a).parentNode.fireEvent("on"+
b)}};document.createElement("canvas");document.createStyleSheet().cssText="canvas{display:inline-block;overflow:hidden;width:300px;height:150px}";document.attachEvent("onreadystatechange",m);window.attachEvent("onbeforeunload",q);var s=v().replace(/[^\/]+$/,"")+"flashcanvas.swf",t=new ActiveXObject("Microsoft.XMLHTTP");t.open("GET",s,false);t.send(null);window.CanvasRenderingContext2D=k;window.CanvasGradient=j;window.CanvasPattern=r;window.FlashCanvas=n}();
