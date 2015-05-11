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
var tonamePlayVideo= function(parameters){
    var jp=parameters;
    if(jp==null)
    {
        window.alert("Cannot play the video. Not specify what to play");
        return;
    }
    //window.alert(jp.gui[0]);
   var video = document.getElementById(jp.gui[0]);
   if(video==null)
       window.alert("wrong");
   else
   {
      var result=video.play();
       video.onended = tonameAlert;
   }
    
    var audio = document.getElementById("uid000003");
    audio.play();
    
    tonamePlaying();
    
}

var tonameCreate(parameters){
    tonameCallNativeFunc(parameters);
}

var tonameAlert = function(parameters)
{
    alert("The audio has ended");
}


var tonamePlaying = function(parameters)
{
    alert("The audio is playing");
}

var tonameLoadDefaultApp= function(parameters)
{

}