#!/usr/bin/python
import json
import sys

from aliyunsdkcore.client import AcsClient
from aliyunsdkecs.request.v20140526 import DescribePriceRequest


def getPrice(instanceType, disk='0', unit = 'Month'):

    # initialize the client
    client = AcsClient( 'key', 'secret','eu-central-1' )

    # Create a request and set parameters
    request = DescribePriceRequest.DescribePriceRequest()
    request.set_InstanceType(instanceType)
    request.set_PriceUnit(unit)
    request.set_SystemDiskSize(disk)

    # Initiate the request and print the response
    response = client.do_action_with_exception(request)

   # result = json.loads(json.dumps(response))
   # print(result)

    result = json.loads(response)
    return result
