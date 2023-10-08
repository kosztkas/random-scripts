#!/usr/bin/env python
#coding=utf-8

from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.acs_exception.exceptions import ClientException
from aliyunsdkcore.acs_exception.exceptions import ServerException
from aliyunsdkram.request.v20150501.CreateRoleRequest import CreateRoleRequest

client = AcsClient('<accessKeyId>', '<accessSecret>', 'eu-west-1')

#with open('sso.txt', 'r') as file:
#    ssopolicy = file.read().replace('\n', '')

ssopolicy = '{ "Statement": [ { "Action": "sts:AssumeRole", "Effect": "Allow", "Principal": { "Federated": [ "acs:ram::###:saml-provider/ExternalSiteminderIDP" ] }, "Condition":{ "StringEquals":{ "saml:recipient":"https://signin.alibabacloud.com/saml-role/sso" } } } ], "Version": "1" }'

request = CreateRoleRequest()
request.set_accept_format('json')

request.set_RoleName("Administrator")
request.set_AssumeRolePolicyDocument(ssopolicy)
request.set_Description("Administrator Role for SSO access")

response = client.do_action_with_exception(request)


# python2:  print(response) 
print(str(response, encoding='utf-8'))
