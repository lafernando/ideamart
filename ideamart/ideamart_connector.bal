import ballerina/http;

public type IdeaMartConnector object {

    public http:Client client;

    public IdeaMartConfiguration config;

    public function init(IdeaMartConfiguration pconfig) { 
        self.config = pconfig;
        http:ClientEndpointConfig hc = { url: pconfig.baseURL };
        self.client.init(hc);
    }

    public function sendSMS(string[] destinationAddrs, string message, string sourceAddr) returns string|error;

    public function receiveSMS(string sourceAddr, string message, string requestId) returns json|error;

    public function subscriberRegister(string subscriberId) returns string|error;

    public function subscriberUnregister(string subscriberId) returns string|error;

    public function locate(string subscriberId) returns LocateResult|error;

};

function IdeaMartConnector::sendSMS(string[] destinationAddrs, string message, string sourceAddr) returns string|error {
    endpoint http:Client httpClient = self.client;
    http:Request request = new;
    json msg = { "message" : message, "destinationAddresses" : check <json> destinationAddrs, 
                 "applicationId" : self.config.applicationId,
                 "password" : self.config.password };
    request.setJsonPayload(untaint msg);
    var response = httpClient->post("/sms/send", request);
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

function IdeaMartConnector::receiveSMS(string sourceAddr, string message, string requestId) returns json|error {
    endpoint http:Client httpClient = self.client;
    http:Request request = new;
    json msg = { "message" : message, "sourceAddress" : sourceAddr,
                 "requestId" : requestId, "encoding" : "0", "version" : "1.0",
                 "applicationId" : self.config.applicationId,
                 "password" : self.config.password };
    request.setJsonPayload(untaint msg);
    var response = httpClient->post("/sms/send", request);
    match response {
        http:Response httpResponse => {
            return check httpResponse.getJsonPayload();
        }
        error err => {
            return err;
        }
    }
}

function IdeaMartConnector::subscriberRegister(string subscriberId) returns string|error {
    endpoint http:Client httpClient = self.client;
    http:Request request = new;
    json msg = { "applicationId" : self.config.applicationId, "password" : self.config.password,
                 "action" : "1", "subscriberId" : subscriberId};
    request.setJsonPayload(untaint msg);
    var response = httpClient->post("/subscription/send", request);
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

function IdeaMartConnector::subscriberUnregister(string subscriberId) returns string|error {
    endpoint http:Client httpClient = self.client;
    http:Request request = new;
    json msg = { "applicationId" : self.config.applicationId, "password" : self.config.password,
                 "action" : "0", "subscriberId" : subscriberId};
    request.setJsonPayload(untaint msg);
    var response = httpClient->post("/subscription/send", request);
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

function IdeaMartConnector::locate(string subscriberId) returns LocateResult|error {
    endpoint http:Client httpClient = self.client;
    http:Request request = new;
    json msg = { "applicationId" : self.config.applicationId, "password" : self.config.password,
                 "subscriberId" : subscriberId, "serviceType": "IMMEDIATE" };
    request.setJsonPayload(untaint msg);
    var response = httpClient->post("/lbs/locate", request);
    match response {
        http:Response httpResponse => {
            return check <LocateResult> check httpResponse.getJsonPayload();
        }
        error err => {
            return err;
        }
    }
}

