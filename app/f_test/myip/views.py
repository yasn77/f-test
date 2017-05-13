from django.shortcuts import render
from django.http import HttpResponse
from ipware.ip import get_ip


def index(request):
    ip = get_ip(request)
    return HttpResponse("Hi, looks like your IP is {}".format(ip))
