"use strict";angular.module("com.2fdevs.videogular.plugins.poster",[]).directive("vgPosterImage",["VG_STATES",function(e){return{restrict:"E",require:"^videogular",scope:{vgUrl:"="},template:'<img ng-src="{{vgUrl}}">',link:function(r,t,c,n){function i(r){switch(r){case e.PLAY:t.css("display","none");break;case e.STOP:t.css("display","block")}}r.$watch(function(){return n.currentState},function(e,r){e!=r&&i(e)})}}}]);