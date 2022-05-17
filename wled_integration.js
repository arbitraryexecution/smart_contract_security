var XMLHttpRequest = require('xhr2');

async function changeToRed() {
  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onerror = function (err) {
    console.error(err)
  };
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[255,0,0],[0,0,0],[0,0,0]], "fx":50, "sx":216, "ix": 125, "pal":31}]}';

  // Send the request
  await xhr.send(data);
}

async function changeToYellow() {
  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onerror = function (err) {
    console.error(err)
  };
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[255,255,0],[0,0,0],[0,0,0]], "fx":50, "sx":216, "ix": 125, "pal":31}]}';

  await xhr.send(data);
}

async function changeToGreen() {
  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onerror = function (err) {
    console.error(err)
  };
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[0,255,0],[0,0,0],[0,0,0]], "fx":50, "sx":216, "ix": 125, "pal":31}]}';

  await xhr.send(data);
}

async function changeToBlue() {
  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onerror = function (err) {
    console.error(err)
  };
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[0,0,255],[0,0,0],[0,0,0]], "fx":50, "sx":216, "ix": 125, "pal":31}]}';

  await xhr.send(data);
}

async function changeToOrange() {
  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onerror = function (err) {
    console.error(err)
  };
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[255,165,0],[0,0,0],[0,0,0]], "fx":50, "sx":216, "ix": 125, "pal":31}]}';

  await xhr.send(data);
}

async function changeToIndigo() {
  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onerror = function (err) {
    console.error(err)
  };
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[75,0,130],[0,0,0],[0,0,0]], "fx":50, "sx":216, "ix": 125, "pal":31}]}';

  await xhr.send(data);
}

async function changeToViolet() {
  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onerror = function (err) {
    console.error(err)
  };
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[143,0,255],[0,0,0],[0,0,0]], "fx":50, "sx":216, "ix": 125, "pal":31}]}';

  await xhr.send(data);
}

async function restoreState(oldState) {

  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");
    
  xhr.onerror = function (err) {
    console.error(err)
  };

  // Send the request
  await xhr.send(oldState);
}

async function get() {

  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("GET", url);
  xhr.setRequestHeader("Content-Type", "application/json");

  const myPromise = new Promise( (resolutionFunc,rejectionFunc) => {
    xhr.onreadystatechange = async function() {
      if (xhr.readyState == XMLHttpRequest.DONE) {
          resolutionFunc(xhr.responseText);
      }
    }
  });

  await xhr.send();

  return myPromise;
}
const delay = ms => new Promise(res => setTimeout(res, ms));
module.exports = {get, changeToRed, changeToYellow, changeToGreen, changeToBlue, changeToOrange, changeToIndigo, changeToViolet, restoreState, delay};

(async () => {
  try {
    /*
    var current_state = await get();
    await changeToRed();
    await delay(10000);
    await restoreState(current_state);
    */
  } catch (e) {
      // Deal with the fact the chain failed
  }
  // `text` is not available here
})();
