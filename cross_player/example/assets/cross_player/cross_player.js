

var _players = new Map();
const Plugin = videojs.getPlugin('plugin')
const EVENTS = [
    // HTMLMediaElement events
    'abort',
    'canplay',
    'canplaythrough',
    'durationchange',
    'emptied',
    'ended',
    'error',
    'loadeddata',
    'loadedmetadata',
    'loadstart',
    'pause',
    'play',
    'playing',
    'progress',
    'ratechange',
    'seeked',
    'seeking',
    'stalled',
    'suspend',
    'timeupdate',
    'volumechange',
    'waiting',

    // HTMLVideoElement events
    'enterpictureinpicture',
    'leavepictureinpicture',

    // Element events
    'fullscreenchange',
    'resize',

    // video.js events
    'audioonlymodechange',
    'audiopostermodechange',
    'controlsdisabled',
    'controlsenabled',
    'debugon',
    'debugoff',
    'disablepictureinpicturechanged',
    'dispose',
    'enterFullWindow',
    'error',
    'exitFullWindow',
    'firstplay',
    'fullscreenerror',
    'languagechange',
    'loadedmetadata',
    'loadstart',
    'playerreset',
    'playerresize',
    'posterchange',
    'ready',
    'textdata',
    'useractive',
    'userinactive',
    'usingcustomcontrols',
    'usingnativecontrols',
]

class _JsPlayer extends Plugin {
    constructor(player) {
        super(player);
        // var ele = document.getElementById(player.id_)

        var pl = player.nuevo();
        player.visualizer();
        this.on(player, EVENTS, this.logEvents)
    }
    logEvents(event) {
        // console.log(event.type)
        // console.log(this.player.duration())
        // console.log(this.player.currentTime())
        // console.log(this.player.bufferedEnd())
    }
}
var CrossPlayer = {
    printConsole: function (msg) {
        console.log(msg)
    },
    create: async  function (videoId, options) {
        console.log("create");
        try {
            if(this.isExist(videoId)){
                console.log("exist");
                await this.dispose(videoId);
            }
            _players.set(videoId, new _JsPlayer(videojs(videoId, options, function () {
                console.log("init");
            })));

            return true
        } catch (e) {
            console.log("Err:");
            console.log(e);
        }
        return false;
    },

    isExist: function (videoId) {
        var isExist = _players.has(videoId);
        console.log("exist:"+videoId+","+isExist);
        return isExist;
    },

    setSrc: async function(videoId, url, mimeType){
        console.log("setSrc");
        if(!this.isExist(videoId)){
            console.log("nao exist");

            return
        }
        _players.get(videoId).player.src({src: url, type: mimeType});
    },
    play: async function(videoId){
        console.log("play");
        if(!this.isExist(videoId)){
            console.log("nao exist");
            return
        }
        _players.get(videoId).player.play();
    },
    pause: async function(videoId){
        console.log("pause");
        if(!this.isExist(videoId)){
            console.log("nao exist");
            return
        }
        _players.get(videoId).player.pause();
    },
    isPlaying: async function(videoId){
        console.log("isPlaying");
        if(!this.isExist(videoId)){
            return
        }
        return !_players.get(videoId).player.paused();
    },
    isPaused: async function(videoId){
        console.log("isPaused");
        if(!this.isExist(videoId)){
            return
        }
        return _players.get(videoId).player.paused();
    },
    isSeekable: async function(videoId){
        console.log("isSeekable");
        if(!this.isExist(videoId)){
            return
        }
        return _players.get(videoId).player.seekable();
    },
    getTime: async function(videoId){
        console.log("getTime");
        if(!this.isExist(videoId)){
            return
        }
        var time =  _players.get(videoId).player.currentTime();
        console.log("Time:"+time);
        return time;
    },
    getVolume: async function(videoId){
        console.log("getTime");
        if(!this.isExist(videoId)){
            return
        }
        return _players.get(videoId).player.volume();
    },
    getDuration: async function(videoId){
        console.log("getTime");
        if(!this.isExist(videoId)){
            return
        }
        return _players.get(videoId).player.duration();
    },
    stop: async function(videoId){
        console.log("stop");
        if(!this.isExist(videoId)){
            return
        }
        return _players.get(videoId).player.stop();
    },
    dispose: async function(videoId){
        console.log("dispose js");
        if(!this.isExist(videoId)){
            return
        }
        // if(await this.isPlaying(videoId)) {
        //     _players.get(videoId).player.pause()
        // }
        if (videojs.getPlayer(videoId)) {
            videojs(videoId).dispose();
        }
        _players.delete(videoId);
    },
};