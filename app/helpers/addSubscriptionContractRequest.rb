class AddSubscriptionContractRequest
 
    attr_accessor  :signature,
                   :customerAccountNumber, 
                   :msisdn, 
                   :operatorCode, 
                   :subscriptionPlanId,
                   :initialPaymentproductId,
                   :initialPaymentDate,
                   :executeInitialPaymentNow,
                   :executeRecurringPaymentNow,
                   :recurringPaymentproductId,
                   :productCatalogName,
                   :autoRenewContract,
                   :sendVerificationSMS,
                   :allowMultipleFreeStartPeriods,
                   :contractStartDate,
                   :contractEndDate,
                   :language,
                   :headerEnrichmentReferenceCode,
                   :smsId
    
    def message
        @customerAccountNumber + @msisdn + @operatorCode + @subscriptionPlanId.to_s +
        @initialPaymentproductId.to_s + @initialPaymentDate +  @executeInitialPaymentNow.to_s +
        @recurringPaymentproductId.to_s + @productCatalogName + @executeRecurringPaymentNow.to_s +
        @contractStartDate + @contractEndDate + @autoRenewContract.to_s + @language.to_s +
        @sendVerificationSMS.to_s + @allowMultipleFreeStartPeriods.to_s +
        @headerEnrichmentReferenceCode + @smsId
    end
    def to_json
        hash = {}
        self.instance_variables.each do |var|
            key = var.to_s.tr('@', '')
            hash[key] = self.instance_variable_get var
        end
        hash.to_json
    end
end