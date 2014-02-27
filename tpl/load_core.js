/*
 * AISpeech API provides AI Speech Ltd's (www.aispeech.com) world leading pronunciation evaluation, speech recognition
 * technologies, and text-to-speech technologies.
 *
 * AI Speech Ltd opens this API hoping make every programmer be capable to implement speech enabled applicaitons.
 *
 * Copyright (c) 2008-2013 by AISpeech. All rights reserved.
 *
 * $Id: load_core.js 4134 2013-06-14 01:56:25Z zhiyuan.liang $
 */
aispeech = {};
(function(){
    aispeech.jsLoadStart = new Date().getTime();
    
    aispeech.getCss = function(src){
        document.write('<' + 'link href="' + src + '"' + ' rel="stylesheet" type="text/css" />');
    }
    
    aispeech.getScript = function(src){
        document.write('<' + 'script src="' + src + '"' + ' type="text/javascript"><' + '/script>');
    }
    
    var generateGUID = (typeof(window.crypto) != 'undefined' && typeof(window.crypto.getRandomValues) != 'undefined') ? function(){
        // If we have a cryptographically secure PRNG, use that
        // http://stackoverflow.com/questions/6906916/collisions-when-generating-uuids-in-javascript
        var buf = new Uint16Array(8);
        window.crypto.getRandomValues(buf);
        var S4 = function(num){
            var ret = num.toString(16);
            while (ret.length < 4) {
                ret = "0" + ret;
            }
            return ret;
        };
        return (S4(buf[0]) + S4(buf[1]) + "-" + S4(buf[2]) + "-" + S4(buf[3]) + "-" + S4(buf[4]) + "-" + S4(buf[5]) + S4(buf[6]) + S4(buf[7]));
    } : function(){
        // Otherwise, just use Math.random
        // http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript/2117523#2117523
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c){
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    };
    
    var isDebug = false;
    //aispeech.monitorUrl = "http://log.aispeech.com/sdk-monitor/sdklog";
    aispeech.monitorUrl = "http://s.2u4u.com.cn/dk-monitor/sdklog";
    aispeech.apiVersion = "v2.0";
    //aispeech.host = "http://10.12.7.107/svn/aid201101/trunk/jssdk";
    aispeech.host = aispeech.host || "http://s.2u4u.com.cn/aispeechapi-js/" + aispeech.apiVersion;
    
    aispeech.getCss(aispeech.host + "/Resources/themes/default/aidebug.css");
    aispeech.getCss(aispeech.host + "/Resources/themes/default/ui.css");
    
    aispeech.logId = generateGUID();
    if (isDebug) {
        aispeech.getScript(aispeech.host + "/Resources/jquery/aijquery-1.6.2-min.js");
        
        aispeech.getScript(aispeech.host + "/Classes/Ai.js");
        aispeech.getScript(aispeech.host + "/Classes/AiDebug.js");
        aispeech.getScript(aispeech.host + "/Classes/AiFlashDetect.js");
        aispeech.getScript(aispeech.host + "/Classes/AiFlot.js");
        aispeech.getScript(aispeech.host + "/Classes/AiGChart.js");
        aispeech.getScript(aispeech.host + "/Classes/AiPanel.js");
        aispeech.getScript(aispeech.host + "/Classes/AiPanelParagraph.js");
        aispeech.getScript(aispeech.host + "/Classes/AiPlayer.js");
        aispeech.getScript(aispeech.host + "/Classes/AudioPlayer.js");
        aispeech.getScript(aispeech.host + "/Classes/AiRecorder.js");
        aispeech.getScript(aispeech.host + "/Classes/AiStatusCode.js");
        aispeech.getScript(aispeech.host + "/Classes/AiTone.js");
        aispeech.getScript(aispeech.host + "/Classes/CnSentRec.js");
        aispeech.getScript(aispeech.host + "/Classes/CnSentScore.js");
        aispeech.getScript(aispeech.host + "/Classes/CnWordScore.js");
        aispeech.getScript(aispeech.host + "/Classes/EnScoreMap.js");
        aispeech.getScript(aispeech.host + "/Classes/EnSentRec.js");
        aispeech.getScript(aispeech.host + "/Classes/EnSentScore.js");
        aispeech.getScript(aispeech.host + "/Classes/EnWordScore.js");
        aispeech.getScript(aispeech.host + "/Classes/LocationSearch.js");
        aispeech.getScript(aispeech.host + "/Classes/SpeechResource.js");
        aispeech.getScript(aispeech.host + "/Classes/UpdateSDKMonitor.js");
        
    } else {
        aispeech.getScript(aispeech.host + "/Resources/jquery/aijquery-1.6.2-min.js");
        aispeech.getScript(aispeech.host + "/Resources/aispeech-min.js?20130614");
    }
})();
