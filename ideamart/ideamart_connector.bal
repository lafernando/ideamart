import ballerina/http;
import ballerina/io;

public type IdeaMartConnector object {

    public http:Client client;

    public IdeaMartConfiguration config;

    public function init(IdeaMartConfiguration pconfig) { 
        self.config = pconfig;
        http:ClientEndpointConfig hc = { url: BASE_URL };
        self.client.init(hc);
    }

    public function sendSMS(string[] destinationAddrs, string message, string sourceAddr) returns string|error;

};

function IdeaMartConnector::sendSMS(string[] destinationAddrs, string message, string sourceAddr) returns string|error {
    endpoint http:Client httpClient = self.client;
    http:Request request = new;
    json msg = { "message" : message, "destinationAddresses" : check <json> destinationAddrs, 
                 "applicationId" : self.config.applicationId,
                 "password" : self.config.password };
    request.setJsonPayload(untaint msg);
    io:println(msg);
    var response = httpClient->post("/sms/send", request);
    io:println(response);
    match response {
        http:Response httpResponse => {
            json payload = check httpResponse.getJsonPayload();
            return check <string> payload.statusCode;
        }
        error err => {
            return err;
        }
    }
}
