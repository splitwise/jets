describe Jets::Resource::Iam::ApplicationRole do
  let(:role) { Jets::Resource::Iam::ApplicationRole.new }
  let(:managed_iam_policy) { "AWSCloudFormationReadOnlyAccess" }
  let(:iam_policy) { nil }

  before do
    allow(Jets.config).to receive(:iam_policy).and_return(iam_policy)
    allow(Jets.config).to receive(:managed_iam_policy).and_return(managed_iam_policy)
    allow(Jets.config).to receive(:permissions_boundary).and_return(permissions_boundary)
  end

  describe "iam policy" do
    context 'when a permissions boundary is set' do
      let(:permissions_boundary) { "AWSEC2ReadOnlyAccess" }

      it "expands correctly" do
        # pp role.definition # uncomment to debug

        expect(role.definition[role.definition.keys.first]).to match(
          {type: 'AWS::IAM::Role',
           properties: hash_including(
             permissions_boundary: permissions_boundary,
             managed_policy_arns: match_array(/arn:aws.*#{managed_iam_policy}/)
           )}
        )
      end
    end

    context 'when a permissions boundary is not set' do
      let(:permissions_boundary) { nil }

      it "expands correctly" do
        # pp role.definition # uncomment to debug

        expect(role.definition[role.definition.keys.first][:properties]).not_to include(
          :permissions_boundary
        )
      end
    end
  end
end
