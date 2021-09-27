class SubscriptionController < ApplicationController
    def index
        @step = 1
        @errorMessage = ""
    end
    def addSubscriptionContract
        @errorMessage = ""
        response = helpers.AddSubscriptionContract(params[:msisdn], params[:operatorCode])
        if(response["operationStatusCode"] == 0)
            @step = 2
            @subscriptionContractId = response["subscriptionContractId"].to_s
        else
            @step = 1
            @errorMessage = response["errorMessage"]
        end
        puts @step
        render :index
    end
    def verifySubscription
        @errorMessage = ""
        helpers.VerifySubscriptionContract(params[:pinCode], params[:subscriptionContractId])
        if(response["operationStatusCode"] == 0)
            @step = 3
        else
            @step = 2
            @errorMessage = response["errorMessage"]
        end
        render :index
    end 
end
