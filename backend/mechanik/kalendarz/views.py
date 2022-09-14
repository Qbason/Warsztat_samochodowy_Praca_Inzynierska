from re import template
from django.template import loader
from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse


def index(request):
    context={}
    template = loader.get_template('index.html')
    return HttpResponse(template.render(context,request))