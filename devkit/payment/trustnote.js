// Version v0.0.1
// by TrustNote
!(function() {
  var trustnote = {
    inited: false,
    event: {},

    init: function() {
      if (trustnote.inited) return;
      trustnote.inited = true;
      window.addEventListener("message", function(e) {
        // 拒绝来自本域内的事件
        if (e.origin == window.location.protocol + "//" + window.location.host)
          return;
        var eventName = e.data.eventName;
        switch (eventName) {
          case "address":
            trustnote.event.getAddressCallback(e.data);
            break;
          case "payment":
            trustnote.event.callPayCallback(e.data);
            break;
        }
      });
    },

    getAddress: function(callback) {
      if (typeof callback !== "function") {
        trustnote.log("callback must be function");
        return;
      }
      trustnote.init();
      trustnote.event.getAddressCallback = callback;
      parent.postMessage({ eventName: "address", message: null }, "*");
    },

    callPay: function(msg, callback) {
      try {
        if (!msg) throw "(msg,callback),parameters cannot be empty";
        if (typeof callback !== "function") throw "callback must be function";
        if (!msg.payer) throw "Payer cannot be empty";
        if (!msg.outputs) throw "Outputs cannot be empty";
      } catch (error) {
        trustnote.log(error);
        return;
      }
      trustnote.init();
      trustnote.event.callPayCallback = callback;
      var data = { eventName: "payment", message: msg };
      parent.postMessage(data, "*");
    },

    log: function(msg) {
      var text = "[ trustnote ] " + msg;
      console.error(text);
    }
  };

  window.trustnote = trustnote;
})();
