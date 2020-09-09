describe Jets::Resource::Iam::ManagedPolicy do
  let(:permissions_boundary) do
    Jets::Resource::Iam::PermissionsBoundary.new(definition)
  end

  context "single string" do
    let(:definition) { "AmazonEC2ReadOnlyAccess" }
    it "does not prepend anything" do
      expect(permissions_boundary.arn).to eq definition
    end
  end

  context "full arn provided" do
    let(:definition) { "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess" }
    it "provides the iam managed policy arn" do
      expect(permissions_boundary.arn).to eq "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
    end
  end
end
