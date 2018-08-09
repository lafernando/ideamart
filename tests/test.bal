import ballerina/log;
import ballerina/test;
import ballerina/config;
import laf/ideamart;
import ballerina/io;

endpoint ideamart:Client ideaMartEP {
    applicationId : "APP_000001",
    password : "password",
    baseURL : "http://localhost:7000" // production URL, use: PROD_BASE_URL
};

@test:Config
function testSendSMS() {
  string[] addrs = ["tel:0771234567"];
  var res = ideaMartEP->subscriberRegister("tel:0771234567");
  io:println(res);
  res = ideaMartEP->sendSMS(addrs, "Hello XXX", "tel:94771122336");
  io:println(res);
  var res2 = ideaMartEP->receiveSMS("tel:0771234567", "XXX", "APP_000001");
  io:println(res2);
  var res3 = ideaMartEP->locate("tel:0771234567");
  io:println(res3);
  res = ideaMartEP->subscriberUnregister("tel:0771234567");
  io:println(res);
}
