import ballerina/http;

public type IdeaMartConnector object {

    public http:Client client;

    public IdeaMartConfiguration config;

    new(config) { }

    public function sendSMS(string[] destinationAddrs, string message, string sourceAddr) returns string|error;

}

function IdeaMartConnector::sendSMS(string[] destinationAddrs, string message, string sourceAddr) returns string|error {
    endpoint http:Client httpClient = self.client;
    http:Request request = new;
    json msg = { "message" : message, "destinationAddresses" : destinationAddrs, "applicationId" : config.applicationId,
                 "password" : config.password };
    request.setJsonPayload(untaint msg);
    var response = httpClient->post("https://api.dialog.lk/sms/send", request);
    match response {
        http:Response httpResponse => {
            json payload = httpResponse.getJsonPaload();
            return payload.statusCode;
        }
        error err => {
            return err;
        }
    }
}
