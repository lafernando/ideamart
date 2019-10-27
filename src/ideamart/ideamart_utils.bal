# Creates API invocation failure Error.
#
# + inboundError - raw operation error
# + return - module specific error
function createApiInvokeError(error inboundError) returns error {
    string errMsg = <@untainted> <string> inboundError.detail()?.message;
    error err = error(IDEAMART_ERROR_CODE, message = "Error occurred while invoking the REST API: " + errMsg);
    return err;
}

# Creates payload access failure Error.
#
# + inboundError - raw operation error
# + return - module specific error
function createPayloadAccessError(error inboundError) returns error {
    string errMsg = <@untainted> <string> inboundError.detail()?.message;
    error err = error(IDEAMART_ERROR_CODE, message = "Error occurred while accessing the response payload: " + errMsg);
    return err;
}
