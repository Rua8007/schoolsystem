!function(e,o){e.effects.effect.highlight=function(o,c){var n=e(this),a=["backgroundImage","backgroundColor","opacity"],t=e.effects.setMode(n,o.mode||"show"),f={backgroundColor:n.css("backgroundColor")};"hide"===t&&(f.opacity=0),e.effects.save(n,a),n.show().css({backgroundImage:"none",backgroundColor:o.color||"#ffff99"}).animate(f,{queue:!1,duration:o.duration,easing:o.easing,complete:function(){"hide"===t&&n.hide(),e.effects.restore(n,a),c()}})}}(jQuery);