---
title: Permission Boundaries
nav_order: 16.5
---

[Permissions Boundaries](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) can be used to set the maximum allowed permissions for users and roles. Jets supports attaching a Permissions Boundary to IAM roles created by the deploy role.

## Setting a Permissions Boundary

```ruby
Jets.application.configure do |config|
  config.permissions_boundary = "MyPermissionsBoundary"
end
```

The resulting role will look something like this:

```yaml
IamRole:
  Type: AWS::IAM::Role
  Properties:
    PermissionsBoundary: "arn:aws:iam:aws:policy/MyPermissionsBoundary"
```

{% include prev_next.md %}
