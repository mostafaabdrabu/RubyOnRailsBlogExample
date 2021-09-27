require "uri"
require 'openssl'
require "net/http"
require "date"
require "addSubscriptionContractRequest"
module SubscriptionHelper
    @@baseUrl = "http://staging.tpay.me/api/TPAYSubscription.svc/json/"
    def AddSubscriptionContract(msisdn, operatorCode)
        uri = URI(@@baseUrl+'AddSubscriptionContractRequest')
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
        addSubscriptionContractRequest = AddSubscriptionContractRequest.new
        addSubscriptionContractRequest.customerAccountNumber = "mostafa-test"
        addSubscriptionContractRequest.msisdn= msisdn
        addSubscriptionContractRequest.operatorCode= operatorCode
        addSubscriptionContractRequest.subscriptionPlanId= 3
        addSubscriptionContractRequest.initialPaymentproductId= "100Points"
        addSubscriptionContractRequest.initialPaymentDate= DateTime.now.strftime() + "Z"
        addSubscriptionContractRequest.executeInitialPaymentNow= false
        addSubscriptionContractRequest.executeRecurringPaymentNow= false
        addSubscriptionContractRequest.recurringPaymentproductId= "100Points"
        addSubscriptionContractRequest.productCatalogName= "HETest"
        addSubscriptionContractRequest.autoRenewContract= false
        addSubscriptionContractRequest.sendVerificationSMS= true
        addSubscriptionContractRequest.allowMultipleFreeStartPeriods= false
        addSubscriptionContractRequest.contractStartDate= DateTime.now.strftime() + "Z"
        addSubscriptionContractRequest.contractEndDate= DateTime.now.next_year(1).strftime() + "Z"
        addSubscriptionContractRequest.language= 1
        addSubscriptionContractRequest.headerEnrichmentReferenceCode= ""
        addSubscriptionContractRequest.smsId= ""
        addSubscriptionContractRequest.signature = calculate_digest(addSubscriptionContractRequest.message)
        req.body = addSubscriptionContractRequest.to_json
        puts req.body
        res = http.request(req)
        puts "response #{res.body}"
        response = JSON.parse(res.body)
    rescue => e
        puts "failed #{e}"
    end
    def VerifySubscriptionContract(subscriptionContractId, pinCode)
        uri = URI(@@baseUrl+'VerifySubscriptionContract')
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
        verifySubscriptionContract = VerifySubscriptionContract.new
        verifySubscriptionContract.subscriptionContractId = subscriptionContractId
        verifySubscriptionContract.pinCode = pinCode
        verifySubscriptionContract.signature = calculate_digest(verifySubscriptionContract.message)
        req.body = verifySubscriptionContract.to_json
        puts req.body
        res = http.request(req)
        puts "response #{res.body}"
        response = JSON.parse(res.body)
    rescue => e
        puts "failed #{e}"
    end
private
    def calculate_digest(message)
        pub = "0oa70WuefiddqLjqlTlp"
        key = "m2vQxqNixqrEDcQ2heVr"
        hash = OpenSSL::HMAC.hexdigest("SHA256", key, message)
        sig = pub + ":" + hash
    end
end
