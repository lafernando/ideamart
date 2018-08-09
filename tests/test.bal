import ballerina/log;
import ballerina/test;
import ballerina/config;
import laf/ideamart;
import ballerina/io;

endpoint ideamart:Client ideaMartEP {
    applicationId : "",
    password : ""
};

@test:Config
function testSendSMS() {
  string[] addrs = ["tel:772325283"];
  var res = ideaMartEP->sendSMS(addrs, "Hello", "tel:532532532");
  io:println(res);
}
