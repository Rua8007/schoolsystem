jQuery&&function(i){function t(t,o){var n=i('<div class="minicolors" />'),s=i.minicolors.defaults;t.data("minicolors-initialized")||(o=i.extend(!0,{},s,o),n.addClass("minicolors-theme-"+o.theme).toggleClass("minicolors-with-opacity",o.opacity),void 0!==o.position&&i.each(o.position.split(" "),function(){n.addClass("minicolors-position-"+this)}),t.addClass("minicolors-input").data("minicolors-initialized",!1).data("minicolors-settings",o).prop("size",7).wrap(n).after('<div class="minicolors-panel minicolors-slider-'+o.control+'"><div class="minicolors-slider"><div class="minicolors-picker"></div></div><div class="minicolors-opacity-slider"><div class="minicolors-picker"></div></div><div class="minicolors-grid"><div class="minicolors-grid-inner"></div><div class="minicolors-picker"><div></div></div></div></div>'),o.inline||(t.after('<span class="minicolors-swatch"><span class="minicolors-swatch-color"></span></span>'),t.next(".minicolors-swatch").on("click",function(i){i.preventDefault(),t.focus()})),t.parent().find(".minicolors-panel").on("selectstart",function(){return!1}).end(),o.inline&&t.parent().addClass("minicolors-inline"),r(t,!1),t.data("minicolors-initialized",!0))}function o(i){var t=i.parent();i.removeData("minicolors-initialized").removeData("minicolors-settings").removeProp("size").removeClass("minicolors-input"),t.before(i).remove()}function n(i){var t=i.parent(),o=t.find(".minicolors-panel"),n=i.data("minicolors-settings");!i.data("minicolors-initialized")||i.prop("disabled")||t.hasClass("minicolors-inline")||t.hasClass("minicolors-focus")||(s(),t.addClass("minicolors-focus"),o.stop(!0,!0).fadeIn(n.showSpeed,function(){n.show&&n.show.call(i.get(0))}))}function s(){i(".minicolors-focus").each(function(){var t=i(this),o=t.find(".minicolors-input"),n=t.find(".minicolors-panel"),s=o.data("minicolors-settings");n.fadeOut(s.hideSpeed,function(){s.hide&&s.hide.call(o.get(0)),t.removeClass("minicolors-focus")})})}function a(i,t,o){var n,s,a,r,c=i.parents(".minicolors").find(".minicolors-input"),l=c.data("minicolors-settings"),h=i.find("[class$=-picker]"),d=i.offset().left,u=i.offset().top,g=Math.round(t.pageX-d),m=Math.round(t.pageY-u),p=o?l.animationSpeed:0;t.originalEvent.changedTouches&&(g=t.originalEvent.changedTouches[0].pageX-d,m=t.originalEvent.changedTouches[0].pageY-u),0>g&&(g=0),0>m&&(m=0),g>i.width()&&(g=i.width()),m>i.height()&&(m=i.height()),i.parent().is(".minicolors-slider-wheel")&&h.parent().is(".minicolors-grid")&&(n=75-g,s=75-m,a=Math.sqrt(n*n+s*s),r=Math.atan2(s,n),0>r&&(r+=2*Math.PI),a>75&&(a=75,g=75-75*Math.cos(r),m=75-75*Math.sin(r)),g=Math.round(g),m=Math.round(m)),i.is(".minicolors-grid")?h.stop(!0).animate({top:m+"px",left:g+"px"},p,l.animationEasing,function(){e(c,i)}):h.stop(!0).animate({top:m+"px"},p,l.animationEasing,function(){e(c,i)})}function e(i,t){function o(i,t){var o,n;return i.length&&t?(o=i.offset().left,n=i.offset().top,{x:o-t.offset().left+i.outerWidth()/2,y:n-t.offset().top+i.outerHeight()/2}):null}var n,s,a,e,r,l,h,u=i.val(),m=i.attr("data-opacity"),p=i.parent(),v=i.data("minicolors-settings"),b=p.find(".minicolors-swatch"),y=p.find(".minicolors-grid"),M=p.find(".minicolors-slider"),w=p.find(".minicolors-opacity-slider"),x=y.find("[class$=-picker]"),k=M.find("[class$=-picker]"),C=w.find("[class$=-picker]"),S=o(x,y),z=o(k,M),D=o(C,w);if(t.is(".minicolors-grid, .minicolors-slider")){switch(v.control){case"wheel":e=y.width()/2-S.x,r=y.height()/2-S.y,l=Math.sqrt(e*e+r*r),h=Math.atan2(r,e),0>h&&(h+=2*Math.PI),l>75&&(l=75,S.x=69-75*Math.cos(h),S.y=69-75*Math.sin(h)),s=g(l/.75,0,100),n=g(180*h/Math.PI,0,360),a=g(100-Math.floor(z.y*(100/M.height())),0,100),u=f({h:n,s:s,b:a}),M.css("backgroundColor",f({h:n,s:s,b:100}));break;case"saturation":n=g(parseInt(S.x*(360/y.width()),10),0,360),s=g(100-Math.floor(z.y*(100/M.height())),0,100),a=g(100-Math.floor(S.y*(100/y.height())),0,100),u=f({h:n,s:s,b:a}),M.css("backgroundColor",f({h:n,s:100,b:a})),p.find(".minicolors-grid-inner").css("opacity",s/100);break;case"brightness":n=g(parseInt(S.x*(360/y.width()),10),0,360),s=g(100-Math.floor(S.y*(100/y.height())),0,100),a=g(100-Math.floor(z.y*(100/M.height())),0,100),u=f({h:n,s:s,b:a}),M.css("backgroundColor",f({h:n,s:s,b:100})),p.find(".minicolors-grid-inner").css("opacity",1-a/100);break;default:n=g(360-parseInt(z.y*(360/M.height()),10),0,360),s=g(Math.floor(S.x*(100/y.width())),0,100),a=g(100-Math.floor(S.y*(100/y.height())),0,100),u=f({h:n,s:s,b:a}),y.css("backgroundColor",f({h:n,s:100,b:100}))}i.val(d(u,v.letterCase))}t.is(".minicolors-opacity-slider")&&(m=v.opacity?parseFloat(1-D.y/w.height()).toFixed(2):1,v.opacity&&i.attr("data-opacity",m)),b.find("SPAN").css({backgroundColor:u,opacity:m}),c(i,u,m)}function r(i,t){var o,n,s,a,e,r,l,h=i.parent(),m=i.data("minicolors-settings"),p=h.find(".minicolors-swatch"),b=h.find(".minicolors-grid"),y=h.find(".minicolors-slider"),M=h.find(".minicolors-opacity-slider"),w=b.find("[class$=-picker]"),x=y.find("[class$=-picker]"),k=M.find("[class$=-picker]");switch(o=d(u(i.val(),!0),m.letterCase),o||(o=d(u(m.defaultValue,!0),m.letterCase)),n=v(o),t||i.val(o),m.opacity&&(s=""===i.attr("data-opacity")?1:g(parseFloat(i.attr("data-opacity")).toFixed(2),0,1),isNaN(s)&&(s=1),i.attr("data-opacity",s),p.find("SPAN").css("opacity",s),e=g(M.height()-M.height()*s,0,M.height()),k.css("top",e+"px")),p.find("SPAN").css("backgroundColor",o),m.control){case"wheel":r=g(Math.ceil(.75*n.s),0,b.height()/2),l=n.h*Math.PI/180,a=g(75-Math.cos(l)*r,0,b.width()),e=g(75-Math.sin(l)*r,0,b.height()),w.css({top:e+"px",left:a+"px"}),e=150-n.b/(100/b.height()),""===o&&(e=0),x.css("top",e+"px"),y.css("backgroundColor",f({h:n.h,s:n.s,b:100}));break;case"saturation":a=g(5*n.h/12,0,150),e=g(b.height()-Math.ceil(n.b/(100/b.height())),0,b.height()),w.css({top:e+"px",left:a+"px"}),e=g(y.height()-n.s*(y.height()/100),0,y.height()),x.css("top",e+"px"),y.css("backgroundColor",f({h:n.h,s:100,b:n.b})),h.find(".minicolors-grid-inner").css("opacity",n.s/100);break;case"brightness":a=g(5*n.h/12,0,150),e=g(b.height()-Math.ceil(n.s/(100/b.height())),0,b.height()),w.css({top:e+"px",left:a+"px"}),e=g(y.height()-n.b*(y.height()/100),0,y.height()),x.css("top",e+"px"),y.css("backgroundColor",f({h:n.h,s:n.s,b:100})),h.find(".minicolors-grid-inner").css("opacity",1-n.b/100);break;default:a=g(Math.ceil(n.s/(100/b.width())),0,b.width()),e=g(b.height()-Math.ceil(n.b/(100/b.height())),0,b.height()),w.css({top:e+"px",left:a+"px"}),e=g(y.height()-n.h/(360/y.height()),0,y.height()),x.css("top",e+"px"),b.css("backgroundColor",f({h:n.h,s:100,b:100}))}i.data("minicolors-initialized")&&c(i,o,s)}function c(i,t,o){var n=i.data("minicolors-settings"),s=i.data("minicolors-lastChange");s&&s.hex===t&&s.opacity===o||(i.data("minicolors-lastChange",{hex:t,opacity:o}),n.change&&(n.changeDelay?(clearTimeout(i.data("minicolors-changeTimeout")),i.data("minicolors-changeTimeout",setTimeout(function(){n.change.call(i.get(0),t,o)},n.changeDelay))):n.change.call(i.get(0),t,o)),i.trigger("change").trigger("input"))}function l(t){var o=u(i(t).val(),!0),n=y(o),s=i(t).attr("data-opacity");return n?(void 0!==s&&i.extend(n,{a:parseFloat(s)}),n):null}function h(t,o){var n=u(i(t).val(),!0),s=y(n),a=i(t).attr("data-opacity");return s?(void 0===a&&(a=1),o?"rgba("+s.r+", "+s.g+", "+s.b+", "+parseFloat(a)+")":"rgb("+s.r+", "+s.g+", "+s.b+")"):null}function d(i,t){return"uppercase"===t?i.toUpperCase():i.toLowerCase()}function u(i,t){return i=i.replace(/[^A-F0-9]/gi,""),3!==i.length&&6!==i.length?"":(3===i.length&&t&&(i=i[0]+i[0]+i[1]+i[1]+i[2]+i[2]),"#"+i)}function g(i,t,o){return t>i&&(i=t),i>o&&(i=o),i}function m(i){var t={},o=Math.round(i.h),n=Math.round(255*i.s/100),s=Math.round(255*i.b/100);if(0===n)t.r=t.g=t.b=s;else{var a=s,e=(255-n)*s/255,r=(a-e)*(o%60)/60;360===o&&(o=0),60>o?(t.r=a,t.b=e,t.g=e+r):120>o?(t.g=a,t.b=e,t.r=a-r):180>o?(t.g=a,t.r=e,t.b=e+r):240>o?(t.b=a,t.r=e,t.g=a-r):300>o?(t.b=a,t.g=e,t.r=e+r):360>o?(t.r=a,t.g=e,t.b=a-r):(t.r=0,t.g=0,t.b=0)}return{r:Math.round(t.r),g:Math.round(t.g),b:Math.round(t.b)}}function p(t){var o=[t.r.toString(16),t.g.toString(16),t.b.toString(16)];return i.each(o,function(i,t){1===t.length&&(o[i]="0"+t)}),"#"+o.join("")}function f(i){return p(m(i))}function v(i){var t=b(y(i));return 0===t.s&&(t.h=360),t}function b(i){var t={h:0,s:0,b:0},o=Math.min(i.r,i.g,i.b),n=Math.max(i.r,i.g,i.b),s=n-o;return t.b=n,t.s=0!==n?255*s/n:0,0!==t.s?i.r===n?t.h=(i.g-i.b)/s:i.g===n?t.h=2+(i.b-i.r)/s:t.h=4+(i.r-i.g)/s:t.h=-1,t.h*=60,t.h<0&&(t.h+=360),t.s*=100/255,t.b*=100/255,t}function y(i){return i=parseInt(i.indexOf("#")>-1?i.substring(1):i,16),{r:i>>16,g:(65280&i)>>8,b:255&i}}i.minicolors={defaults:{animationSpeed:50,animationEasing:"swing",change:null,changeDelay:0,control:"hue",defaultValue:"",hide:null,hideSpeed:100,inline:!1,letterCase:"lowercase",opacity:!1,position:"bottom left",show:null,showSpeed:100,theme:"default"}},i.extend(i.fn,{minicolors:function(a,e){switch(a){case"destroy":return i(this).each(function(){o(i(this))}),i(this);case"hide":return s(),i(this);case"opacity":return void 0===e?i(this).attr("data-opacity"):(i(this).each(function(){r(i(this).attr("data-opacity",e))}),i(this));case"rgbObject":return l(i(this),"rgbaObject"===a);case"rgbString":case"rgbaString":return h(i(this),"rgbaString"===a);case"settings":return void 0===e?i(this).data("minicolors-settings"):(i(this).each(function(){var t=i(this).data("minicolors-settings")||{};o(i(this)),i(this).minicolors(i.extend(!0,t,e))}),i(this));case"show":return n(i(this).eq(0)),i(this);case"value":return void 0===e?i(this).val():(i(this).each(function(){r(i(this).val(e))}),i(this));default:return"create"!==a&&(e=a),i(this).each(function(){t(i(this),e)}),i(this)}}}),i(document).on("mousedown.minicolors touchstart.minicolors",function(t){i(t.target).parents().add(t.target).hasClass("minicolors")||s()}).on("mousedown.minicolors touchstart.minicolors",".minicolors-grid, .minicolors-slider, .minicolors-opacity-slider",function(t){var o=i(this);t.preventDefault(),i(document).data("minicolors-target",o),a(o,t,!0)}).on("mousemove.minicolors touchmove.minicolors",function(t){var o=i(document).data("minicolors-target");o&&a(o,t)}).on("mouseup.minicolors touchend.minicolors",function(){i(this).removeData("minicolors-target")}).on("mousedown.minicolors touchstart.minicolors",".minicolors-swatch",function(t){var o=i(this).parent().find(".minicolors-input");t.preventDefault(),n(o)}).on("focus.minicolors",".minicolors-input",function(){var t=i(this);t.data("minicolors-initialized")&&n(t)}).on("blur.minicolors",".minicolors-input",function(){var t=i(this),o=t.data("minicolors-settings");t.data("minicolors-initialized")&&(t.val(u(t.val(),!0)),""===t.val()&&t.val(u(o.defaultValue,!0)),t.val(d(t.val(),o.letterCase)))}).on("keydown.minicolors",".minicolors-input",function(t){var o=i(this);if(o.data("minicolors-initialized"))switch(t.keyCode){case 9:s();break;case 13:case 27:s(),o.blur()}}).on("keyup.minicolors",".minicolors-input",function(){var t=i(this);t.data("minicolors-initialized")&&r(t,!0)}).on("paste.minicolors",".minicolors-input",function(){var t=i(this);t.data("minicolors-initialized")&&setTimeout(function(){r(t,!0)},1)})}(jQuery);