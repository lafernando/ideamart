import ballerina/http;

#Ideamart client object.
public type Client client object {

    http:Client ideaMartClient;
    IdeaMartConfiguration config;

    public function __init(IdeaMartConfiguration ideaMartConfig) {
        self.config = ideaMartConfig;
        self.ideaMartClient = new (ideaMartConfig.baseURL, ideaMartConfig.clientConfig);
    }

    public remote function sendSMS(string[] destinationAddrs, string message, string sourceAddr) returns string|error {
        http:Request request = new;
        json msg = { "message" : message, "destinationAddresses" : <json> destinationAddrs,
                     "applicationId" : self.config.applicationId,
                     "password" : self.config.password };
        request.setJsonPayload(<@untainted> msg);
        var response = self.ideaMartClient->post("/sms/send", request);
        if (response is http:Response) {
            var payload = response.getJsonPayload();
            if (payload is json) {
                return <@untainted> <string> payload.statusCode;
            } else {
                return createPayloadAccessError(payload);
            }
        } else {
            return createApiInvokeError(response);
        }
    }

    public remote function receiveSMS(string sourceAddr, string message, string requestId) returns json|error {
        http:Request request = new;
        json msg = { "message" : message, "sourceAddress" : sourceAddr,
                     "requestId" : requestId, "encoding" : "0", "version" : "1.0",
                     "applicationId" : self.config.applicationId,
                     "password" : self.config.password };
        request.setJsonPayload(<@untainted> msg);
        var response = self.ideaMartClient->post("/sms/send", request);
        if (response is http:Response) {
            var payload = response.getJsonPayload();
            if (payload is json) {
                return <@untainted> payload;
            } else {
                return createPayloadAccessError(payload);
            }
        } else {
            return createApiInvokeError(response);
        }
    }

    public remote function subscriberRegister(string subscriberId) returns string|error {
        http:Request request = new;
        json msg = { "applicationId" : self.config.applicationId, "password" : self.config.password,
                     "action" : "1", "subscriberId" : subscriberId};
        request.setJsonPayload(<@untainted> msg);
        var response = self.ideaMartClient->post("/subscription/send", request);
        if (response is http:Response) {
            var payload = response.getJsonPayload();
            if (payload is json) {
                return <@untainted> <string> payload.statusCode;
            } else {
                return createPayloadAccessError(payload);
            }
        } else {
            return createApiInvokeError(response);
        }
    }

    public remote function subscriberUnregister(string subscriberId) returns string|error {
        http:Request request = new;
        json msg = { "applicationId" : self.config.applicationId, "password" : self.config.password,
                     "action" : "0", "subscriberId" : subscriberId};
        request.setJsonPayload(<@untainted> msg);
        var response = self.ideaMartClient->post("/subscription/send", request);
        if (response is http:Response) {
            var payload = response.getJsonPayload();
            if (payload is json) {
                return <@untainted> <string> payload.statusCode;
            } else {
                return createPayloadAccessError(payload);
            }
        } else {
            return createApiInvokeError(response);
        }
    }

    public remote function locate(string subscriberId) returns LocateResult|error {
        http:Request request = new;
        json msg = { "applicationId" : self.config.applicationId, "password" : self.config.password,
                     "subscriberId" : subscriberId, "serviceType": "IMMEDIATE" };
        request.setJsonPayload(<@untainted> msg);
        var response = self.ideaMartClient->post("/lbs/locate", request);
        if (response is http:Response) {
            var payload = response.getJsonPayload();
            if (payload is json) {
                var locateResult = LocateResult.constructFrom(payload);
                if (locateResult is LocateResult) {
                    return <@untainted> locateResult;
                } else {
                    error err = error(IDEAMART_ERROR_CODE,
                                        message = <@untainted> <string> locateResult.detail()?.message);
                    return err;
                }
            } else {
                return createPayloadAccessError(payload);
            }
        } else {
            return createApiInvokeError(response);
        }
    }

};

public type IdeaMartConfiguration record {
    string baseURL;
    string applicationId;
    string password;
    http:ClientConfiguration clientConfig = {};
};

public type LocateResult record {
    string statusCode;
    string timeStamp;
    string subscriberState;
    string statusDetail;
    string horizontalAccuracy;
    string longitude;
    string freshness;
    string latitude;
    string messageId;
};
