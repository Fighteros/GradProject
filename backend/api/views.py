from rest_framework import generics
from doctor.models import Doctor
from .serializers import DoctorSerializer


# Create your views here.

class DoctorAPIView(generics.ListAPIView):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer
