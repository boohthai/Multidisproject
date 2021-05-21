var mqtt = require('mqtt');
var MQTT_TOPIC_ROOM1_NOISE  = "leminhduc2504/feeds/multi-discip.noise-feed";
var MQTT_TOPIC_ROOM1_LIGHT = "leminhduc2504/feeds/multi-discip.light-feed";
var MQTT_TOPIC_ROOM1_LED1 = "leminhduc2504/feeds/multi-discip.room1-led";
var MQTT_TOPIC_ROOM1_LED2 = "leminhduc2504/feeds/multi-discip.room1-led2";
var MQTT_ADDR           = "mqtt://io.adafruit.com";
var MQTT_PORT           = 1883;

var client  = mqtt.connect(MQTT_ADDR,{ username: 'leminhduc2504',password:'aio_NtvT63CKgWeABqMgwpTcmCjAKMOu', protocolVersion: 3, connectTimeout:1000, debug:true});
// var client  = mqtt.connect(MQTT_ADDR,{username: 'giale1234',password:'aio_eMVB73YzLt9dfdlWsT8jfb0afNuI', protocolVersion: 3, connectTimeout:1000, debug:true});
client.on('connect', function () {
    client.subscribe(MQTT_TOPIC_ROOM1_NOISE);
    client.subscribe(MQTT_TOPIC_ROOM1_LED1);
    client.subscribe(MQTT_TOPIC_ROOM1_LIGHT)
    client.subscribe(MQTT_TOPIC_ROOM1_LED2);
    // client.publish(MQTT_TOPIC_ROOM1_NOISE, 
    //   `{
    //   "id":"12",
    //   "name":"SOUND",
    //   "data":"90",
    //   "unit":""
    //   }`);
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
      lightThreshold =await GetLightThreshold()
      console.log(lightThreshold)
      console.log(JSONdata.data)
      await AddLightRecord(JSONdata.data);
      await ChangeCurrentLightValue(JSONdata.data);
      if (parseInt(JSONdata.data) > parseInt(lightThreshold)){
        client.publish(MQTT_TOPIC_ROOM1_LED2, 
          `{
            "id":"1",
            "name":"LED2",
            "data":"1",
            "unit":""
        }`);
        await ChangeCurrentLed2Value(1);
        
      }
      else{
        client.publish(MQTT_TOPIC_ROOM1_LED2, 
          `{
            "id":"1",
            "name":"LED2",
            "data":"0",
            "unit":""
        }`);
        await ChangeCurrentLed2Value(0);
      }
    }
});

client.on('error', function(){
    console.log("ERROR")
    client.end()
})



//firebase connection
var admin = require("firebase-admin");
var serviceAccount = require("./serviceAccount2.json");

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
  const res = await db.collection('room1_noise_value').doc('value').set(_data);
}

async function GetNoiseThreshold(){
  const cityRef = db.collection('room1_noise_value').doc('threshold');
  const doc = await cityRef.get();
  return doc.data().data
}

async function GetLightThreshold(){
  const cityRef = db.collection('room1_light_value').doc('threshold');
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

async function ChangeCurrentLed1Value(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString()
  };
  const res = await db.collection('room1_output').doc('led1').set(_data);
}

async function ChangeCurrentLed2Value(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString()
  };
  const res = await db.collection('room1_output').doc('led2').set(_data);
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
  const res = await db.collection('room1_light_value').doc('value').set(_data);
}