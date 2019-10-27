Connects to IdeaMart APIs from Ballerina. 

## Sample

```ballerina
import ballerina/io;
import ballerina/test;
import laf/ideamart;

IdeaMartConfiguration ideaMartConfig = {
    applicationId : "APP_000001",
    password : "password",            // use config API when using real values
    baseURL : PROD_BASE_URL           // change this if you're using the simulator, e.g. "http://localhost:7000"
};

ideamart:Client ideaMartClient = new(ideaMartConfig);

@test:Config {}
function testSendSMS() {
    string[] addrs = ["tel:0771234567"];
    var res = ideaMartClient->subscriberRegister("tel:0771234567");
    io:println(res);
    res = ideaMartClient->sendSMS(addrs, "Hello XXX", "tel:94771122336");
    io:println(res);
    var res2 = ideaMartClient->receiveSMS("tel:0771234567", "XXX", "APP_000001");
    io:println(res2);
    var res3 = ideaMartClient->locate("tel:0771234567");
    io:println(res3);
    res = ideaMartClient->subscriberUnregister("tel:0771234567");
    io:println(res);
}
```
