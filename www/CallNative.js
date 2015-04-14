/* 
  CallNative.js
  toname

  Created by Elias Sun on 4/3/15.
  Copyright (c) 2015 ishare. All rights reserved.
*/
var tonameCallNativeFunc = function(parameters) {
    var iframe = document.createElement('iframe');
    iframe.setAttribute('src', 'tonamecallnative:' + JSON.stringify(parameters));
    
    document.documentElement.appendChild(iframe);
    iframe.parentNode.removeChild(iframe);
    iframe = null;
};
/*
sendObjectMessage({name: 'Bryan', company: 'Tumblr'});
*/