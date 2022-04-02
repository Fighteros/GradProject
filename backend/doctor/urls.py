from django.urls import path

from .views import doctor_list

urlpatterns = [
    path('', doctor_list , name="doctorList"),
]