#!/usr/bin/env python
import boto3
import time
import os


def get_region():
    if 'AWS_DEFAULT_REGION' in os.environ.keys():
        return os.environ['AWS_DEFAULT_REGION']
    else:
        return 'eu-west-1'


def get_ec2_client():
    return boto3.client('ec2', region_name=get_region())


def get_ssm_client():
    return boto3.client('ssm', region_name=get_region())


def instance_list():
    ec2 = get_ec2_client()
    response = ec2.describe_instances(
        Filters=[
            {'Name': 'tag-key', 'Values': ['Role']},
            {'Name': 'tag-value', 'Values': ['f_test_app']},
            {'Name': 'instance-state-name', 'Values': ['running']}
        ]
    )
    return [[i['InstanceId'] for i in reservations['Instances']] for
            reservations in response['Reservations']].pop()


def run_command():
    ssm = get_ssm_client()
    instance_ids = instance_list()
    print(instance_ids)
    for id in instance_ids:
        ssm_run_command = ssm.send_command(
            InstanceIds=[id],
            DocumentName='AWS-RunShellScript',
            Parameters={'commands': ['/usr/local/bin/deploy.sh']}
        )
        status = 'Pending'
        while status == 'Pending' or status == 'InProgress':
            time.sleep(2)
            status = ssm.list_commands(
                CommandId=ssm_run_command['Command']['CommandId'])[
                    'Commands'][0]['Status']
        if status == 'Failed':
            print("Failed to deploy on InstanceId : {}".format(id))
        else:
            print("Deployment {} on InstanceId : {}".format(status, id))


def main():
    run_command()


if __name__ == "__main__":
    main()
