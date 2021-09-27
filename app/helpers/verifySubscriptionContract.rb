class VerifySubscriptionContract
 
    attr_accessor  :signature,
                   :pinCode,
                   :subscriptionContractId
    
    def message
        @subscriptionContractId + @pinCode
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