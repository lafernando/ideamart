import ballerina/log;
import ballerina/test;
import ballerina/config;

endpoint Client ideaMartEP {
    applicationId : "",
    password : ""
}

@test:Config
function testSendSMS() {
  io:println(ideaMartEP);
}
