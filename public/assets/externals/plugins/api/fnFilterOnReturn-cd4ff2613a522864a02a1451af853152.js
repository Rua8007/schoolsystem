jQuery.fn.dataTableExt.oApi.fnFilterOnReturn=function(n){var t=this;return this.each(function(n){$.fn.dataTableExt.iApiIndex=n;var i=$("input",t.fnSettings().aanFeatures.f);return i.unbind("keyup search input").bind("keypress",function(e){13==e.which&&($.fn.dataTableExt.iApiIndex=n,t.fnFilter(i.val()))}),this}),this};