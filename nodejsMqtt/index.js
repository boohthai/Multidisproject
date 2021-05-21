var mqtt = require('mqtt');
var MQTT_TOPIC_ROOM1_NOISE  = "leminhduc2504/feeds/multi-discip.noise-feed";
var MQTT_TOPIC_ROOM1_LIGHT = "leminhduc2504/feeds/multi-discip.light-feed";
var MQTT_TOPIC_ROOM1_LED1 = "leminhduc2504/feeds/multi-discip.room1-led";
var MQTT_TOPIC_ROOM1_LIGHT_RELAY_CONTROL = "leminhduc2504/feeds/multi-discip.light-relay-control";
var MQTT_ADDR           = "mqtt://io.adafruit.com";
var MQTT_PORT           = 1883;

var client  = mqtt.connect(MQTT_ADDR,{ username: 'leminhduc2504',password:'aio_wkFI74QXvDAYAGVLJ5NlCur3RKh6', protocolVersion: 3, connectTimeout:1000, debug:true});
client.on('connect', function () {
    client.subscribe(MQTT_TOPIC_ROOM1_NOISE);
    client.subscribe(MQTT_TOPIC_ROOM1_LED1);
    client.subscribe(MQTT_TOPIC_ROOM1_LIGHT)
    client.subscribe(MQTT_TOPIC_ROOM1_LIGHT_RELAY_CONTROL);
});

client.on('message',async function (topic, message) {  

    if (topic ==MQTT_TOPIC_ROOM1_NOISE ){
      console.log('value from ' + topic + ': ' + message.toString());
      JSONdata = JSON.parse(message.toString());
      noiseThreshold =await GetNoiseThreshold()
      console.log(noiseThreshold)
      console.log(JSONdata.data)
      await AddNoiseRecord(JSONdata.data);
      await ChangeCurrentNoiseValue(JSONdata.data);
      if (parseInt(JSONdata.data) > parseInt(noiseThreshold)){
        client.publish(MQTT_TOPIC_ROOM1_LED1, 
          `{
            "id":"1",
            "name":"LED1",
            "data":"1",
            "unit":""
        }`);
        await ChangeCurrentLed1Value(1);
        
      }
      else{
        client.publish(MQTT_TOPIC_ROOM1_LED1, 
          `{
            "id":"1",
            "name":"LED1",
            "data":"0",
            "unit":""
        }`);
        await ChangeCurrentLed1Value(0);
      }
    }


    if (topic ==MQTT_TOPIC_ROOM1_LIGHT ){
      console.log('value from ' + topic + ': ' + message.toString());
      JSONdata = JSON.parse(message.toString());
      lightThresholdMax = await GetLightThresholdMax()
      lightThresholdMin = await GetLightThresholdMin()
      await AddLightRecord(JSONdata.data);
      await ChangeCurrentLightValue(JSONdata.data);
      if (parseInt(JSONdata.data) > parseInt(lightThresholdMax)){
        await ChangeLightRelayValue(0);
        
      }
      if (parseInt(JSONdata.data) < parseInt(lightThresholdMin)){
        await ChangeLightRelayValue(1);
      }
    }
});

client.on('error', function(){
    console.log("ERROR 13123123")
    client.end()
})



//firebase connection
var admin = require("firebase-admin");
var serviceAccount = require("./serviceAccount.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

async function AddNoiseRecord(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString()
  };
  const res = await db.collection('room1_noise_record').add(_data);
}

async function ChangeCurrentNoiseValue(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString()
  };
  const res = await db.collection('room1_input').doc('noise_value').set(_data);
}

async function GetNoiseThreshold(){
  const cityRef = db.collection('room1_input').doc('noise_threshold');
  const doc = await cityRef.get();
  return doc.data().data
}

async function AddLightRecord(value){
    const _data = {
      data: value,
      date: new Date().toLocaleString()
    };
    const res = await db.collection('room1_light_record').add(_data);
}
  
async function ChangeCurrentLightValue(value){
    const _data = {
      data: value,
      date: new Date().toLocaleString()
    };
    const res = await db.collection('room1_input').doc('light_value').set(_data);
}

async function GetLightThresholdMax(){
  const cityRef = db.collection('room1_input').doc('light_threshold_max');
  const doc = await cityRef.get();
  return doc.data().data
}

async function GetLightThresholdMin(){
  const cityRef = db.collection('room1_input').doc('light_threshold_min');
  const doc = await cityRef.get();
  return doc.data().data
}

async function ChangeCurrentLed1Value(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString()
  };
  const res = await db.collection('room1_output').doc('led1').set(_data);
}

async function ChangeLightRelayValue(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString()
  };
  const res = await db.collection('room1_output').doc('light_relay_control').set(_data);
}

const RelayLightDoc = db.collection('room1_output').doc('light_relay_control');
const listenchange = RelayLightDoc.onSnapshot(docSnapshot => {
  console.log(`Received doc snapshot: ${docSnapshot.data().data}`);
  const _data = docSnapshot.data().data
  client.publish(MQTT_TOPIC_ROOM1_LIGHT_RELAY_CONTROL, 
    `{
      "id":"11",
      "name":"RELAY",
      "data":"${_data}",
      "unit":""
  }`);
}, err => {
  console.log(`Encountered error: ${err}`);
});