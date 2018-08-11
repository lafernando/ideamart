import ballerina/test;
import ballerina/config;
import laf/ideamart;
import ballerina/io;

endpoint ideamart:Client ideaMartEP {
    applicationId : "APP_000001",
    password : "password",            // use config API when using real values
    baseURL : PROD_BASE_URL           // change this if you're using the simulator, e.g. "http://localhost:7000"
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
