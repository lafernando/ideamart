public type Client object {
    
    public IdeaMartConnector ideaMartConnector;

    public function init(IdeaMartConfiguration config) {
        self.ideaMartConnector = new;
        self.ideaMartConnector.init(config);
    }

    public function getCallerActions() returns IdeaMartConnector {
        return self.ideaMartConnector;
    }

};

public type IdeaMartConfiguration record {
    string applicationId;
    string password;
    string baseURL;
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

