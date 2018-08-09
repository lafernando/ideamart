public type Client object {
    
    public IdeaMartConnector ideaMartConnector;

    public function init(IdeaMartConfiguration config) {
        self.ideaMartConnector = new(config);
    }

    public function getCallerActions() returns IdeaMartConnector {
        return self.ideaMartConnector;
    }

}

public type IdeaMartConfiguration record {
    string applicationId;
    string password;
}


