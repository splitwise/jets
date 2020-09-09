describe Jets::Resource::Iam::ClassRole do
  let(:role) do
    Jets::Resource::Iam::ClassRole.new(PostsController)
  end

  context "iam policy" do
    it "inherits from the application wide iam policy" do
      # pp role.policy_document # uncomment to debug
      expect(role.policy_document).to eq(
                                        {"Version" => "2012-10-17",
                                         "Statement" =>
                                           [{"Action" => ["lambda:*"], "Effect" => "Allow", "Resource" => "*"},
                                            {"Action" => ["logs:*"], "Effect" => "Allow", "Resource" => "*"},
                                            {"Action" => ["logs:*"],
                                             "Effect" => "Allow",
                                             "Resource" =>
                                               "arn:aws:logs:us-east-1:123456789:log-group:/aws/lambda/demo-test-*"},
                                            {"Action" => ["s3:Get*", "s3:List*"],
                                             "Effect" => "Allow",
                                             "Resource" => "arn:aws:s3:::fake-test-s3-bucket*"},
                                            {"Action" => ["s3:ListAllMyBuckets", "s3:HeadBucket"],
                                             "Effect" => "Allow",
                                             "Resource" => "arn:aws:s3:::*"},
                                            {"Action" =>
                                               ["cloudformation:DescribeStacks",
                                                "cloudformation:DescribeStackResources"],
                                             "Effect" => "Allow",
                                             "Resource" =>
                                               "arn:aws:cloudformation:us-east-1:123456789:stack/demo-test*"}]}
                                      )
    end

    context 'permission boundaries' do
      let(:managed_iam_policy) { "AWSCloudFormationReadOnlyAccess" }
      let(:iam_policy) { nil }

      before do
        allow(Jets.config).to receive(:iam_policy).and_return(iam_policy)
        allow(Jets.config).to receive(:managed_iam_policy).and_return(managed_iam_policy)
        allow(Jets.config).to receive(:permissions_boundary).and_return(permissions_boundary)
      end
      context 'when a permissions boundary is set' do
        let(:permissions_boundary) { "AWSEC2ReadOnlyAccess" }

        it "expands correctly" do
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
end
