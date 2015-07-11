/*!
 SearchHighlight for DataTables v1.0.1
 2014 SpryMedia Ltd - datatables.net/license
*/
!function(t,i,h){h(i).on("init.dt.dth",function(t,i){var n=new h.fn.dataTable.Api(i),d=h(n.table().body());(h(n.table().node()).hasClass("searchHighlight")||i.oInit.searchHighlight||h.fn.dataTable.defaults.searchHighlight)&&n.on("draw.dt.dth column-visibility.dt.dth",function(){d.unhighlight(),n.rows({filter:"applied"}).data().length&&d.highlight(n.search().split(" "))}).on("destroy",function(){n.off("draw.dt.dth column-visibility.dt.dth")})})}(window,document,jQuery);