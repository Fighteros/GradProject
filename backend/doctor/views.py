import json

from django.shortcuts import render
from django.http import JsonResponse
from django.core import serializers
from .models import Doctor
# Create your views here.


# this returns all doctors in the system
def doctor_list(request):
    doctor_list = list(Doctor.objects.values())
    return JsonResponse(doctor_list, safe=False)
