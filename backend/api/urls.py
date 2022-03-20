from django.urls import path

from api.views import DoctorAPIView

urlpatterns = [
    path('', DoctorAPIView.as_view()),
]