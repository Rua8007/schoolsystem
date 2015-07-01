/*!
 * https://github.com/es-shims/es5-shim
 * @license es5-shim Copyright 2009-2014 by contributors, MIT License
 * see https://github.com/es-shims/es5-shim/blob/v4.0.5/LICENSE
 */

(function(t,e){"use strict";if(typeof define==="function"&&define.amd){define(e)}else if(typeof exports==="object"){module.exports=e()}else{t.returnExports=e()}})(this,function(){var t=Array.prototype;var e=Object.prototype;var r=Function.prototype;var n=String.prototype;var i=Number.prototype;var a=t.slice;var o=t.splice;var u=t.push;var l=t.unshift;var s=r.call;var f=e.toString;var c=function(t){return f.call(t)==="[object Function]"};var p=function(t){return f.call(t)==="[object RegExp]"};var h=function le(t){return f.call(t)==="[object Array]"};var v=function se(t){return f.call(t)==="[object String]"};var g=function fe(t){var e=f.call(t);var r=e==="[object Arguments]";if(!r){r=!h(t)&&t!==null&&typeof t==="object"&&typeof t.length==="number"&&t.length>=0&&c(t.callee)}return r};var y=Object.defineProperty&&function(){try{Object.defineProperty({},"x",{});return true}catch(t){return false}}();var d;if(y){d=function(t,e,r,n){if(!n&&e in t){return}Object.defineProperty(t,e,{configurable:true,enumerable:false,writable:true,value:r})}}else{d=function(t,e,r,n){if(!n&&e in t){return}t[e]=r}}var m=function(t,r,n){for(var i in r){if(e.hasOwnProperty.call(r,i)){d(t,i,r[i],n)}}};function b(t){var e=+t;if(e!==e){e=0}else if(e!==0&&e!==1/0&&e!==-(1/0)){e=(e>0||-1)*Math.floor(Math.abs(e))}return e}function w(t){var e=typeof t;return t===null||e==="undefined"||e==="boolean"||e==="number"||e==="string"}function x(t){var e,r,n;if(w(t)){return t}r=t.valueOf;if(c(r)){e=r.call(t);if(w(e)){return e}}n=t.toString;if(c(n)){e=n.call(t);if(w(e)){return e}}throw new TypeError}var O={ToObject:function(t){if(t==null){throw new TypeError("can't convert "+t+" to object")}return Object(t)},ToUint32:function ce(t){return t>>>0}};var T=function pe(){};m(r,{bind:function he(t){var e=this;if(!c(e)){throw new TypeError("Function.prototype.bind called on incompatible "+e)}var r=a.call(arguments,1);var n;var i=function(){if(this instanceof n){var i=e.apply(this,r.concat(a.call(arguments)));if(Object(i)===i){return i}return this}else{return e.apply(t,r.concat(a.call(arguments)))}};var o=Math.max(0,e.length-r.length);var u=[];for(var l=0;l<o;l++){u.push("$"+l)}n=Function("binder","return function ("+u.join(",")+"){ return binder.apply(this, arguments); }")(i);if(e.prototype){T.prototype=e.prototype;n.prototype=new T;T.prototype=null}return n}});var j=s.bind(e.hasOwnProperty);var S=function(){var t=[1,2];var e=t.splice();return t.length===2&&h(e)&&e.length===0}();m(t,{splice:function ve(t,e){if(arguments.length===0){return[]}else{return o.apply(this,arguments)}}},S);var E=function(){var e={};t.splice.call(e,0,0,1);return e.length===1}();m(t,{splice:function ge(t,e){if(arguments.length===0){return[]}var r=arguments;this.length=Math.max(b(this.length),0);if(arguments.length>0&&typeof e!=="number"){r=a.call(arguments);if(r.length<2){r.push(this.length-t)}else{r[1]=b(e)}}return o.apply(this,r)}},!E);var N=[].unshift(0)!==1;m(t,{unshift:function(){l.apply(this,arguments);return this.length}},N);m(Array,{isArray:h});var I=Object("a");var D=I[0]!=="a"||!(0 in I);var M=function ye(t){var e=true;var r=true;if(t){t.call("foo",function(t,r,n){if(typeof n!=="object"){e=false}});t.call([1],function(){"use strict";r=typeof this==="string"},"x")}return!!t&&e&&r};m(t,{forEach:function de(t){var e=O.ToObject(this),r=D&&v(this)?this.split(""):e,n=arguments[1],i=-1,a=r.length>>>0;if(!c(t)){throw new TypeError}while(++i<a){if(i in r){t.call(n,r[i],i,e)}}}},!M(t.forEach));m(t,{map:function me(t){var e=O.ToObject(this),r=D&&v(this)?this.split(""):e,n=r.length>>>0,i=Array(n),a=arguments[1];if(!c(t)){throw new TypeError(t+" is not a function")}for(var o=0;o<n;o++){if(o in r){i[o]=t.call(a,r[o],o,e)}}return i}},!M(t.map));m(t,{filter:function be(t){var e=O.ToObject(this),r=D&&v(this)?this.split(""):e,n=r.length>>>0,i=[],a,o=arguments[1];if(!c(t)){throw new TypeError(t+" is not a function")}for(var u=0;u<n;u++){if(u in r){a=r[u];if(t.call(o,a,u,e)){i.push(a)}}}return i}},!M(t.filter));m(t,{every:function we(t){var e=O.ToObject(this),r=D&&v(this)?this.split(""):e,n=r.length>>>0,i=arguments[1];if(!c(t)){throw new TypeError(t+" is not a function")}for(var a=0;a<n;a++){if(a in r&&!t.call(i,r[a],a,e)){return false}}return true}},!M(t.every));m(t,{some:function xe(t){var e=O.ToObject(this),r=D&&v(this)?this.split(""):e,n=r.length>>>0,i=arguments[1];if(!c(t)){throw new TypeError(t+" is not a function")}for(var a=0;a<n;a++){if(a in r&&t.call(i,r[a],a,e)){return true}}return false}},!M(t.some));var F=false;if(t.reduce){F=typeof t.reduce.call("es5",function(t,e,r,n){return n})==="object"}m(t,{reduce:function Oe(t){var e=O.ToObject(this),r=D&&v(this)?this.split(""):e,n=r.length>>>0;if(!c(t)){throw new TypeError(t+" is not a function")}if(!n&&arguments.length===1){throw new TypeError("reduce of empty array with no initial value")}var i=0;var a;if(arguments.length>=2){a=arguments[1]}else{do{if(i in r){a=r[i++];break}if(++i>=n){throw new TypeError("reduce of empty array with no initial value")}}while(true)}for(;i<n;i++){if(i in r){a=t.call(void 0,a,r[i],i,e)}}return a}},!F);var R=false;if(t.reduceRight){R=typeof t.reduceRight.call("es5",function(t,e,r,n){return n})==="object"}m(t,{reduceRight:function Te(t){var e=O.ToObject(this),r=D&&v(this)?this.split(""):e,n=r.length>>>0;if(!c(t)){throw new TypeError(t+" is not a function")}if(!n&&arguments.length===1){throw new TypeError("reduceRight of empty array with no initial value")}var i,a=n-1;if(arguments.length>=2){i=arguments[1]}else{do{if(a in r){i=r[a--];break}if(--a<0){throw new TypeError("reduceRight of empty array with no initial value")}}while(true)}if(a<0){return i}do{if(a in r){i=t.call(void 0,i,r[a],a,e)}}while(a--);return i}},!R);var U=Array.prototype.indexOf&&[0,1].indexOf(1,2)!==-1;m(t,{indexOf:function je(t){var e=D&&v(this)?this.split(""):O.ToObject(this),r=e.length>>>0;if(!r){return-1}var n=0;if(arguments.length>1){n=b(arguments[1])}n=n>=0?n:Math.max(0,r+n);for(;n<r;n++){if(n in e&&e[n]===t){return n}}return-1}},U);var k=Array.prototype.lastIndexOf&&[0,1].lastIndexOf(0,-3)!==-1;m(t,{lastIndexOf:function Se(t){var e=D&&v(this)?this.split(""):O.ToObject(this),r=e.length>>>0;if(!r){return-1}var n=r-1;if(arguments.length>1){n=Math.min(n,b(arguments[1]))}n=n>=0?n:r-Math.abs(n);for(;n>=0;n--){if(n in e&&t===e[n]){return n}}return-1}},k);var C=!{toString:null}.propertyIsEnumerable("toString"),A=function(){}.propertyIsEnumerable("prototype"),P=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],Z=P.length;m(Object,{keys:function Ee(t){var e=c(t),r=g(t),n=t!==null&&typeof t==="object",i=n&&v(t);if(!n&&!e&&!r){throw new TypeError("Object.keys called on a non-object")}var a=[];var o=A&&e;if(i||r){for(var u=0;u<t.length;++u){a.push(String(u))}}else{for(var l in t){if(!(o&&l==="prototype")&&j(t,l)){a.push(String(l))}}}if(C){var s=t.constructor,f=s&&s.prototype===t;for(var p=0;p<Z;p++){var h=P[p];if(!(f&&h==="constructor")&&j(t,h)){a.push(h)}}}return a}});var J=Object.keys&&function(){return Object.keys(arguments).length===2}(1,2);var z=Object.keys;m(Object,{keys:function Ne(e){if(g(e)){return z(t.slice.call(e))}else{return z(e)}}},!J);var $=-621987552e5;var B="-000001";var H=Date.prototype.toISOString&&new Date($).toISOString().indexOf(B)===-1;m(Date.prototype,{toISOString:function Ie(){var t,e,r,n,i;if(!isFinite(this)){throw new RangeError("Date.prototype.toISOString called on non-finite value.")}n=this.getUTCFullYear();i=this.getUTCMonth();n+=Math.floor(i/12);i=(i%12+12)%12;t=[i+1,this.getUTCDate(),this.getUTCHours(),this.getUTCMinutes(),this.getUTCSeconds()];n=(n<0?"-":n>9999?"+":"")+("00000"+Math.abs(n)).slice(0<=n&&n<=9999?-4:-6);e=t.length;while(e--){r=t[e];if(r<10){t[e]="0"+r}}return n+"-"+t.slice(0,2).join("-")+"T"+t.slice(2).join(":")+"."+("000"+this.getUTCMilliseconds()).slice(-3)+"Z"}},H);var L=false;try{L=Date.prototype.toJSON&&new Date(NaN).toJSON()===null&&new Date($).toJSON().indexOf(B)!==-1&&Date.prototype.toJSON.call({toISOString:function(){return true}})}catch(X){}if(!L){Date.prototype.toJSON=function De(t){var e=Object(this),r=x(e),n;if(typeof r==="number"&&!isFinite(r)){return null}n=e.toISOString;if(typeof n!=="function"){throw new TypeError("toISOString property is not callable")}return n.call(e)}}var Y=Date.parse("+033658-09-27T01:46:40.000Z")===1e15;var q=!isNaN(Date.parse("2012-04-04T24:00:00.500Z"))||!isNaN(Date.parse("2012-11-31T23:59:59.000Z"));var G=isNaN(Date.parse("2000-01-01T00:00:00.000Z"));if(!Date.parse||G||q||!Y){Date=function(t){function e(r,n,i,a,o,u,l){var s=arguments.length;if(this instanceof t){var f=s===1&&String(r)===r?new t(e.parse(r)):s>=7?new t(r,n,i,a,o,u,l):s>=6?new t(r,n,i,a,o,u):s>=5?new t(r,n,i,a,o):s>=4?new t(r,n,i,a):s>=3?new t(r,n,i):s>=2?new t(r,n):s>=1?new t(r):new t;f.constructor=e;return f}return t.apply(this,arguments)}var r=new RegExp("^"+"(\\d{4}|[+-]\\d{6})"+"(?:-(\\d{2})"+"(?:-(\\d{2})"+"(?:"+"T(\\d{2})"+":(\\d{2})"+"(?:"+":(\\d{2})"+"(?:(\\.\\d{1,}))?"+")?"+"("+"Z|"+"(?:"+"([-+])"+"(\\d{2})"+":(\\d{2})"+")"+")?)?)?)?"+"$");var n=[0,31,59,90,120,151,181,212,243,273,304,334,365];function i(t,e){var r=e>1?1:0;return n[e]+Math.floor((t-1969+r)/4)-Math.floor((t-1901+r)/100)+Math.floor((t-1601+r)/400)+365*(t-1970)}function a(e){return Number(new t(1970,0,1,0,0,0,e))}for(var o in t){e[o]=t[o]}e.now=t.now;e.UTC=t.UTC;e.prototype=t.prototype;e.prototype.constructor=e;e.parse=function u(e){var n=r.exec(e);if(n){var o=Number(n[1]),u=Number(n[2]||1)-1,l=Number(n[3]||1)-1,s=Number(n[4]||0),f=Number(n[5]||0),c=Number(n[6]||0),p=Math.floor(Number(n[7]||0)*1e3),h=Boolean(n[4]&&!n[8]),v=n[9]==="-"?1:-1,g=Number(n[10]||0),y=Number(n[11]||0),d;if(s<(f>0||c>0||p>0?24:25)&&f<60&&c<60&&p<1e3&&u>-1&&u<12&&g<24&&y<60&&l>-1&&l<i(o,u+1)-i(o,u)){d=((i(o,u)+l)*24+s+g*v)*60;d=((d+f+y*v)*60+c)*1e3+p;if(h){d=a(d)}if(-864e13<=d&&d<=864e13){return d}}return NaN}return t.parse.apply(this,arguments)};return e}(Date)}if(!Date.now){Date.now=function Me(){return(new Date).getTime()}}var K=i.toFixed&&(8e-5.toFixed(3)!=="0.000"||.9.toFixed(0)!=="1"||1.255.toFixed(2)!=="1.25"||0xde0b6b3a7640080.toFixed(0)!=="1000000000000000128");var Q={base:1e7,size:6,data:[0,0,0,0,0,0],multiply:function Fe(t,e){var r=-1;while(++r<Q.size){e+=t*Q.data[r];Q.data[r]=e%Q.base;e=Math.floor(e/Q.base)}},divide:function Re(t){var e=Q.size,r=0;while(--e>=0){r+=Q.data[e];Q.data[e]=Math.floor(r/t);r=r%t*Q.base}},numToString:function Ue(){var t=Q.size;var e="";while(--t>=0){if(e!==""||t===0||Q.data[t]!==0){var r=String(Q.data[t]);if(e===""){e=r}else{e+="0000000".slice(0,7-r.length)+r}}}return e},pow:function ke(t,e,r){return e===0?r:e%2===1?ke(t,e-1,r*t):ke(t*t,e/2,r)},log:function Ce(t){var e=0;while(t>=4096){e+=12;t/=4096}while(t>=2){e+=1;t/=2}return e}};m(i,{toFixed:function Ae(t){var e,r,n,i,a,o,u,l;e=Number(t);e=e!==e?0:Math.floor(e);if(e<0||e>20){throw new RangeError("Number.toFixed called with invalid number of decimals")}r=Number(this);if(r!==r){return"NaN"}if(r<=-1e21||r>=1e21){return String(r)}n="";if(r<0){n="-";r=-r}i="0";if(r>1e-21){a=Q.log(r*Q.pow(2,69,1))-69;o=a<0?r*Q.pow(2,-a,1):r/Q.pow(2,a,1);o*=4503599627370496;a=52-a;if(a>0){Q.multiply(0,o);u=e;while(u>=7){Q.multiply(1e7,0);u-=7}Q.multiply(Q.pow(10,u,1),0);u=a-1;while(u>=23){Q.divide(1<<23);u-=23}Q.divide(1<<u);Q.multiply(1,1);Q.divide(2);i=Q.numToString()}else{Q.multiply(0,o);Q.multiply(1<<-a,0);i=Q.numToString()+"0.00000000000000000000".slice(2,2+e)}}if(e>0){l=i.length;if(l<=e){i=n+"0.0000000000000000000".slice(0,e-l+2)+i}else{i=n+i.slice(0,l-e)+"."+i.slice(l-e)}}else{i=n+i}return i}},K);var V=n.split;if("ab".split(/(?:ab)*/).length!==2||".".split(/(.?)(.?)/).length!==4||"tesst".split(/(s)*/)[1]==="t"||"test".split(/(?:)/,-1).length!==4||"".split(/.?/).length||".".split(/()()/).length>1){(function(){var t=typeof/()??/.exec("")[1]==="undefined";n.split=function(e,r){var n=this;if(typeof e==="undefined"&&r===0){return[]}if(f.call(e)!=="[object RegExp]"){return V.call(this,e,r)}var i=[],a=(e.ignoreCase?"i":"")+(e.multiline?"m":"")+(e.extended?"x":"")+(e.sticky?"y":""),o=0,l,s,c,p;e=new RegExp(e.source,a+"g");n+="";if(!t){l=new RegExp("^"+e.source+"$(?!\\s)",a)}r=typeof r==="undefined"?-1>>>0:O.ToUint32(r);while(s=e.exec(n)){c=s.index+s[0].length;if(c>o){i.push(n.slice(o,s.index));if(!t&&s.length>1){s[0].replace(l,function(){for(var t=1;t<arguments.length-2;t++){if(typeof arguments[t]==="undefined"){s[t]=void 0}}})}if(s.length>1&&s.index<n.length){u.apply(i,s.slice(1))}p=s[0].length;o=c;if(i.length>=r){break}}if(e.lastIndex===s.index){e.lastIndex++}}if(o===n.length){if(p||!e.test("")){i.push("")}}else{i.push(n.slice(o))}return i.length>r?i.slice(0,r):i}})()}else if("0".split(void 0,0).length){n.split=function Pe(t,e){if(typeof t==="undefined"&&e===0){return[]}return V.call(this,t,e)}}var W=n.replace;var _=function(){var t=[];"x".replace(/x(.)?/g,function(e,r){t.push(r)});return t.length===1&&typeof t[0]==="undefined"}();if(!_){n.replace=function Ze(t,e){var r=c(e);var n=p(t)&&/\)[*?]/.test(t.source);if(!r||!n){return W.call(this,t,e)}else{var i=function(r){var n=arguments.length;var i=t.lastIndex;t.lastIndex=0;var a=t.exec(r)||[];t.lastIndex=i;a.push(arguments[n-2],arguments[n-1]);return e.apply(this,a)};return W.call(this,t,i)}}}var te=n.substr;var ee="".substr&&"0b".substr(-1)!=="b";m(n,{substr:function Je(t,e){return te.call(this,t<0?(t=this.length+t)<0?0:t:t,e)}},ee);var re="	\n\f\r \xa0\u1680\u180e\u2000\u2001\u2002\u2003"+"\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028"+"\u2029\ufeff";var ne="\u200b";var ie="["+re+"]";var ae=new RegExp("^"+ie+ie+"*");var oe=new RegExp(ie+ie+"*$");var ue=n.trim&&(re.trim()||!ne.trim());m(n,{trim:function ze(){if(typeof this==="undefined"||this===null){throw new TypeError("can't convert "+this+" to object")}return String(this).replace(ae,"").replace(oe,"")}},ue);if(parseInt(re+"08")!==8||parseInt(re+"0x16")!==22){parseInt=function(t){var e=/^0[xX]/;return function r(n,i){n=String(n).trim();if(!Number(i)){i=e.test(n)?16:10}return t(n,i)}}(parseInt)}});
//# sourceMappingURL=es5-shim.map
