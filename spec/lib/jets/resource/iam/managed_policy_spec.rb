describe Jets::Resource::Iam::ManagedPolicy do
  let(:managed_policy) do
    Jets::Resource::Iam::ManagedPolicy.new(definitions)
  end

  context "single string" do
    let(:definitions) { "AmazonEC2ReadOnlyAccess" }
    it "builds the resource definition" do
      expect(managed_policy.arns).to eq ["arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"]
    end
  end

  context "multiple strings" do
    let(:definitions) { ["AmazonEC2ReadOnlyAccess", "service-role/AWSConfigRulesExecutionRole"] }
    it "provides the iam managed policy arn" do
      expect(managed_policy.arns).to eq [
        "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
        "arn:aws:iam::aws:policy/service-role/AWSConfigRulesExecutionRole",
      ]
    end
  end

  context "full arn provided" do
    let(:definitions) { ["arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"] }
    it "provides the iam managed policy arn" do
      expect(managed_policy.arns).to eq [
        "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
      ]
    end
  end

  context "customer-managed policy" do
    let(:definitions) { ["arn:aws:iam::1828372:policy/MyCustomerManagedPolicy"] }
    it "provides the iam managed policy arn" do
      expect(managed_policy.arns).to eq [
        "arn:aws:iam::1828372:policy/MyCustomerManagedPolicy",
      ]
    end
  end
end
