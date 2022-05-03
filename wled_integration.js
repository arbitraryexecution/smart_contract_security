var XMLHttpRequest = require('xhr2');

async function changeToRed() {
  var url = "http://wled-hallway.local/json/state";

  var xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onerror = function (err) {
    console.error(err)
  };
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[255,0,0],[0,0,0],[0,0,0]], "fx":30, "sx":236, "ix": 125, "pal":31}]}';

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
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[255,255,0],[0,0,0],[0,0,0]], "fx":30, "sx":236, "ix": 125, "pal":31}]}';

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
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[0,255,0],[0,0,0],[0,0,0]], "fx":30, "sx":236, "ix": 125, "pal":31}]}';

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
  var data = '{"on": true, "v":true, "seg": [{"id":0, "on":true, "col":[[0,0,255],[0,0,0],[0,0,0]], "fx":30, "sx":236, "ix": 125, "pal":31}]}';

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
module.exports = {get, changeToRed, changeToYellow, changeToGreen, changeToBlue, restoreState, delay};