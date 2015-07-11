/*! Page length control via links for DataTables
 * 2014 SpryMedia Ltd - datatables.net/license
 */
/**
 * @summary     LengthLinks
 * @description Page length control via links for DataTables
 * @version     1.1.0
 * @file        dataTables.searchHighlight.js
 * @author      SpryMedia Ltd (www.sprymedia.co.uk)
 * @contact     www.sprymedia.co.uk/contact
 * @copyright   Copyright 2014 SpryMedia Ltd.
 * 
 * License      MIT - http://datatables.net/license/mit
 *
 * This feature plug-in for DataTables adds page length control links to the
 * DataTable. The `dom` option can be used to insert the control using the `L`
 * character option and it uses the `lengthMenu` options of DataTables to
 * determine what to display.
 *
 * @example
 *   $('#myTable').DataTable( {
 *     dom: 'Lfrtip'
 *   } );
 *
 * @example
 *   $('#myTable').DataTable( {
 *     lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, "All"] ]
 *     dom: 'Lfrtip'
 *   } );
 */
!function(n,a,e){e.fn.dataTable.LengthLinks=function(n){var a=new e.fn.dataTable.Api(n),t=a.settings()[0],i=e("<div></div>").addClass(t.oClasses.sLength),l=-1;this.container=function(){return i[0]},i.on("click.dtll","a",function(n){n.preventDefault(),a.page.len(1*e(this).data("length")).draw(!1)}),a.on("draw",function(){if(a.page.len()!==l){var n=t.aLengthMenu,r=2===n.length&&e.isArray(n[0])?n[1]:n,s=2===n.length&&e.isArray(n[0])?n[0]:n,u=e.map(s,function(n,e){return n==a.page.len()?'<a class="active" data-length="'+s[e]+'">'+r[e]+"</a>":'<a data-length="'+s[e]+'">'+r[e]+"</a>"});i.html(t.oLanguage.sLengthMenu.replace("_MENU_",u.join(" | "))),l=a.page.len()}}),a.on("destroy",function(){i.off("click.dtll","a")})},e.fn.dataTable.ext.feature.push({fnInit:function(n){var a=new e.fn.dataTable.LengthLinks(n);return a.container()},cFeature:"L",sFeature:"LengthLinks"})}(window,document,jQuery);