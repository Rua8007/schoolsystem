jQuery.fn.dataTableExt.oApi.fnGetTd=function(e,a,n,t){var o="object"==typeof a?e.oApi._fnNodeToDataIndex(e,a):a;if("undefined"!=typeof t||t)return e.aoData[o].nTr.getElementsByTagName("td")[n];var d=e.oApi._fnColumnIndexToVisible(e,n);return null!==d?e.aoData[o].nTr.getElementsByTagName("td")[d]:e.aoData[o]._anHidden[n]};