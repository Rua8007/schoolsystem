jQuery.fn.dataTableExt.afnFiltering.push(function(e,n,t){var a=3,u=1*document.getElementById("min").value,l=1*document.getElementById("max").value,m="-"==n[a]?0:1*n[a];return""===u&&""===l?!0:""===u&&l>m?!0:m>u&&""===l?!0:m>u&&l>m?!0:!1});