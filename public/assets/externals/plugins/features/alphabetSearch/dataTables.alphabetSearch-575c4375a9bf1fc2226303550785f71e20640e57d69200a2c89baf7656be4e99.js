/*! AlphabetSearch for DataTables v1.0.0
 * 2014 SpryMedia Ltd - datatables.net/license
 */
/**
 * @summary     AlphabetSearch
 * @description Show an set of alphabet buttons alongside a table providing
 *     search input options
 * @version     1.0.0
 * @file        dataTables.alphabetSearch.js
 * @author      SpryMedia Ltd (www.sprymedia.co.uk)
 * @contact     www.sprymedia.co.uk/contact
 * @copyright   Copyright 2014 SpryMedia Ltd.
 * 
 * License      MIT - http://datatables.net/license/mit
 *
 * For more detailed information please see:
 *     http://datatables.net/blog/2014-09-22
 */
!function(){function a(a){for(var t,e={},n=0,r=a.length;r>n;n++)t=a[n].charAt(0).toUpperCase(),e[t]?e[t]++:e[t]=1;return e}function t(t,e){e.empty(),e.append("Search: ");var n=t.column(0).data(),r=a(n);$('<span class="clear active"/>').data("letter","").data("match-count",n.length).html("None").appendTo(e);for(var i=0;26>i;i++){var c=String.fromCharCode(65+i);$("<span/>").data("letter",c).data("match-count",r[c]||0).addClass(r[c]?"":"empty").html(c).appendTo(e)}$('<div class="alphabetInfo"></div>').appendTo(e)}$.fn.dataTable.Api.register("alphabetSearch()",function(a){return this.iterator("table",function(t){t.alphabetSearch=a}),this}),$.fn.dataTable.Api.register("alphabetSearch.recalc()",function(){return this.iterator("table",function(a){t(new $.fn.dataTable.Api(a),$("div.alphabet",this.table().container()))}),this}),$.fn.dataTable.ext.search.push(function(a,t){return a.alphabetSearch?t[0].charAt(0)===a.alphabetSearch?!0:!1:!0}),$.fn.dataTable.AlphabetSearch=function(a){var e=new $.fn.dataTable.Api(a),n=$('<div class="alphabet"/>');t(e,n),n.on("click","span",function(){n.find(".active").removeClass("active"),$(this).addClass("active"),e.alphabetSearch($(this).data("letter")).draw()}),n.on("mouseenter","span",function(){n.find("div.alphabetInfo").css({opacity:1,left:$(this).position().left,width:$(this).width()}).html($(this).data("match-count"))}).on("mouseleave","span",function(){n.find("div.alphabetInfo").css("opacity",0)}),this.node=function(){return n}},$.fn.DataTable.AlphabetSearch=$.fn.dataTable.AlphabetSearch,$.fn.dataTable.ext.feature.push({fnInit:function(a){var t=new $.fn.dataTable.AlphabetSearch(a);return t.node()},cFeature:"A"})}();