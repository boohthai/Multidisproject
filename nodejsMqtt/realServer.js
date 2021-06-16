var mqtt = require('mqtt');
var MQTT_TOPIC_ROOM1_LIGHT  = "CSE_BBC1/feeds/bk-iot-light";
var MQTT_TOPIC_ROOM1_NOISE = "CSE_BBC1/feeds/bk-iot-sound"
var MQTT_TOPIC_ROOM1_LED = "CSE_BBC/feeds/bk-iot-led"
var MQTT_TOPIC_ROOM1_BUZZER = "CSE_BBC/feeds/bk-iot-speaker"
var MQTT_ADDR           = "mqtt://io.adafruit.com";
var MQTT_PORT           = 1883;

var client2  = mqtt.connect(MQTT_ADDR,{ username: 'CSE_BBC1',password:'aio_lubo29QRBLOP6OoDkQ5RDsmUSukr', protocolVersion: 3, connectTimeout:1000, debug:true});
client2.on('connect', function () {
    console.log("Connected server2")
    client2.subscribe(MQTT_TOPIC_ROOM1_LIGHT)
    client2.subscribe(MQTT_TOPIC_ROOM1_NOISE);
});

client2.on('message',async function (topic, message) {  
    if (topic ==MQTT_TOPIC_ROOM1_NOISE ){
        console.log('value from ' + topic + ': ' + message.toString());
        JSONdata = JSON.parse(message.toString());
        noiseThreshold =await GetNoiseThreshold()
        console.log(noiseThreshold)
        console.log(JSONdata.data)
        await AddNoiseRecord(JSONdata.data);
        await ChangeCurrentNoiseValue(JSONdata.data);
        if (parseInt(JSONdata.data) > parseInt(noiseThreshold)){
          // client1.publish(MQTT_TOPIC_ROOM1_LED, 
          //   `{"id" : "1", "name" : "LED", "data": "1", "unit" : ""}`);
          await ChangeCurrentBuzzerValue(100);
          
        }
        else{
          // client1.publish(MQTT_TOPIC_ROOM1_LED, 
          //   `{"id" : "1", "name" : "LED", "data": "0", "unit" : ""}`);
          await ChangeCurrentBuzzerValue(0);
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

client2.on('error', function(){
    console.log("ERROR server2")
    client2.end()
})

//client1

var client1  = mqtt.connect(MQTT_ADDR,{ username: 'CSE_BBC',password:'aio_EgXK400rXGsfdspfNyuk4Y2JZZMR', protocolVersion: 3, connectTimeout:1000, debug:true});
client1.on('connect', function () {
    console.log("Connected server1")
    client1.subscribe(MQTT_TOPIC_ROOM1_LED)
    client1.subscribe(MQTT_TOPIC_ROOM1_BUZZER);
});
client1.on('error', function(){
  console.log("ERROR server1")
  client2.end()
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
    date: new Date().toLocaleString('en-GB',{hour12:false})
  };
  const res = await db.collection('room1_noise_record').add(_data);
}

async function ChangeCurrentNoiseValue(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString('en-GB',{hour12:false})
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
      date: new Date().toLocaleString('en-GB',{hour12:false})
    };
    const res = await db.collection('room1_light_record').add(_data);
}
  
async function ChangeCurrentLightValue(value){
    const _data = {
      data: value,
      date: new Date().toLocaleString('en-GB',{hour12:false})
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

async function ChangeCurrentBuzzerValue(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString('en-GB',{hour12:false})
  };
  const res = await db.collection('room1_output').doc('sound_buzzer').set(_data);
}

async function ChangeLightRelayValue(value){
  const _data = {
    data: value,
    date: new Date().toLocaleString('en-GB',{hour12:false})
  };
  const res = await db.collection('room1_output').doc('light_relay_control').set(_data);
}

const RelayLightDoc = db.collection('room1_output').doc('light_relay_control');
const listenchange = RelayLightDoc.onSnapshot(docSnapshot => {
  console.log(`Received doc snapshot light: ${docSnapshot.data().data}`);
  const _data = docSnapshot.data().data
  client1.publish(MQTT_TOPIC_ROOM1_LED, 
    `{"id" : "1", "name" : "LED", "data": "${_data}", "unit" : ""}`);
  }, err => {
  console.log(`Encountered error: ${err}`);
});

const BuzzerNoiseDoc = db.collection('room1_output').doc('sound_buzzer');
const listenchange2 = BuzzerNoiseDoc.onSnapshot(docSnapshot => {
  console.log(`Received doc snapshot sound: ${docSnapshot.data().data}`);
  const _data = docSnapshot.data().data
  client1.publish(MQTT_TOPIC_ROOM1_BUZZER, 
    `{"id" : "2", "name" : "SPEAKER", "data": "${_data}", "unit" : ""}`);
  }, err => {
  console.log(`Encountered error: ${err}`);
});